//
//  AllTableViewCell.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AllTableViewCell.h"
#import "MessageCellModel.h"
#import "UIImageView+WebCache.h"
@implementation AllTableViewCell

- (void)setModel:(MessageCellModel *)model {
    _model = model;
    _lblView.text = model.title;
    _XiaBiaolbl.text = model.digest;
    NSURL *url = [NSURL URLWithString:model.cover];
    [_ImageView sd_setImageWithURL:url];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
