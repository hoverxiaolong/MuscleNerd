//
//  TrainingViewController.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface TrainingViewController : UIViewController
@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@property (nonatomic, strong) UIImageView *playView;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic) BOOL isPlaying;
@end
