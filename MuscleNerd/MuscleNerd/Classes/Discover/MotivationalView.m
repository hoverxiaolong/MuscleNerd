//
//  MotivationalView.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MotivationalView.h"
#import "DietCell.h"
#import "AFNetworking.h"
#import "MessageCellModel.h"

#define BDURL @"http://mp.weixin.qq.com/mp/homepage?__biz=MzA5Njg4NTk5OQ==&hid=3&sn=6c41d0df4116de00cfb7d9e0e58575ec&uin=MTk2NjA3NjAwMg%3D%3D&key=8dcebf9e179c9f3a130c10f3fab44c47f1aa42100db31031fc23074ab3d784f2d4de85fb8ea0fa930323ea6b70ae449f&devicetype=android-19&version=26031031&lang=zh_CN&nettype=WIFI&pass_ticket=C4mNRkS7MMt9g0GAtkJN5pP4VQzaSz%2B%2BJEI988XKHnBsKP%2BdV5nASE4k31m6kOqS&begin=0&count=20&action=appmsg_list&f=json&r=0.880094466265291"
@interface MotivationalView() <NSObject,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *datas;
@end
@implementation MotivationalView
- (NSArray *)datas {
    if (!_datas) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        NSDictionary *dict = @{@"count":@(20)};
        [manager POST:BDURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *data = responseObject[@"appmsg_list"];
            NSString *str = [self creatDocumentPath];
            [data writeToFile:str atomically:YES];
            [self setModelAndUI:data];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                NSString *str = [self creatDocumentPath];
                NSArray *arrdata = [NSArray arrayWithContentsOfFile:str];
                [self setModelAndUI:arrdata];
            }
            
        }];
    }
    return _datas;
}
- (void)setModelAndUI:(NSArray *)data {
    NSMutableArray *marr = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        MessageCellModel *model = [MessageCellModel modelWithDictionary:dict];
        [marr addObject:model];
        _datas = [marr copy];
        [self.tableView reloadData];
    }
}

- (NSString *)creatDocumentPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *wenjianjiaPath = [documentPath stringByAppendingPathComponent:@"/myxiaowenjian"];
    if (![fileManager createDirectoryAtPath:wenjianjiaPath withIntermediateDirectories:YES attributes:nil error:nil]) {
    }
    NSString *str = [wenjianjiaPath stringByAppendingPathComponent:@"myxiaowenjian.plist"];
    if ([fileManager fileExistsAtPath:str]) {
    }
    return str;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self loadDefaultSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadDefaultSetting];
    
}

- (void)loadDefaultSetting {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 80;
    tableView.rowHeight = 120;
    tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableView];
    
    _tableView = tableView;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"DietCell";
    DietCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DietCell" owner:nil options:nil][0];
    }
    [cell setModel:self.datas[indexPath.row]];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCellModel *cellmodel = self.datas[indexPath.row];
    NSString *links = cellmodel.link;
    if ([self.delegate respondsToSelector:@selector(MotivationalView:goWeb:)]) {
        [self.delegate MotivationalView:self goWeb:links];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
       _tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-50);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }else {
        return 20;
    }
    
}

@end
