//
//  OSViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSViewController.h"

#import "Function5ViewController.h"

@interface OSViewController ()

@end

@implementation OSViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    //如果有推送 在这里注册所有通知,然后执行操作 获取当前控制器再执行相关的操作...
    //eg...
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"refreshUserInfo" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kWhiteColor;
}

- (void) doSomething:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString * notificationName = [notification name];
    if ([notificationName isEqualToString:@"refreshUserInfo"]) {
        if ([self isKindOfClass:[Function5ViewController class]]) {
            //code....
            [self showAlertWithTitle:@"通知测试" message:@"刷新用户信息" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
                alertMaker.addActionCancelTitle(@"好的");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, EJAlertViewController * _Nonnull alertSelf) {
                
            }];
            NSLog(@">>%@",userInfo);
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
