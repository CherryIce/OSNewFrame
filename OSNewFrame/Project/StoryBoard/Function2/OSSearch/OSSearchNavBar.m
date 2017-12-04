//
//  OSSearchNavBar.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSSearchNavBar.h"

@implementation OSSearchNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        NSArray * nibView =  [[NSBundle mainBundle] loadNibNamed:@"OSSearchNavBar" owner:self options:nil];
        UIView * backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        
        self.searchTf.delegate = self;
    }
    return self;
}

/**
 取消点击
 */
- (IBAction)cancelClick:(UIButton *)sender{
    if (_OSSearchCancelCallBack) {
        _OSSearchCancelCallBack();
    }
}

/**
 选择城市
 */
- (IBAction)selectCityClick:(UIButton *)sender {
    if (_OSSearchSelectCityCallBack) {
        _OSSearchSelectCityCallBack();
    }
}

/**
 完成编辑开始搜索
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_searchKeyWordCall) {
            _searchKeyWordCall(textField.text);
        }
    });
    return YES;
}

@end
