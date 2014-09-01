//
//  TMOWebObject.h
//  TMOWebView
//
//  Created by 崔 明辉 on 14/9/1.
//  Copyright (c) 2014年 多玩事业部 iOS开发组. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMOWebView;

typedef void(^TMOWebObjectCallBlock)(NSDictionary *callParams, NSString *callbackIdentifier, TMOWebView *webView);

@interface TMOWebObject : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) TMOWebObjectCallBlock callBlock;

@end