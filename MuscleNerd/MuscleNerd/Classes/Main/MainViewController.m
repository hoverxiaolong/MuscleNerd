//
//  ViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "HMViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "YNavigationViewController.h"
#import "WelcomeView.h"
@interface MainViewController ()
{
    __weak UIViewController *vcMessag;


}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

- (void)loadDefaultSetting {
    HMViewController *vcHome = [HMViewController new];
    
    [self addViewController:vcHome imageName:@"tabbar_home" title:@"推荐"];
    
    MessageViewController *vcMessage = [MessageViewController new];
    [vcMessage setAutomaticallyAdjustsScrollViewInsets:YES];
    [self addViewController:vcMessage imageName:@"tabbar_message_center" title:@"训练"];
    vcMessag = vcMessage;
    
    DiscoverViewController *vcDiscover = [DiscoverViewController new];
    [self addViewController:vcDiscover imageName:@"tabbar_discover" title:@"发现"];
    
    ProfileViewController *vcProfile = [ProfileViewController new];
    [self addViewController:vcProfile imageName:@"tabbar_profile" title:@"更多"];

    self.tabBar.tintColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:0.696];
    
}

- (void)setIndex:(NSUInteger)index
{
    _index = index;
    self.selectedIndex = index;
}

- (void)addViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title{
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]];
    viewController.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    viewController.tabBarItem.title = title;
    [self addChildViewController:viewController];
}

@end
