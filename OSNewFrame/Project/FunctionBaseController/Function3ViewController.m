//
//  Function3ViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "Function3ViewController.h"

#import "ViewController.h"

@interface Function3ViewController ()

@end

@implementation Function3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildViewController];
    [self resetShowStyle];
}

/**
 添加子视图
 */
- (void) setUpAllChildViewController
{
    ViewController * ctl1 = [[ViewController alloc] init];
    ctl1.title = @"你画";
    ctl1.view.backgroundColor = [UIColor brownColor];
    [self addChildViewController:ctl1];
    
    ViewController * ctl2 = [[ViewController alloc] init];
    ctl2.title = @"我猜";
    [self addChildViewController:ctl2];
}

/**
 属性设置
 */
- (void) resetShowStyle
{
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        
        *titleFont = systemOfFont(17);
        *isShowPregressView = YES;
        *isOpenStretch = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
