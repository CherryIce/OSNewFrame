//
//  OSPlaceholderView.h
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 占位图的类型 */
typedef NS_ENUM(NSInteger, OSPlaceholderViewType) {
    /** 没网 */
    OSPlaceholderViewTypeNoNetwork = 1,
    /** 没商品 */
    OSPlaceholderViewTypeNoGoods,
    /** 预加载 */
    OSPlaceholderViewTypeLoading
};

/** 表格视图的类型 */
typedef NS_ENUM(NSInteger, OSTableViewType) {
    /** 每个页面的展位图不一样 */
    /** 首页 */
    OSHomeTableViewType = 1,
    /** 详情页 */
    OSDetailTableViewType,
};

@class OSPlaceholderView;

@protocol OSPlaceholderViewDelegate <NSObject>

/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(OSPlaceholderView *)placeholderView
   reloadButtonDidClick:(UIButton *)sender;

@end

@interface OSPlaceholderView : UIView

/** 占位图类型（只读） */
@property (nonatomic, assign, readonly) OSPlaceholderViewType type;

/** 表格视图类型（只读） */
@property (nonatomic, assign, readonly) OSTableViewType table;

/** 占位图的代理方（只读） */
@property (nonatomic, weak, readonly) id <OSPlaceholderViewDelegate> delegate;

/**
 构造方法
 
 @param frame 占位图的frame
 @param type 占位图的类型
 @param delegate 占位图的代理方
 @return 指定frame、类型和代理方的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame
                         type:(OSPlaceholderViewType)type
                        table:(OSTableViewType)table
                     delegate:(id)delegate;

@end
