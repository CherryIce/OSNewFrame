//
//  OSVerifyHelper.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSVerifyHelper : NSObject

/** 判断是否为空  **/
+ (BOOL)empty:(id)value;

/** 判断字典value是否存在  **/
+(BOOL)isNull:(NSDictionary *)dict key:(NSString*)key;

/** 验证身份证是否合法 **/
+ (BOOL)validateIDCardNumber:(NSString *)value;

/** MD5加密 **/
+(NSString *)md5:(NSString *)str;

//电话号码验证
+(BOOL)checkMobileTel:(NSString *)tel;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

@end
