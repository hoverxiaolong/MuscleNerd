//
//  DeltoidViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DeltoidViewController.h"
#import "UIButton+WebCache.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "DietCell.h"

@interface DeltoidViewController ()
@property (nonatomic, copy)NSArray *arrTime;
@property (nonatomic, copy)NSArray *arrTitle;
@property (nonatomic, copy)NSArray *arrNanDu;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *imageBtn;
@property (nonatomic, strong)UIView *daView;
@property (nonatomic, strong)UILabel *lblTimes;
@property (nonatomic, strong)UILabel *lblDianZan;
@property (nonatomic, copy)NSURL *SURL;
@end

@implementation DeltoidViewController


- (NSArray *)arrNanDu {
    if (!_arrNanDu) {
        _arrNanDu = @[@"难度: ⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度:⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️"];
    }
    return _arrNanDu;
}

- (NSArray *)arrTime {
    if (!_arrTime) {
        _arrTime = @[@"时间: 06:04",@"时间: 05:56",@"时间: 06:13",@"时间: 06:35",@"时间: 06:12",@"时间: 03:24",@"时间: 06:16",@"时间: 06:09",@"时间: 06:02"];
    }
    return _arrTime;
}

- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"四分钟瘦腿翘臀",@"四分钟紧致臀部",@"四分钟急速燃脂",@"四分钟胸部轰炸",@"四分钟加速代谢",@"四分钟核心翘臀",@"四分钟雕塑腿臀",@"四分钟瘦腿收腹",@"四分钟心肺塑形",@"四分钟紧致腿部",@"四分钟紧致腹部",@"四分钟囚徒健身",@"四分钟胸背轰炸",@"四分钟踢出腹肌"];
    }
    return _arrTitle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDefaultSetting];
}
- (void)loadDefaultSetting {
    
    CGFloat ImgbtnWidth = self.view.frame.size.width-30;
    CGFloat ImgbtnX = 15;
    CGFloat ImgbtnY = 80;
    CGFloat ImgbtnHeight = 170;
    CGFloat scrollHeight = (ImgbtnHeight+50)*9+80;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    
    UIView *daView = [[UIView alloc] init];
    [scrollView addSubview:daView];
    _daView = daView;
    daView.frame = CGRectMake(0, 0, self.view.frame.size.width, scrollHeight);
    
    UIFont *font3 = [UIFont boldSystemFontOfSize:20];
    for (NSUInteger index = 0; index < 9; index ++) {
        
        UIButton *imageBtn = [[UIButton alloc] init];
        [self.daView addSubview:imageBtn];
        imageBtn.backgroundColor = [UIColor blackColor];
        imageBtn.frame = CGRectMake(ImgbtnX, ImgbtnY + (ImgbtnHeight + 50)*index, ImgbtnWidth, ImgbtnHeight);
        imageBtn.userInteractionEnabled =YES;
        imageBtn.contentMode = UIViewContentModeCenter;
        [imageBtn addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        NSString *strImage = [NSString stringWithFormat:@"sifenzhong_%ld",index];
        [imageBtn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
        imageBtn.layer.cornerRadius = 8;
        imageBtn.layer.masksToBounds = YES;
        self.imageBtn = imageBtn;
    
        UIButton *btn = [[UIButton alloc] init];
        [imageBtn addSubview:btn];
        btn.tag = 10 + index;
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        btn.frame = CGRectMake((ImgbtnWidth-50)/2, (ImgbtnHeight-50)/2, 50, 50);
        [btn addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbl = [[UILabel alloc] init];
        [imageBtn addSubview:lbl];
        [lbl setText:self.arrTitle[index]];
        [lbl setTextColor:[UIColor whiteColor]];
        lbl.frame = CGRectMake(0, 0, 150, 50);
        [lbl setFont:font3];
        
        UIView *xiaoView = [[UIView alloc] init];
        [self.daView addSubview:xiaoView];
        xiaoView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        [xiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(imageBtn);
            make.top.equalTo(imageBtn.mas_bottom).offset(-5);
            make.height.equalTo(@(35));
            make.width.equalTo(imageBtn);
        }];
        UILabel *lblTimes = [[UILabel alloc]init];
        [xiaoView addSubview:lblTimes];
        lblTimes.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 35);
        _lblTimes = lblTimes;
        [lblTimes setText:self.arrNanDu[index]];
        UILabel *lblDianZan = [[UILabel alloc]init];
        [xiaoView addSubview:lblDianZan];
        lblDianZan.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 35);
        _lblDianZan = lblDianZan;
        [lblDianZan setText:self.arrTime[index]];

}
    [self.scrollView setContentSize: self.daView.frame.size];
}
    
- (void)PlayAction:(UIButton *)button {
    if (button.tag == 10) {
        NSString *strURL = @"http://qv1.fit-time.cn/v1.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 11){
        NSString *strURL = @"http://qv1.fit-time.cn/v2.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 12){
        NSString *strURL = @"http://qv1.fit-time.cn/v3.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 13){
        NSString *strURL = @"http://qv1.fit-time.cn/v4.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 14){
        NSString *strURL = @"http://qv1.fit-time.cn/v5.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 15){
        NSString *strURL = @"http://qv1.fit-time.cn/v6.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 16){
        NSString *strURL = @"http://qv1.fit-time.cn/v7.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 17){
        NSString *strURL = @"http://qv1.fit-time.cn/v8.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else {
        NSString *strURL = @"http://qv1.fit-time.cn/v9.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }
    self.playerViewController = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:_SURL];
    
    self.playerViewController.player = player;
    self.playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerViewController.player play];
    [self presentViewController:self.playerViewController animated:YES completion:^{
        
    }];
}


@end
