//
//  OSSearchTableHeaderView.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSSearchTableHeaderView.h"

@implementation OSSearchTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray
{
    if (self == [super initWithFrame:frame]){
        [self initSubViews:dataArray];
    }
    return self;
}

- (void) initSubViews:(NSArray *)dataArray
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(OSSpace, OSSpace, 30, 30)];
    img.backgroundColor = [UIColor redColor];
    [self addSubview:img];
    
    UILabel * lab = [OSUIFactory initLableWithFrame:CGRectMake(img.right+OSSpace, OSSpace, 120, 30) title:@"搜索建议" textColor:[UIColor darkTextColor] font:systemOfFont(15) textAlignment:0];
    [self addSubview:lab];
    
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = OSCellHeight;//用来控制button距离父视图的高
    for (int i = 0; i < dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        button.layer.borderWidth = 0.5;
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        //根据计算文字的大小
        CGFloat length = [OSUtilityHelper fitSizeWithLabel:dataArray[i]  size:CGSizeMake(kScreenWidth - 120, 1000) font:systemOfFont(14)].width;
        [button.titleLabel setFont:systemOfFont(14)];
        
        //为button赋值
        [button setTitle:dataArray[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(OSSpace + w, h, length + 15 , 30);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w + length + 15 >= kScreenWidth){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + OSSpace;//距离父视图也变化
            button.frame = CGRectMake(OSSpace + w, h, length + 15, 30);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self addSubview:button];
    }
    
    UIView * line = [OSUIFactory initViewWithFrame:CGRectMake(OSSpace, h+30+OSSpace, kScreenWidth - 20, 0.5) color:[UIColor darkGrayColor]];
    
    [self addSubview:line];
}

- (void)handleClick:(UIButton *)btn
{
    if (_SuggstContentClickCallBack) {
        _SuggstContentClickCallBack(btn.titleLabel.text);
    }
}

@end
