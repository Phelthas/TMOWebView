//
//  DemoViewController.m
//  TMOWebView
//
//  Created by 崔 明辉 on 14/9/1.
//  Copyright (c) 2014年 多玩事业部 iOS开发组. All rights reserved.
//

#import "DemoViewController.h"
#import "TMOWebView.h"

@interface DemoViewController ()

@property (weak, nonatomic) IBOutlet TMOWebView *webView;

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TMOWebView addObject:@"test" withCallBlock:^(NSDictionary *callParams,
                                                  NSString *callbackIdentifier,
                                                  TMOWebView *webView) {
        [webView callback:callbackIdentifier withParams:@{@"test": @"我真的是来测试的"}];
    }];
    [self.webView setWebURLString:@"http://www.baidu.com/"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
