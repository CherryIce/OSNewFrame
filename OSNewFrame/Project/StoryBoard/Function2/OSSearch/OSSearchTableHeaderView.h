//
//  OSSearchTableHeaderView.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSearchTableHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

@property (nonatomic,copy) void(^SuggstContentClickCallBack)(NSString * content);

@end
