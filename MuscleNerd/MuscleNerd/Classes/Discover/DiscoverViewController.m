//
//  DiscoverViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DietView.h"
#import "SkillView.h"
#import "MotivationalView.h"
#import "DiscoverWebViewController.h"
#define ksWidth 375
@interface DiscoverViewController ()<UIScrollViewDelegate,DieViewgotoWeb,MotivationalViewGoWebDelegate,SkillViewGoWebDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation DiscoverViewController

- (NSArray *)arrTitle {
    if (!_arrTitle) {
        _arrTitle = @[@"饮食",@"技巧",@"励志"];
    }
    return _arrTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
   
    CGFloat scrollWidth =self.view.bounds.size.width;
    CGFloat scrollY = 105;
    CGFloat scrollHeight = self.view.bounds.size.height-105;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [scrollView setFrame:CGRectMake(0, scrollY, scrollWidth, scrollHeight)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(scrollWidth*3, scrollHeight);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    _scrollView = scrollView;
    [scrollView setDirectionalLockEnabled:YES];
    
    DietView *viewDiet = [[DietView alloc] init];
    viewDiet.delegata = self;
    viewDiet.frame = CGRectMake(0, 0, scrollWidth, scrollHeight);
    [scrollView addSubview:viewDiet];
    SkillView *viewSkill = [[SkillView alloc] init];
    viewSkill.delegate = self;
    viewSkill.frame = CGRectMake(scrollWidth*1, 0, scrollWidth, scrollHeight);
    [scrollView addSubview:viewSkill];
    MotivationalView *viewMotivational = [[MotivationalView alloc] init];
    viewMotivational.delegate = self;
    viewMotivational.frame = CGRectMake(scrollWidth*2, 0, scrollWidth, scrollHeight);
    [scrollView addSubview:viewMotivational];
    
    NSUInteger count = self.arrTitle.count;
    CGFloat btnY = 65;
    CGFloat btnWidth = [[UIScreen mainScreen]bounds].size.width/3;
    CGFloat btnHeight = 40;
    for (NSUInteger index = 0; index < count; index ++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:self.arrTitle[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:0.600 green:0.118 blue:0.221 alpha:1.000] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"img_shadow"] forState:UIControlStateSelected];
        // 
        [btn setContentMode:UIViewContentModeScaleAspectFill];
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(index * btnWidth, btnY, btnWidth, btnHeight)];
        [self.view addSubview:btn];
        btn.tag = index + 100;
        if (index == 0) {
            [self chooseAction:btn];
        }
    }
  
   }
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point =scrollView.contentOffset;
    CGFloat offSetX = point.x;
    NSUInteger index = offSetX /self.view.bounds.size.width;
    
    UIButton *button = [self.view viewWithTag:index+100];
    [self chooseAction:button];
}
- (void)chooseAction:(UIButton *)button {
   
    if (button.tag == 100) {
        _scrollView.contentOffset = CGPointMake(0, 0);
    }else if (button.tag == 101){
        _scrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    }else{
        _scrollView.contentOffset = CGPointMake(self.view.bounds.size.width*2, 0);
    }
    NSArray *aray = self.view.subviews;
    NSInteger count = aray.count;
    for (NSUInteger index = 0; index < count; index++) {
        UIView *view = aray [index];
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *buttons = (UIButton *)view;
            buttons.selected = NO;
        }
    }
     button.selected = YES;
}

- (void) dietView:(UIView *)view gotoWeb:(NSString *)url{
    DiscoverWebViewController *webVC = [[DiscoverWebViewController alloc]init];
    webVC.WebURL = url;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void) MotivationalView:(UIView *)view goWeb:(NSString *)url {
    DiscoverWebViewController *webVC = [[DiscoverWebViewController alloc]init];
    webVC.WebURL = url;
    [self.navigationController pushViewController:webVC animated:YES];
}
@end
