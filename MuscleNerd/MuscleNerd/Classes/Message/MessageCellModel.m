//
//  MessageCellModel.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MessageCellModel.h"

@implementation MessageCellModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        NSString *desc = value;
        [self setValue:desc forKey:@"desc"];
    }
    if ([key isEqualToString:@"id"]) {
        NSString *ID = value;
        [self setValue:ID forKey:@"ID"];
    }
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.title,self.cover,self.digest,self.link];
}
@end
