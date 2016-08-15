//
//  ArmViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ArmViewController.h"
#import "Masonry.h"
@interface ArmViewController ()
@property (nonatomic, copy)NSArray *arrTitle;
@property (nonatomic, copy)NSURL *SURL;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *imageView;
@property (nonatomic, strong)UIView *daView;
@property (nonatomic, copy)NSArray *arrNanDu;
@property (nonatomic, copy)NSArray *arrTime;
@property (nonatomic, strong)UIImage *image;
@end

@implementation ArmViewController
- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"塑形·胸部训练",@"塑形·背部训练",@"塑形·肩部训练",@"塑形·手臂训练",@"拉伸",@"塑形·腿部训练",@"塑形·臀部训练",@"塑形·腹肌训练",@"轻松塑形",@"塑形·腹肌循环训练"];
    }
    return _arrTitle;
}
- (NSArray *)arrNanDu {
    if (!_arrNanDu) {
        _arrNanDu = @[@"难度: ⭐️",@"难度: ⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️"];
    }
    return _arrNanDu;
}

- (NSArray *)arrTime {
    if (!_arrTime) {
        _arrTime = @[@"时间: 07:20",@"时间: 06:55",@"时间: 08:54",@"时间: 11:25",@"时间: 09:54",@"时间: 08:24",@"时间: 05:34",@"时间: 08:15",@"时间: 04:52",@"时间: 12:09"];
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
    CGFloat scrollHeight = (ImgbtnHeight+50)*10+80;
    
    
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
    for (NSUInteger index = 0; index < 10; index ++) {
        UIButton *imageBtn = [[UIButton alloc] init];
        [self.daView addSubview:imageBtn];
        imageBtn.frame = CGRectMake(ImgbtnX, ImgbtnY + (ImgbtnHeight + 50)*index, ImgbtnWidth, ImgbtnHeight);
        NSString *img = [NSString stringWithFormat:@"jiating_%ld",index];
        [imageBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        imageBtn.userInteractionEnabled =YES;
        imageBtn.layer.cornerRadius = 8;
        imageBtn.layer.masksToBounds = YES;
        imageBtn.backgroundColor = [UIColor blackColor];
        [imageBtn addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *xiaoView = [[UIView alloc] init];
        [self.daView addSubview:xiaoView];
        xiaoView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        [xiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(imageBtn);
            make.top.equalTo(imageBtn.mas_bottom).offset(-5);
            make.height.equalTo(@(35));
            make.width.equalTo(imageBtn);
        }];

        
        UIButton *btn = [[UIButton alloc] init];
        [imageBtn addSubview:btn];
        btn.tag = 10 + index;
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        btn.frame = CGRectMake((ImgbtnWidth-50)/2, (ImgbtnHeight-50)/2, 50, 50);
        [btn addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbl = [[UILabel alloc] init];
        [imageBtn addSubview:lbl];
        [lbl setText:self.arrTitle[index]];
        [lbl setTextColor:[UIColor redColor]];
        lbl.frame = CGRectMake(0, 0, 200, 50);
        [lbl setFont:font3];
        
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
- (void)PlayAction:(UIButton *)button {
    if (button.tag == 10) {
        NSString *strURL = @"http://qv1.fit-time.cn/v17.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 11){
        NSString *strURL = @"http://qv1.fit-time.cn/v18.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 12){
        NSString *strURL = @"http://qv1.fit-time.cn/v19.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 13){
        NSString *strURL = @"http://qv1.fit-time.cn/v20.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 14){
        NSString *strURL = @"http://qv1.fit-time.cn/v21.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 15){
        NSString *strURL = @"http://qv1.fit-time.cn/v22.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 16){
        NSString *strURL = @"http://qv1.fit-time.cn/v23.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 17){
        NSString *strURL = @"http://qv1.fit-time.cn/v24.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 18){
        NSString *strURL = @"http://qv1.fit-time.cn/v25.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else {
        NSString *strURL = @"http://qv1.fit-time.cn/v26.mp4";
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
