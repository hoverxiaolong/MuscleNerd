//
//  DietView.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DietView.h"
#import "Masonry.h"
#import "DietCell.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "MessageCellModel.h"
#import "DiscoverWebViewController.h"
#define  APIURL @"http://mp.weixin.qq.com/mp/homepage?__biz=MzI2NjE4NzAxMw==&hid=1&sn=85e16a89c1c1c910bfebad96710e9d90&uin=MTk2NjA3NjAwMg%3D%3D&key=8dcebf9e179c9f3a5557926284694f1366e383caa71ad5e6a4211a853e3958d973789c963fb7912a6559bb67ca33af7f&devicetype=android-19&version=26031031&lang=zh_CN&nettype=WIFI&pass_ticket=GNTPCn8c%2FA3WaE3Mrw6eYe2i%2BivGuoQSDNoWAn%2BsVdUvqR96bF3pBIdIEgKobI%2BH&cid=1&begin=0&count=20&action=appmsg_list&f=json&r=0.031975597608834505"
@interface DietView () <NSObject, UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, copy)NSArray *datas;

@end

@implementation DietView

- (NSArray *)datas {
    if (!_datas) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        NSDictionary *dict = @{@"count":@(30)};
        [manager POST:APIURL parameters:dict progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSArray *data = responseObject[@"appmsg_list"];
             
             NSString *str = [self creatDocumentPath];
             [data writeToFile:str atomically:YES];
             [self setModelGetUI:data];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (error) {
                 NSString *str = [self creatDocumentPath];
                 NSArray *arrayData = [NSArray arrayWithContentsOfFile:str];
                 [self setModelGetUI:arrayData];
             }
//             NSLog(@"%@",error);
                 }];
             }
            return _datas;
}

- (void) setModelGetUI:(NSArray *)data {
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        MessageCellModel *model = [MessageCellModel modelWithDictionary:dict];
        [muarr addObject:model];
        _datas = [muarr copy];
        [self.tableView reloadData];
    }
}

- (NSString *) creatDocumentPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *wenjianjiaPath = [documentPath stringByAppendingPathComponent:@"/myWenjia"];
    if (![fileManager createDirectoryAtPath:wenjianjiaPath withIntermediateDirectories:YES attributes:nil error:nil]) {
//        NSLog(@"创建文件夹失败");
    }
    NSString *str = [wenjianjiaPath stringByAppendingPathComponent:@"myData.plist"];
    if ([fileManager fileExistsAtPath:str]) {
//        NSLog(@"成功");
    }
    return str;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self =[super initWithFrame:frame]) {
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
    UITableView *tableView = [UITableView new];
    [self addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.estimatedRowHeight = 80;
    tableView.rowHeight = 120;
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
    NSString *lingks = cellmodel.link;
  
    if ([self.delegata respondsToSelector:@selector(dietView:gotoWeb:)]) {
        [self.delegata dietView:self gotoWeb:lingks];
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
