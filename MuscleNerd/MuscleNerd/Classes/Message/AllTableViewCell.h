//
//  AllTableViewCell.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageCellModel;
@interface AllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblView;
@property (weak, nonatomic) IBOutlet UILabel *XiaBiaolbl;
@property (nonatomic, strong) MessageCellModel *model;
@end
