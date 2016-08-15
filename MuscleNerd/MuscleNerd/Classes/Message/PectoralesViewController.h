//
//  PectoralesViewController.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface PectoralesViewController : UIViewController

@property (nonatomic, strong)AVPlayerViewController *playerViewController;
@property (nonatomic, strong) AVPlayer *playView;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic) BOOL isPlaying;

@end
