//
//  DietModel.h
//  MuscleNerd
//
//  Created by tyuo on 16/8/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DietModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *cover;
@property (nonatomic, copy)NSString *strlink;
@property (nonatomic, copy)NSString *digest;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
