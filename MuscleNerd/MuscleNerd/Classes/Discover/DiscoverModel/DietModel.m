//
//  DietModel.m
//  MuscleNerd
//
//  Created by tyuo on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DietModel.h"
#import "MessageCellModel.h"
#import "UIImageView+WebCache.h"

@implementation DietModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.title,self.version,self._digest];
//}
@end
