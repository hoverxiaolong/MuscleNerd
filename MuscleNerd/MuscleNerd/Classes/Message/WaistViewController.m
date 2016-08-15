//
//  WaistViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "WaistViewController.h"
#import "AllTableViewCell.h"
#import "Masonry.h"
@interface WaistViewController ()
@property (nonatomic, copy)NSArray *arrTitle;
@property (nonatomic, copy)NSURL *SURL;
@property (nonatomic, copy)NSArray *arrNanDu;
@property (nonatomic, copy)NSArray *arrTime;
@end

@implementation WaistViewController
- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"核心轰炸·初级",@"核心轰炸·中级",@"核心轰炸·高级"];
    }
    return _arrTitle;
}
- (NSArray *)arrNanDu {
    if (!_arrNanDu) {
        _arrNanDu = @[@"难度: ⭐️",@"难度: ⭐️⭐️",@"难度: ⭐️⭐️⭐️"];
    }
    return _arrNanDu;
}

- (NSArray *)arrTime {
    if (!_arrTime) {
        _arrTime = @[@"时间: 7:28",@"时间: 7:00",@"时间: 7:27"];
    }
    return _arrTime;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadDefaultSetting];

}

- (void)loadDefaultSetting {
    CGFloat ImgbtnWidth = self.view.frame.size.width-16;
    CGFloat ImgbtnHeight = (self.view.frame.size.height-120-40)/3;
    CGFloat ImgbtnX = 8;
    CGFloat ImgbtnY = 80;
    UIFont *font3 = [UIFont boldSystemFontOfSize:20];
    for (NSUInteger index = 0; index < 3; index ++) {
        UIButton *imageView = [[UIButton alloc] init];
        [self.view addSubview:imageView];
        NSString *strImage = [NSString stringWithFormat:@"renyuxian_%ld",index];
        [imageView setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
        imageView.frame = CGRectMake(ImgbtnX, ImgbtnY + (ImgbtnHeight + 30)*index, ImgbtnWidth, ImgbtnHeight);
        imageView.userInteractionEnabled =YES;
        imageView.layer.cornerRadius = 8;
        imageView.layer.masksToBounds = YES;
        [imageView addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn = [[UIButton alloc] init];
        [imageView addSubview:btn];
        btn.tag = 10 + index;
        [btn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        btn.frame = CGRectMake((ImgbtnWidth-50)/2, (ImgbtnHeight-50)/2, 50, 50);
        [btn addTarget:self action:@selector(PlayAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lbl = [[UILabel alloc] init];
        [imageView addSubview:lbl];
        [lbl setText:self.arrTitle[index]];
        [lbl setTextColor:[UIColor redColor]];
        lbl.frame = CGRectMake(0, 0, 150, 50);
        [lbl setFont:font3];
        
        UILabel *lblTimes = [[UILabel alloc]init];
        [imageView addSubview:lblTimes];
        lblTimes.frame = CGRectMake(0, ImgbtnHeight-40, self.view.frame.size.width/2, 35);
        
        [lblTimes setText:self.arrNanDu[index]];
        UILabel *lblDianZan = [[UILabel alloc]init];
        [imageView addSubview:lblDianZan];
        lblDianZan.frame = CGRectMake(self.view.frame.size.width/2, ImgbtnHeight-40, self.view.frame.size.width/2, 35);
        
        [lblDianZan setText:self.arrTime[index]];
    }
}

- (void)PlayAction:(UIButton *)button {
    if (button.tag == 10) {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-hexinhongzha-133.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else if (button.tag == 11){
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-hexinhongzha-134.mp4";
        NSURL *url = [NSURL URLWithString:strURL];
        _SURL = url;
    }else {
        NSString *strURL = @"http://qv1.fit-time.cn/rockfit-andy-hexinhongzha-135.mp4";
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
