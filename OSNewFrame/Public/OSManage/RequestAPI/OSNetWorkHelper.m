//
//  OSNetWorkHelper.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSNetWorkHelper.h"

@implementation OSNetWorkHelper

+ (id)sharedAFHTTPManager
{
    static AFHTTPSessionManager *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [AFHTTPSessionManager manager];
    });
    return manger;
    
}

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
                  sucess:(void(^) (NSDictionary *responseObject))successBlock failure:(void(^) (NSError *error))failureBlock
{
    AFHTTPSessionManager *manager = [self sharedAFHTTPManager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 30;
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    LoadingView * loading = [[LoadingView alloc] initWithFrame:CGRectZero];
    [loading show];
    
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            [loading dismiss];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
            NSLog(@">>>>>>>:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            [loading dismiss];
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
        }
    }];
}

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
                   sucess:(void(^) (NSDictionary *responseObject))successBlock failure:(void(^) (NSError *error))failureBlock
{
    AFHTTPSessionManager *manager = [self sharedAFHTTPManager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    
    LoadingView * loading = [[LoadingView alloc] initWithFrame:CGRectZero];
    [loading show];
    
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [loading dismiss];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        if (![dic[@"reCode"] isEqualToString:@"X0000"] && [OSVerifyHelper isNull:dic key:@"reCode"]) {
            [OSNetWorkHelper showMessage:dic[@"reMsg"]];
            return;
        }
        if (successBlock) {
            NSLog(@"<<<<<<:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            successBlock(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            [loading dismiss];
            failureBlock(error);
            NSLog(@"网络异常 - T_T%@", error);
            [OSNetWorkHelper showMessage:@"网络异常"];
        }
    }];
}

+ (void) showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    for (id class in window.subviews)
    {
        if ([class isKindOfClass:[UIAlertView class]] || [class isKindOfClass:[UIAlertController class]]) {
            return;
        }
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
