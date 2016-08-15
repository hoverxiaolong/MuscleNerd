//
//  HomeViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HMViewController.h"
#import "TrainingViewController.h"
#import "PectoralesViewController.h"
#import "WaistViewController.h"
#import "DeltoidViewController.h"
#import "ArmViewController.h"
#import "Masonry.h"
@interface HMViewController () <UIScrollViewDelegate>
{
    __weak UIScrollView *_scrollView;
    
    __weak UIPageControl *_pageCtr;
}

@property (nonatomic,copy) NSArray *arrButtonImageNames;


@end

@implementation HMViewController

- (NSArray *)arrButtonImageNames {
    if (!_arrButtonImageNames) {
        NSUInteger count = 5;
        NSMutableArray *arrMButtonImageName = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0; index < count; index ++) {
            NSString *strButtonImageName = [NSString stringWithFormat:@"lun_%ld", index];
            [arrMButtonImageName addObject:strButtonImageName];
        }
        _arrButtonImageNames = [arrMButtonImageName copy];
    }
    return _arrButtonImageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allViewLoad];
    self.title = @"推荐";
//自动适应调整ScrollView插入图 为 否
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)allViewLoad {
    
    CGFloat scrollViewY = 0;
    CGFloat scrollViewWidth = self.view.bounds.size.width;
    CGFloat scrollViewHeight = self.view.frame.size.height;
    CGFloat buttonY = 180;
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, scrollViewY, scrollViewWidth, scrollViewHeight);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
     _scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    
    NSUInteger count = self.arrButtonImageNames.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, (65 + 180*index), scrollViewWidth-10, 170)];
        button.layer.cornerRadius = 6;
        button.layer.masksToBounds = YES;
        button.backgroundColor = [UIColor colorWithWhite:0.702 alpha:1.000];
        [button setBackgroundImage:[UIImage imageNamed:self.arrButtonImageNames[index]] forState:UIControlStateNormal];
        [_scrollView addSubview:button];
        button.tag = index + 10;
        [button addTarget:self action:@selector(lineAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _scrollView.contentSize = CGSizeMake(0, count*buttonY + 140);
    _scrollView.showsHorizontalScrollIndicator = NO;

    UILabel *lbl = [[UILabel alloc] init];
    [_scrollView addSubview:lbl];
    [lbl setText:@"《《 更多内容敬请期待 》》"];
    lbl.frame = CGRectMake((self.view.frame.size.width-200)/2, count*buttonY + 40, 200, 70);
    
}
- (void)lineAction:(UIButton *)button {
    if (button.tag == 10) {
        DeltoidViewController *deltoidView = [[DeltoidViewController alloc] init];
        [deltoidView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:deltoidView animated:YES];
    }
    if (button.tag == 11) {
        PectoralesViewController *pectorales = [[PectoralesViewController alloc] init];
        [pectorales setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:pectorales animated:YES];
    }
    if (button.tag == 12) {
        WaistViewController *WaistView = [[WaistViewController alloc] init];
        [WaistView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:WaistView animated:YES];
    }
    if (button.tag == 13) {
        TrainingViewController *trainView = [TrainingViewController new];
        [trainView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:trainView animated:YES];
     
    }
    if (button.tag == 14) {
        ArmViewController *armView = [[ArmViewController alloc] init];
        [armView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:armView animated:YES];
    }
}
@end
