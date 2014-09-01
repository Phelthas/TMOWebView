//
//  TMOWebView.m
//  TMOWebView
//
//  Created by 崔 明辉 on 14/9/1.
//  Copyright (c) 2014年 多玩事业部 iOS开发组. All rights reserved.
//

#import "TMOWebView.h"
#import "TMOWebObject.h"
#import "TMOWebViewDelegateImplement.h"

static NSMutableDictionary *webObjectDictionary;

@interface TMOWebView ()<UIWebViewDelegate>

@end

@implementation TMOWebView

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        webObjectDictionary = [NSMutableDictionary dictionary];
    });
}

+ (void)addObject:(NSString *)argName withCallBlock:(TMOWebObjectCallBlock)argCallBlock {
    TMOWebObject *theObject = [[TMOWebObject alloc] init];
    theObject.name = argName;
    theObject.callBlock = argCallBlock;
    [webObjectDictionary setObject:theObject forKey:theObject.name];
}

+ (void)removeObject:(NSString *)argName {
    [webObjectDictionary removeObjectForKey:argName];
}

+ (TMOWebObject *)webObjectForKey:(NSString *)argKey {
    return [webObjectDictionary objectForKey:argKey];
}

- (void)dealloc {
    self.delegate = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegateImplement = [[TMOWebViewDelegateImplement alloc] init];
    self.delegate = self.delegateImplement;
}

- (void)setZipURLString:(NSString *)zipURLString {
    
}

- (void)setWebURLString:(NSString *)webURLString {
    _webURLString = webURLString;
    if (self.zipURLString == nil) {
        [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webURLString]]];
    }
}

- (void)callback:(NSString *)argIdentifier withParams:(NSDictionary *)argParams {
    NSString *paramsJSONString = @"";
    if (argParams != nil) {
        NSData *paramsJSONData = [NSJSONSerialization dataWithJSONObject:argParams options:NSJSONWritingPrettyPrinted error:nil];
        paramsJSONString = [[NSString alloc] initWithData:paramsJSONData encoding:NSUTF8StringEncoding];
    }
    NSString *jsCode = [NSString stringWithFormat:@"TMOWebApplication.callbackStack.%@(%@)",
                                                  argIdentifier,
                                                  paramsJSONString];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
}


@end
