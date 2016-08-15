//
//  DiscoverViewController.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController
@property (nonatomic, copy) void (^blkDidChooseButton)(NSUInteger index);
@property (nonatomic, copy) NSArray *arrTitle;
//- (void)chooseIndex:(NSInteger)index;
@end
