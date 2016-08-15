//
//  ArmViewController.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface ArmViewController : UIViewController
@property (nonatomic, strong) AVPlayerViewController *playerViewController;
@property (nonatomic, strong) AVPlayer *playView;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic) BOOL isPlaying;
@end
