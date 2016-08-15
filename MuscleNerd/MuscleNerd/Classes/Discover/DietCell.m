//
//  DietCell.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DietCell.h"
#import "MessageCellModel.h"
#import "UIImageView+WebCache.h"

@implementation DietCell

- (void)setModel:(MessageCellModel *)model {
    _model = model;
    _lblView.text = model.title;
    _Xiaolbl.text = model.digest;
    NSURL *url = [NSURL URLWithString:model.cover];
    [_imgView sd_setImageWithURL:url];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
