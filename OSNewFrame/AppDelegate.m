//
//  AppDelegate.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "AppDelegate.h"

#import "OSNavigationController.h"
#import "OSGuideViewController.h"

@interface AppDelegate ()<OSGuideSelectDelegate>

@property (nonatomic,assign) BOOL isEnterBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _isEnterBackground = false;
    /**
     获取是否存在缓存
     */
    [self gainUserModel];
    
    [self configAppearance];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([OSGuideViewController isShow]) {
        OSGuideViewController * guide = [[OSGuideViewController alloc] init];
        self.window.rootViewController = guide;
        guide.delegate = self;
        [guide guidePageControllerWithImages:@[@"pager1",@"pager2"]];
    }else{
        [self clickEnter];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void) clickEnter
{
    UIViewController * loginCtl = [[UIStoryboard storyboardWithName:@"OSLoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"OSLogin"];
    self.window.rootViewController = [[OSNavigationController alloc] initWithRootViewController:loginCtl];
    [self.window.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:2.0f];
}

- (void) gainUserModel
{
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@UserModel",AppName]];
    if (data) {
        if ([data isKindOfClass:[NSString class]]) {
            if (data.length <= 0) {
                [OSUserInfoManage shareInstance].is_login = NO;
            }
        }else{
            //在这里解档
            id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                [OSUserInfoManage shareInstance].userInfo = [[OSUserModel alloc] initWithDictionary:obj];
                [OSUserInfoManage shareInstance].is_login = YES;
            }
        }
        
    }else{
        [OSUserInfoManage shareInstance].is_login = NO;
    }
}

- (void)configAppearance
{
    [[UINavigationBar appearance] setTintColor:[UIColor darkTextColor]];
    [[UITabBar appearance] setTintColor:[UIColor darkGrayColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
#pragma mark 测试通知
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
     /**进入后台*/
    _isEnterBackground = true;
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    [[NSUserDefaults standardUserDefaults] setObject:date2 forKey:@"lastTime"];
    NSLog(@"date2时间戳 = %@",date2);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /**进入前台*/
    if (_isEnterBackground) {
        NSDate *senddate = [NSDate date];
        NSString * current = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
        NSString * last = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastTime"];
        if ([current longLongValue] - [last longLongValue] >= 30) {
            [self clickEnter];
        }
        _isEnterBackground = false;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
