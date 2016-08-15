//
//  DietView.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DieViewgotoWeb <NSObject>

- (void) dietView:(UIView *)view  gotoWeb:(NSString *)url;

@end

@interface DietView : UIView
@property (nonatomic, weak) id <DieViewgotoWeb> delegata;
@end
