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
 *  webView path
 */
@property (nonatomic, strong) NSString *URLString;

/**
 *  TMOWebView Delegate's implementation
 *  If you wondering implement delegate by yourself, you should subclass TMOWebViewDelegateImplement.
 */
@property (nonatomic, strong) TMOWebViewDelegateImplement *delegateImplement;

/**
 *  make a callback to WebView
 *
 *  @param argIdentifier callbackIdentifier
 *  @param argParams     callbackParams, should be an Array or Dictionary
 */
- (void)callback:(NSString *)argIdentifier withParams:(id)argParams;

@end
