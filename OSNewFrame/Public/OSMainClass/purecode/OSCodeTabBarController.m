//
//  OSCodeTabBarController.m
//  OSNewFrame
//
//  Created by Macx on 2017/12/4.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSCodeTabBarController.h"
#import "OSNavigationController.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface OSCodeTabBarController ()

@end

@implementation OSCodeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewController:[[OneViewController alloc] init] navTitle:AppName tabbarTitle:@"one" tabbarImage:@"2"];
    [self addChildViewController:[[TwoViewController alloc] init] navTitle:@"AAA" tabbarTitle:@"two" tabbarImage:@"4"];
    [self addChildViewController:[[ThreeViewController alloc] init] navTitle:@"ZZZ" tabbarTitle:@"three" tabbarImage:@"5"];

}

- (void)addChildViewController:(UIViewController *)controller navTitle:(NSString *)navTitle tabbarTitle:(NSString *)tabbarTitle tabbarImage:(NSString *)tabbarImage{
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorHex(999999);
    selectTextAttrs[NSForegroundColorAttributeName] = UIColorHex(707070);
    [controller.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [controller.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    OSNavigationController *nav = [[OSNavigationController alloc]initWithRootViewController:controller];
    controller.navigationItem.title = navTitle;
    controller.tabBarItem.title = tabbarTitle;
    controller.tabBarItem.image = [[UIImage imageNamed:tabbarImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage= [[UIImage imageNamed:[NSString stringWithFormat:@"%@s",tabbarImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
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
