//
//  ThreeViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/12/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void) initUI
{
    UIButton * changeBtn = [OSUIFactory initButtonWithFrame:CGRectMake(0, 0, 200, 50) title:@"切换故事版模式" textColor:[UIColor darkTextColor] font:systemOfFont(15) cornerRadius:25 tag:10 target:self action:@selector(changeClick)];
    changeBtn.backgroundColor = kNavBarTintColor;
    changeBtn.center = self.view.center;
    [self.view addSubview:changeBtn];
}

/** 切换故事版模式 */
- (void) changeClick
{
    [[NSUserDefaults standardUserDefaults] setObject:@(true) forKey:@"isStroyBoardShow"];
    [UIApplication sharedApplication].delegate.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:2.0f];
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
