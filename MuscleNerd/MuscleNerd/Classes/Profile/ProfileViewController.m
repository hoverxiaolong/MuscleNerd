//
//  ProfileViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ProfileViewController.h"
#import "Masonry.h"
#import "WebProfileViewController.h"
#import "WebTwoViewController.h"
#import "WebThreeViewController.h"
@interface ProfileViewController ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self loadDefaultSetting];

}

- (void)loadDefaultSetting {
    CGFloat btnWidth = self.view.frame.size.width-16;
    CGFloat btnHeight = (self.view.frame.size.height-140-20)/3;
    CGFloat btnX = 8;
    CGFloat btnY = 80;
    UIButton *firstBtn = [[UIButton alloc]init];
    firstBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self.view addSubview:firstBtn];
    firstBtn.layer.cornerRadius = 6;
    firstBtn.layer.masksToBounds = YES;
    firstBtn.tag = 1;
    [firstBtn setImage:[UIImage imageNamed:@"profile_1"] forState:UIControlStateNormal];
    [firstBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *twoBtn = [[UIButton alloc]init];
    twoBtn.frame = CGRectMake(btnX, btnY+btnHeight+10, btnWidth, btnHeight);
    [self.view addSubview:twoBtn];
    twoBtn.layer.cornerRadius = 6;
    twoBtn.layer.masksToBounds = YES;
    twoBtn.tag = 2;
    [twoBtn setImage:[UIImage imageNamed:@"profile_2"] forState:UIControlStateNormal];
    [twoBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *threeBtn = [[UIButton alloc]init];
    threeBtn.frame = CGRectMake(btnX, btnY+btnHeight*2+20, btnWidth, btnHeight);
    [self.view addSubview:threeBtn];
    threeBtn.layer.cornerRadius = 6;
    threeBtn.layer.masksToBounds = YES;
    threeBtn.tag=3;
    [threeBtn setImage:[UIImage imageNamed:@"profile_3"] forState:UIControlStateNormal];
    [threeBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapAction:(UIButton *)button {
    if (button.tag ==1) {
        WebProfileViewController *web = [[WebProfileViewController alloc]init];
        [self.navigationController pushViewController:web animated:YES];
    }else if (button.tag==2){
        WebTwoViewController *webTwo = [[WebTwoViewController alloc] init];
        [self.navigationController pushViewController:webTwo animated:YES];
    }else {
        WebThreeViewController *webThree = [[WebThreeViewController alloc]init];
        [self.navigationController pushViewController:webThree animated:YES];
    }
   
}
@end
