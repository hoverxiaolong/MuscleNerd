//
//  SkillView.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/7/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SkillView.h"
#import "DietCell.h"
#import "MessageCellModel.h"
#import "AFNetworking.h"
#define BDURL @"http://mp.weixin.qq.com/mp/homepage?__biz=MzA5Njg4NTk5OQ==&hid=4&sn=a87e7f2adb2ec576a79ab98e9cbb1174&uin=MTk2NjA3NjAwMg%3D%3D&key=8dcebf9e179c9f3a35559b78a547d771713fdbb579008531bd92fac621044e804303103c4eab7db349e2125e55dc18b7&devicetype=android-19&version=26031031&lang=zh_CN&nettype=WIFI&pass_ticket=C4mNRkS7MMt9g0GAtkJN5pP4VQzaSz%2B%2BJEI988XKHnBsKP%2BdV5nASE4k31m6kOqS&begin=0&count=15&action=appmsg_list&f=json&r=0.8289891683962196"

@interface SkillView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,copy)NSArray *datas;
@end
@implementation SkillView

- (NSArray *)datas {
    if (!_datas) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        NSDictionary *dict = @{@"count":@(20)};
        [manager POST:BDURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *data = responseObject[@"appmsg_list"];
            NSString *str = [self creatDocumentPath];
            [data writeToFile:str atomically:YES];
            [self setModelUI:data];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                NSString *str = [self creatDocumentPath];
                NSArray *array = [NSArray arrayWithContentsOfFile:str];
                
                [self setModelUI:array];
            }
        }];
    }
    return _datas;
}

- (void) setModelUI:(NSArray *)data {
    NSMutableArray *marry = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        MessageCellModel *model = [MessageCellModel modelWithDictionary:dict];
        [marry addObject:model];
        _datas = [marry copy];
        [self.tableView reloadData];
    }
}
- (NSString *)creatDocumentPath {

    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *wenjian = [documentPath stringByAppendingPathComponent:@"/mythreefile"];
    if (![fileManager createDirectoryAtPath:wenjian withIntermediateDirectories:YES attributes:nil error:nil]) {
    }
    NSString *str = [wenjian stringByAppendingPathComponent:@"myfile.plist"];
    if (![fileManager fileExistsAtPath:str]) {
        
    }
    return str;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         [self loadDefaultSetting];
    }
   return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadDefaultSetting];
}
-(void)loadDefaultSetting {
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
@end
