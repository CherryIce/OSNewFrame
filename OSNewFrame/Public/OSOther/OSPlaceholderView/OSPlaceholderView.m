//
//  OSPlaceholderView.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSPlaceholderView.h"

@implementation OSPlaceholderView


/**
 构造方法
 
 @param frame 占位图的frame
 @param type 占位图的类型
 @param delegate 占位图的代理方
 @return 指定frame、类型和代理方的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame type:(OSPlaceholderViewType)type table:(OSTableViewType)table delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        // 存值
        _type = type;
        _table = table;
        _delegate = delegate;
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 图片 -------//
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imageView];
    
    
    //------- 说明label -------//
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    descLabel.font = systemOfFont(13);
    [self addSubview:descLabel];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 2;
    
    //------- 按钮 -------//
    UIButton *reloadButton = [OSUIFactory initBorderButtonWithFrame:CGRectZero title:@"" textColor:[UIColor blackColor] font:systemOfFont(15) cornerRadius:5 bgColor:[UIColor groupTableViewBackgroundColor] borderColor:[UIColor lightGrayColor] borderWidth:0.5 tag:10 target:self action:@selector(reloadButtonClicked:)];
    [self addSubview:reloadButton];
    
    if (_type != OSPlaceholderViewTypeLoading) {
        imageView.frame = CGRectMake(self.bounds.size.width/2 - 50,self.bounds.size.height/2 - 50 - KNavBarHeight, 100, 100);
        descLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, self.frame.size.width, 34);;
        reloadButton.frame = CGRectMake(self.frame.size.width / 2 - 75, CGRectGetMaxY(descLabel.frame) + 10, 150, 40);
    }
    
    //------- 根据type创建不同样式的UI -------//
    switch (_type) {
        case OSPlaceholderViewTypeNoNetwork: // 没网
        {
            imageView.image = UIIMAGE(@"nonet");
            descLabel.text = @"没网，不约";
            [reloadButton setTitle:@"点击重试" forState:UIControlStateNormal];
        }
            break;
            
        case OSPlaceholderViewTypeNoGoods: // 没商品
        {
            imageView.image = UIIMAGE(@"nogif");
            descLabel.text = @"没东西呢";
            [reloadButton setTitle:@"添加" forState:UIControlStateNormal];
        }
            break;
            
        case OSPlaceholderViewTypeLoading: // 预加载
        {
            imageView.frame = self.bounds;
            [self setImageWithImageView:imageView];
        }
            break;
            
        default:
            break;
    }
}

- (void) setImageWithImageView:(UIImageView *)imageView
{
    switch (_table)
    {
        case OSHomeTableViewType:
            imageView.image = UIIMAGE(@"pager1");
            break;
        case OSDetailTableViewType:
            imageView.image = UIIMAGE(@"pager2");
            break;
        default:
            break;
    }
}

#pragma mark - 重新加载按钮点击
/** 重新加载按钮点击 */
- (void)reloadButtonClicked:(UIButton *)sender{
    // 代理方执行方法
    if ([_delegate respondsToSelector:@selector(placeholderView:reloadButtonDidClick:)]) {
        [_delegate placeholderView:self reloadButtonDidClick:sender];
    }
    // 从父视图上移除
    [self removeFromSuperview];
}

@end
