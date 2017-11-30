//
//  OSUtilityHelper.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SGAlertView.h"

@interface OSUtilityHelper : NSObject

/**
 是否登录,return NO 就跳转到登录页面
 */
+ (BOOL) isLogin:(UIViewController *) vc;

/** 自适应Size **/
+  (CGSize) fitSizeWithLabel:(NSString *)currentString size:(CGSize)size font:(UIFont*)font;

/**
 DES加密
 **/
+ (NSString *) encryptParmar:(NSString *)paramer;

/**
 DES加密方式
 */
+ (NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key;

/**
 DES解密方式
 **/
+ (NSString *)decryptUseDES2:(NSString *)cipherText key:(NSString *)key;

/**
 获取本地数据
 */
+ (NSDictionary *) localDataResourceWithName:(NSString *)name;

/**
 地图导航
 */
+ (void )loadGPSWithLat:(NSString *)latitude log:(NSString *)longitude;

/***
 扫一扫
 **/
+(void)scanRQCode:(UIViewController<SGScanningQRCodeVCDelegate>*)vc;

@end
