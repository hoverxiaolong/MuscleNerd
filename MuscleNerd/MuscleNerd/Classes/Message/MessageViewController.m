//
//  MessageViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/6/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#import "TrainingViewController.h"
#import "PectoralesViewController.h"
#import "WaistViewController.h"
#import "DeltoidViewController.h"
#import "ArmViewController.h"
#import "MessageViewController.h"
#import "TrainingViewController.h"
#import "WelcomeView.h"
#import "PectoralesViewController.h"
#import "WaistViewController.h"
#import "DeltoidViewController.h"
#import "ArmViewController.h"
#import "Masonry.h"
#import "AllTableViewCell.h"
#import "AFNetworking.h"
#import "MessageCellModel.h"
#import "WebViewController.h"
#define  APIURL @"http://mp.weixin.qq.com/mp/homepage?__biz=MzI2NjE4NzAxMw==&hid=1&sn=85e16a89c1c1c910bfebad96710e9d90&cid=0&begin=0&count=20&action=appmsg_list&f=json&r=0.3506970498710871"
@interface MessageViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, weak)UIScrollView *bjScrView;
@property (nonatomic, weak)UIPageControl *pageCtr;
@property (nonatomic, copy)NSArray *arrImageName;
@property (nonatomic, assign)NSUInteger indexCurrent;
@property (nonatomic, weak)UITableView *tableView;
@property (nonatomic, copy)NSArray *datas;
@property (nonatomic, weak)UITapGestureRecognizer *tap;
@end

@implementation MessageViewController
- (NSArray *)datas {
    if (!_datas) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        NSDictionary *dict = @{@"count":@(30)};
        
        [manager POST:APIURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *data = responseObject[@"appmsg_list"];
           
           NSString *str = [self creatDocumentPath];
            [data writeToFile:str atomically:YES];
            //NSLog(@"%@",str);
            [self setModelUpdateUI:data];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSString *str = [self creatDocumentPath];
//                     NSLog(@"%@",str);
                    NSArray *arrayData = [NSArray arrayWithContentsOfFile:str];
                    
                    [self setModelUpdateUI:arrayData];
                }
//                NSLog(@"%@",error);
            }];
    }
    return _datas;
}


- (void) setModelUpdateUI:(NSArray *)data{
    NSMutableArray *muarr = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        MessageCellModel *model = [MessageCellModel modelWithDictionary:dict];
        [muarr addObject:model];
        //                NSLog(@"%@",model.description);
        _datas = [muarr copy];
        [self.tableView reloadData];
    }

}

- (NSString *) creatDocumentPath{
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    // //获取document路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *wenjianjiaPath = [documentPath stringByAppendingPathComponent:@"/mywenjian"];
    //创建文件夹
    if (![fileManager createDirectoryAtPath:wenjianjiaPath withIntermediateDirectories:YES attributes:nil error:nil]) {
//        NSLog(@"文件夹创建失败");
    }
    NSString *str = [wenjianjiaPath stringByAppendingPathComponent:@"mydata.plist"];
    if ([fileManager fileExistsAtPath:str]) {
//        NSLog(@"有文件的路径");
    }
    return str;

}

- (NSArray *)arrImageName {
    if (!_arrImageName) {
        NSUInteger count = 5;
        NSMutableArray *arrMImageNames = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger index = 0; index < count; index ++) {
            NSString *strImageNmame = [NSString stringWithFormat:@"lun_%ld",index];
            
            [arrMImageNames addObject:strImageNmame];
        }
        _arrImageName = [arrMImageNames copy];
    }
    return _arrImageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableViewSetting];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)loadTableViewSetting {
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.leading.and.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    _tableView = tableView;
    tableView.estimatedRowHeight = 80;
    tableView.rowHeight = 120;
    [self loadDefaultSetting];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *strID = @"AllTableViewCell";
    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AllTableViewCell" owner:nil options:nil][0];
    }
    [cell setModel:self.datas[indexPath.row]];
    return cell;
}

