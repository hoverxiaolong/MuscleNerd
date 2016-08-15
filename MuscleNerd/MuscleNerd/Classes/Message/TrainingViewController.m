//
//  TrainingViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TrainingViewController.h"
#import "Masonry.h"
@interface TrainingViewController ()
@property (nonatomic, copy)NSArray *arrTitle;
@property (nonatomic, copy)NSURL *URL;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIButton *imageView;
@property (nonatomic, strong)UIView *daView;
@property (nonatomic, copy)NSArray *arrNanDu;
@property (nonatomic, copy)NSArray *arrTime;

@end

@implementation TrainingViewController

- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"肩部热身",@"腰部热身",@"膝关节热身"];
    }
    return _arrTitle;
}
- (NSArray *)arrNanDu {
    if (!_arrNanDu) {
        _arrNanDu = @[@"难度: ⭐️",@"难度: ⭐️",@"难度: ⭐️"];
    }
    return _arrNanDu;
}

- (NSArray *)arrTime {
    if (!_arrTime) {
        _arrTime = @[@"时间: 5:57",@"时间: 06:36",@"时间: 06:39"];
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
    CGFloat ImgbtnHeight = 180;
    CGFloat scrollHeight = (ImgbtnHeight+50)*3+90;
    
    
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
    for (NSUInteger index = 0; index < 3; index ++) {
        UIButton *imageBtn = [[UIButton alloc] init];
        [self.daView addSubview:imageBtn];
        
        NSString *strImage = [NSString stringWithFormat:@"resheng_%ld",index];
        [imageBtn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
        imageBtn.frame = CGRectMake(ImgbtnX, ImgbtnY + (ImgbtnHeight + 50)*index, ImgbtnWidth, ImgbtnHeight);
        imageBtn.userInteractionEnabled =YES;
        imageBtn.layer.cornerRadius = 8;
        imageBtn.layer.masksToBounds = YES;
        [imageBtn addTarget:self action:@selector(AVPlayerAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn = [[UIButton alloc] init];
        [imageBtn addSubview:btn];
        btn.tag = 100 + index;
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        btn.frame = CGRectMake((ImgbtnWidth-50)/2, (ImgbtnHeight-50)/2, 50, 50);
        [btn addTarget:self action:@selector(AVPlayerAction:) forControlEvents:UIControlEventTouchUpInside];
       
        UILabel *lbl = [[UILabel alloc] init];
        [imageBtn addSubview:lbl];
        [lbl setText:self.arrTitle[index]];
        [lbl setTextColor:[UIColor redColor]];
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
- (void)AVPlayerAction:(UIButton *)button {
    if (button.tag == 100) {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-119.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 101){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-120.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 102){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-121.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else if (button.tag == 103){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-122.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _URL = url;
    }else {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-123.mp4";
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
