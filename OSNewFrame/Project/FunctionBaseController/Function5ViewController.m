//
//  Function5ViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "Function5ViewController.h"

#import "OSSetupViewController.h"

@interface Function5ViewController ()

@end

@implementation Function5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginClick:(UIButton *)sender {
    UIViewController * sb = [[UIStoryboard storyboardWithName:@"OSLoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"OSLogin"];
    [self.navigationController showViewController:sb sender:self];
}

- (IBAction)setupClick:(UIButton *)sender {
    OSSetupViewController * ctl = [[OSSetupViewController alloc] init];
    ctl.title = @"属性设置";
    [self.navigationController showViewController:ctl sender:self];
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
