//
//  DiscoverWebViewController.m
//  MuscleNerd
//
//  Created by 杨小龙 on 16/8/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define BDURL @"http://mp.aiweibang.com/m/u/3422/a"
#import "DiscoverWebViewController.h"
#import <WebKit/WebKit.h>
#define width [[UIScreen mainScreen]bounds].size.width
#define Height [[UIScreen mainScreen]bounds].size.height
@interface DiscoverWebViewController ()<UIWebViewDelegate>
@property (nonatomic, weak)UIWebView *webView;
@property (nonatomic, strong)UIButton *backbutton;
@property (nonatomic, strong)UIButton *nextPageButton;

@end

@implementation DiscoverWebViewController

- (void)loadView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.view = webView;
    self.webView = webView;
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self turnButton];
}
- (void)turnButton {
    UIView *turnView = [[UIView alloc] initWithFrame:CGRectMake(0, Height-40, width, 40)];
    turnView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    [self.view addSubview:turnView];
    UIButton *backbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width/2-20, 40)];
    self.backbutton = backbutton;
    [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backbutton setTitle:@"上一页" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [turnView addSubview:backbutton];
    
    UIButton *nextPageButton = [[UIButton alloc] initWithFrame:CGRectMake(width/2+20, 0, width/2-20, 40)];
    [nextPageButton setTitle:@"下一页" forState:UIControlStateNormal];
    [nextPageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextPageButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [nextPageButton addTarget:self action:@selector(nextPageAction) forControlEvents:UIControlEventTouchUpInside];
    [turnView addSubview:nextPageButton];
    self.nextPageButton = nextPageButton;
    
}
- (void)backAction {
    [self.webView goBack];
    if (self.webView.canGoBack == YES) {
        [self.webView goBack];
    }else {
        self.nextPageButton.enabled = NO;
    }
}
- (void)nextPageAction {
    if (self.webView.canGoForward == YES) {
        [self.webView goForward];
    }else {
        self.nextPageButton.enabled = NO;
    }
}

- (void)loadDefaultSetting {
    NSURL *url = [NSURL URLWithString:self.WebURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (self.webView.canGoBack == NO) {
        self.backbutton.enabled = NO;
    }else {
        self.backbutton.enabled = YES;
    }
    if (self.webView.canGoForward == NO) {
        self.nextPageButton.enabled = NO;
    }else {
        self.nextPageButton.enabled = YES;
    }

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@",error);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.absoluteString containsString:@"http://baidu.com"]) {
        return NO;
    }
    return YES;
}


@end
