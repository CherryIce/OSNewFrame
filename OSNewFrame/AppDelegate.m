//
//  AppDelegate.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "AppDelegate.h"

#import "OSGuideViewController.h"

@interface AppDelegate ()<OSGuideSelectDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
