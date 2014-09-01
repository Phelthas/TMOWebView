//
//  TMOWebView.h
//  TMOWebView
//
//  Created by 崔 明辉 on 14/9/1.
//  Copyright (c) 2014年 多玩事业部 iOS开发组. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMOWebObject.h"

@class TMOWebViewDelegateImplement;

@interface TMOWebView : UIWebView 

+ (void)addObject:(NSString *)argName withCallBlock:(TMOWebObjectCallBlock)argCallBlock;
+ (void)removeObject:(NSString *)argName;
+ (TMOWebObject *)webObjectForKey:(NSString *)argKey;

/**
 *  zip包的远端地址
 */
@property (nonatomic, strong) NSString *zipURLString;

/**
 *  html页相对于zip包的地址
 */
@property (nonatomic, strong) NSString *webURLString;

/**
 *  TMOWebView依赖的Delegate
 *  如果你需要自定义WebView的delagate，则需要创建一个TMOWebViewDelegate的子类，并将其赋予TMOWebView实例
 */
@property (nonatomic, strong) TMOWebViewDelegateImplement *delegateImplement;

- (void)callback:(NSString *)argIdentifier withParams:(NSDictionary *)argParams;

@end
