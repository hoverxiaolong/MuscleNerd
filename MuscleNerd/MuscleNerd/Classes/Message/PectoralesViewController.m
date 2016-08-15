//
//  PectoralesViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "PectoralesViewController.h"
#import "Masonry.h"
#import "AllTableViewCell.h"
@interface PectoralesViewController ()

@property (nonatomic, copy)NSArray *arrTitle;
@property (nonatomic, copy)NSArray *arrNanDu;
@property (nonatomic, copy)NSArray *arrTime;
@property (nonatomic, copy)NSURL *URL;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *imageBtn;
@property (nonatomic, strong)UIView *daView;

@end

@implementation PectoralesViewController

- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"下肢训练一",@"全身训练一",@"核心训练一",@"下肢训练二",@"全身训练二",@"核心训练二"];
    }
    return _arrTitle;
}
- (NSArray *)arrNanDu {
    if (!_arrNanDu) {
        _arrNanDu = @[@"难度: ⭐️⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️⭐️"];
    }
    return _arrNanDu;
}

- (NSArray *)arrTime {
    if (!_arrTime) {
        _arrTime = @[@"时间: 17:38",@"时间: 17:39",@"时间: 17:30",@"时间: 17:33",@"时间: 17:29",@"时间: 17:35"];
    }
    return _arrTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)loadDefaultSetting {
    CGFloat ImgbtnWidth = self.view.frame.size.width-16;
    CGFloat ImgbtnX = 8;
    CGFloat ImgbtnY = 80;
    CGFloat ImgbtnHeight = 170;
    CGFloat scrollHeight = (ImgbtnHeight+50)*6+80;
    
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
    for (NSUInteger index = 0; index < 6; index ++) {
        UIButton *imageBtn = [[UIButton alloc] init];
        [self.daView addSubview:imageBtn];
        NSString *strImage = [NSString stringWithFormat:@"xiazhi_%ld",index];
        [imageBtn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
        imageBtn.frame = CGRectMake(ImgbtnX, ImgbtnY + (ImgbtnHeight + 50)*index, ImgbtnWidth, ImgbtnHeight);
        imageBtn.userInteractionEnabled =YES;
        imageBtn.layer.cornerRadius = 8;
        imageBtn.layer.masksToBounds = YES;
        [imageBtn addTarget:self action:@selector(AVPlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn = [[UIButton alloc] init];
        [imageBtn addSubview:btn];
        btn.tag = 100 + index;
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        btn.frame = CGRectMake((ImgbtnWidth-50)/2, (ImgbtnHeight-50)/2, 50, 50);
        [btn addTarget:self action:@selector(AVPlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
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
    
        [lblTimes setText:self.arrNanDu[index]];
        UILabel *lblDianZan = [[UILabel alloc]init];
        [xiaoView addSubview:lblDianZan];
        lblDianZan.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 35);
    
        [lblDianZan setText:self.arrTime[index]];
    }
    [self.scrollView setContentSize: self.daView.frame.size];
}

- (void)AVPlayAction:(UIButton *)button {
    if (button.tag == 100) {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-1.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 101){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-2.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;    
    }else if (button.tag == 102){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-3.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 103){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-4.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 104){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-5.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-jctnxl-6.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }
    self.playerViewController = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:_URL];
    self.playerViewController.player = player;
    self.playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.playerViewController.player play];
    [self presentViewController:self.playerViewController animated:YES completion:^{
        
    }];
}

@end