- (void)loadDefaultSetting {
    
    UIView *viewTableViewHeader = [UIView new];
    viewTableViewHeader.bounds = CGRectMake(0, 0, 0, 180);
    viewTableViewHeader.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = viewTableViewHeader;

    UIScrollView *bjScrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    [viewTableViewHeader addSubview:bjScrView];
    _bjScrView = bjScrView;
    _bjScrView.delegate = self;
    _bjScrView.showsHorizontalScrollIndicator = NO;
    [bjScrView setPagingEnabled:YES];
    [bjScrView setDecelerationRate:YES];
    
    UIPageControl *pageCtr = [[UIPageControl alloc] init];
    [viewTableViewHeader addSubview:pageCtr];
    [pageCtr setNumberOfPages:5];
    [pageCtr setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageCtr setPageIndicatorTintColor:[UIColor cyanColor]];
    _pageCtr = pageCtr;

    [pageCtr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bjScrView).offset(-1);
        make.leading.equalTo(_bjScrView).offset(100);
        make.trailing.equalTo(_bjScrView).offset(-100);
        make.height.equalTo(@(50));
    }];
    [self loadImageView];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pageChangeAction) userInfo:nil repeats:YES];
}
         
 - (void)loadImageView {
     CGFloat imageViewWidth = _bjScrView.frame.size.width;
     CGFloat imageViewHeight = _bjScrView.frame.size.height;
     NSUInteger count = self.arrImageName.count;
     for (NSUInteger index=0; index < count; index ++)
     {
         UIScrollView *scrZooming = [[UIScrollView alloc] initWithFrame:CGRectMake(imageViewWidth*index, 0, imageViewWidth, imageViewHeight)];
         [_bjScrView addSubview:scrZooming];
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageViewWidth, imageViewHeight)];
         imageView.userInteractionEnabled = YES;
         [scrZooming addSubview:imageView];
         imageView.tag = index;
         [imageView setImage:[UIImage imageNamed:self.arrImageName[index]]];
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
         [imageView addGestureRecognizer:tap];
          scrZooming.delegate = self;
   }
          _bjScrView.contentSize = CGSizeMake(count*imageViewWidth, 0);
     [_pageCtr addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventValueChanged];
 }

- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == 0) {
        DeltoidViewController *deltoidView = [[DeltoidViewController alloc] init];
        [deltoidView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:deltoidView animated:YES];
    }else if (sender.view.tag == 1) {
        PectoralesViewController *Pectorales = [PectoralesViewController new];
        [Pectorales setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:Pectorales animated:YES];
    }else if (sender.view.tag == 2) {
        WaistViewController *WaistView = [[WaistViewController alloc] init];
        [WaistView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:WaistView animated:YES];
    }else if (sender.view.tag == 3) {
        TrainingViewController *training = [TrainingViewController new];
        [training setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:training animated:YES];
    }else {
        ArmViewController *armView = [[ArmViewController alloc] init];
        [armView setAutomaticallyAdjustsScrollViewInsets:NO];
        [self.navigationController pushViewController:armView animated:YES];
    }
}
         
- (void)pageChangeAction {
    CGFloat imageViewWidth = _bjScrView.frame.size.width;
    CGFloat index = _pageCtr.currentPage++;
    if (index == 4) {
        _pageCtr.currentPage = 0;
    }
    [_bjScrView setContentOffset:CGPointMake(imageViewWidth * index, 0) animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCellModel *modell = self.datas[indexPath.row];
    NSString *linkss = modell.link;
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.urlWeb = linkss;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)valueChangeAction:(UIPageControl *)pageCtr {
    CGFloat imageViewWidth = _bjScrView.frame.size.width;
    CGFloat index = _pageCtr.currentPage ++;
    [_bjScrView setContentOffset:CGPointMake(imageViewWidth * index, 0) animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (_bjScrView == scrollView) return nil;
    NSArray *arrSubView = scrollView.subviews;
    for (UIImageView *imageView in arrSubView) {
        if ([imageView isKindOfClass:[UIImageView class]]) {
            return imageView;
        }
    }
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_bjScrView == scrollView) {
        _indexCurrent = scrollView.contentOffset.x / scrollView.frame.size.width;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_bjScrView == scrollView) {
        _pageCtr.currentPage = _bjScrView.contentOffset.x / scrollView.bounds.size.width;
        NSUInteger indexNow = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (indexNow == _indexCurrent) return;
        NSArray *arrSubViews = scrollView.subviews;
        for (UIScrollView *scvZooming in arrSubViews) {
            if ([scvZooming isKindOfClass:[UIScrollView class]]) {
                scvZooming.zoomScale = 1.0;
            }
        }
    }
}
@end
