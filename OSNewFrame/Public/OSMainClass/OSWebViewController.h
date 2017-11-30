//
//  OSWebViewController.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSViewController.h"

#import <WebKit/WebKit.h>

@interface OSWebViewController : OSViewController

@property (nonatomic,strong) WKWebView * webView;

@property (nonatomic) UIColor *progressViewColor;

@property (nonatomic,strong) WKWebViewConfiguration * webConfiguration;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, strong) WKUserContentController * userController;

/**
 有多个可以设置成数组
 */
@property (nonatomic, copy) NSString * jsMethodName;

@end
