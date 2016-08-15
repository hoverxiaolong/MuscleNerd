//
//  WelcomeView.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "WelcomeView.h"
#import "MainViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "MainViewController.h"



//static NSInteger const btnNum = 4;
static NSInteger const line = 2;

@interface WelcomeView ()
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, weak)UIImageView *imageView;

@end

@implementation WelcomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    self.title = @"首页";
    
}
- (void)loadDefaultSetting {
//    self.navigationController.navigationBarHidden = YES;
    
    NSArray *arrBtnImgName = @[@{@"imageName":@"bj.jpg",@"title":@"推荐"},
                               @{@"imageName":@"bj.jpg",@"title":@"训练"},
                               @{@"imageName":@"bj.jpg",@"title":@"发现"},
                               @{@"imageName":@"bj.jpg",@"title":@"更多"},
                               ];
    NSUInteger count = arrBtnImgName.count;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"Welcome_0"]];
    [self.view addSubview:imageView];
    _imageView = imageView;
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(playAction) userInfo:nil repeats:YES];
    
    for (NSUInteger index = 0; index < count; index ++) {
        CGFloat btnViewWidth = 100;
        CGFloat btnViewHeight = 100;
        CGFloat btnViewX = (self.view.frame.size.width/2-btnViewWidth)+(index%line)*btnViewWidth;
        CGFloat btnViewY = self.view.frame.size.height-(60+80)*(2-index / line);
        
        UIView *btnView = [[UIView alloc] init];
        btnView.frame = CGRectMake(btnViewX, btnViewY, btnViewWidth, btnViewHeight);
        [self.view addSubview:btnView];
        UIButton *buttonHM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnViewWidth, btnViewHeight)];
        NSDictionary *dicData = arrBtnImgName[index];
        [buttonHM setTitle:dicData[@"title"] forState:UIControlStateNormal];
        buttonHM.titleLabel.font = [UIFont systemFontOfSize:30];
        buttonHM.tag = index+100;
        [buttonHM addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:buttonHM];
    }
}
- (void)playAction {
    static NSUInteger indexImg = 0;
    indexImg ++;
    if (indexImg == 5) {
        indexImg = 0;
    }
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Welcome_%ld",indexImg]];
}
- (void)buttonAction:(UIButton *)buttonHM {
    
    MainViewController *VCMain = [MainViewController new];
    //自适应内容视图大小关闭
    [VCMain setAutomaticallyAdjustsScrollViewInsets:NO];
    if (buttonHM.tag == 100) {
        VCMain.index = 0;
    }else if(buttonHM.tag ==101){
        VCMain.index = 1;
    }else if (buttonHM.tag == 102){
        VCMain.index = 2;
    } else {
        VCMain.index = 3;
    }
    [self.navigationController pushViewController:VCMain animated:YES];
}
@end
