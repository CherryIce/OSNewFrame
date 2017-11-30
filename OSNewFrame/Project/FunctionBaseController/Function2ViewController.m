//
//  Function2ViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "Function2ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface Function2ViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
}

@end


@implementation Function2ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationNavigation];
    [self locate];
}

/**
搜索框
*/
- (void) configurationNavigation
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIIMAGE(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchSomething:)];
}

/**
 搜索点击
 */
- (void) searchSomething:(UIBarButtonItem *)sender
{
    UIViewController * sb = [[UIStoryboard storyboardWithName:@"OSFunction2Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:@"OSSearchCtl"];
    [self.navigationController showViewController:sb sender:self];
}

/**
 开始定位
 **/
- (void)locate {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        
        locationManager.distanceFilter = 10.0;
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        // 临时开启后台定位  iOS9新增方法  必须要配置info.plist文件 不然直接崩溃
        if (@available(iOS 9.0, *)) {
            locationManager.allowsBackgroundLocationUpdates = YES;
        } else {
            // Fallback on earlier versions
        }
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        
        currentCity = [[NSString alloc] init];
        //[locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }
}

#pragma mark CoreLocation delegate
//定位失败则执行此代理方法
//定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:currentCity style:UIBarButtonItemStylePlain target:self action:@selector(changeCity:)];
            NSLog(@"%@",currentCity); //这就是当前的城市
            NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingLocation];
}

/**
 更换城市
 **/
- (void) changeCity:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"无法定位当前城市"]) {
        [locationManager startUpdatingLocation];
    }else{
        //弹出更换城市
    }
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
