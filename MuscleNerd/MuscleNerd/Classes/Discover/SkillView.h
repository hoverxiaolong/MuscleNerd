//
//  SkillView.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SkillViewGoWebDelegate <NSObject>

- (void)MotivationalView:(UIView *)view goWeb:(NSString *)url;
@end

@interface SkillView : UIView
@property (nonatomic, weak) id <SkillViewGoWebDelegate> delegate;

@end
