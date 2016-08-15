//
//  MotivationalView.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MotivationalView;
@protocol MotivationalViewGoWebDelegate <NSObject>

- (void)MotivationalView:(UIView *)view goWeb:(NSString *)url;

@end
@interface MotivationalView : UIView
@property (nonatomic, weak) id <MotivationalViewGoWebDelegate> delegate;
@end
