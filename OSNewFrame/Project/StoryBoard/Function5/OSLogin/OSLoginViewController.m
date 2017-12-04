//
//  OSLoginViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSLoginViewController.h"

#import "OSCodeTabBarController.h"

@interface OSLoginViewController ()

@end

@implementation OSLoginViewController

/**
 隐藏系统导航栏
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

/**
 显示系统导航栏
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Color235;
}

/**
 处理登陆回掉,刷新用户信息,通知处理
 */
- (IBAction)loginSomething:(UIButton *)sender{
#pragma mark 故事版的
//    [UIApplication sharedApplication].delegate.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
#pragma mark 纯代码的
    [UIApplication sharedApplication].delegate.window.rootViewController = [[OSCodeTabBarController alloc] init];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
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
