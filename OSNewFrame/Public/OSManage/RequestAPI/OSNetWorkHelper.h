//
//  OSNetWorkHelper.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSNetWorkHelper : NSObject

@property (nonatomic, copy) void(^successBlock) (NSDictionary *responseObject);
@property (nonatomic, copy) void(^failureBlock) (NSError *error);

+(id)sharedAFHTTPManager;

/**
 *  发送get请求
 *
 *  urlString  请求的网址字符串
 *  parameters 请求的参数
 *  success    请求成功的回调
 *  failure    请求失败的回调
 */
+ (void)getWithURLString:(NSString *)urlString
              parameters:(id)parameters
                  sucess:(void(^) (NSDictionary *responseObject))successBlock failure:(void(^) (NSError *error))failureBlock;

/**
 *  发送post请求
 *
 *   urlString  请求的网址字符串
 *   parameters 请求的参数
 *   success    请求成功的回调
 *   failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)urlString
               parameters:(id)parameters
                  sucess:(void(^) (NSDictionary *responseObject))successBlock failure:(void(^) (NSError *error))failureBlock;

@end
