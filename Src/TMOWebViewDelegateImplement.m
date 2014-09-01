//
//  TMOWebViewDelegateImplement.m
//  TMOWebView
//
//  Created by 崔 明辉 on 14/9/1.
//  Copyright (c) 2014年 多玩事业部 iOS开发组. All rights reserved.
//

#import "TMOWebViewDelegateImplement.h"
#import "TMOWebView.h"
#import "TMOWebObject.h"

@interface TMOWebViewDelegateImplement () 

@property (nonatomic, strong) NSString *injectJS;

@end

@implementation TMOWebViewDelegateImplement

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *injectJSFilePath = [[NSBundle mainBundle] pathForResource:@"TMOWebView" ofType:@"js"];
        self.injectJS = [NSString stringWithContentsOfFile:injectJSFilePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    }
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return NO;
    }
    else if ([request.URL.scheme isEqualToString:@"tmowebview"]) {
        [self responseWebViewCall:request withWebView:(TMOWebView *)webView];
    }
    return YES;
}

- (void)responseWebViewCall:(NSURLRequest *)argRequest withWebView:(TMOWebView *)argWebView {
    TMOWebObject *webObject = [TMOWebView webObjectForKey:argRequest.URL.host];
    if (webObject != nil) {
        NSDictionary *jsonObject;
        if (argRequest.HTTPBody != nil && argRequest.HTTPBody.length > 0) {
            NSString *jsonString = [[NSString alloc] initWithData:argRequest.HTTPBody encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"body=" withString:@""];
            jsonString = [jsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            jsonObject = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
            
        }
        webObject.callBlock(jsonObject, [argRequest.URL.path substringFromIndex:1], argWebView);
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:self.injectJS];
}

@end
