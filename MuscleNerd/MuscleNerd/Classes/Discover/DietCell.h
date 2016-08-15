//
//  DietCell.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageCellModel;
@interface DietCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblView;
@property (weak, nonatomic) IBOutlet UILabel *Xiaolbl;
@property (nonatomic, strong) MessageCellModel *model;

@end
