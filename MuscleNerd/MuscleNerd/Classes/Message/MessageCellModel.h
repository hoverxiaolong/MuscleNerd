//
//  MessageCellModel.h
//  MuscleNerd
//
//  Created by 杨小龙 on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageCellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *link;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
