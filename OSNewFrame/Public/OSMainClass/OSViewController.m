//
//  OSViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSViewController.h"

#import "ThreeViewController.h"

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
#pragma mark 从登录注册过来的刷新都不行 从appdelegate里面通知可以 oneviewcontroller里的通知会比appdeltegate晚触发,显示在最顶层
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"refreshUserInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"refreshUI" object:nil];
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
        dispatch_async(dispatch_get_main_queue(), ^{
            //这里进行UI更新
            if ([self isKindOfClass:[ThreeViewController class]]) {
                //code....
                [self showAlertWithTitle:@"通知测试" message:@"刷新用户信息" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
                    alertMaker.addActionCancelTitle(@"好的");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, EJAlertViewController * _Nonnull alertSelf) {
                    
                }];
                NSLog(@">>%@",userInfo);
            }
           
        });
    }
    if ([notificationName isEqualToString:@"refreshUserInfo"]) {
        if ([self isKindOfClass:[ThreeViewController class]]) {
            //code....
            [self showAlertWithTitle:@"通知测试" message:@"尼玛的" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
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

#pragma mark 键盘
- (UIView *)inputAccessoryView
{
    CGRect accessFrame = CGRectMake(0, 0, kScreenWidth, 44);
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:accessFrame];
    UIButton *closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-60, 4, 40, 40)];
    [closeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [closeBtn addTarget:self action:@selector(closeBeyBoard) forControlEvents:UIControlEventTouchDown];
    [toolbar addSubview:closeBtn];
    return toolbar;
}

- (void)closeBeyBoard
{
    for (id class in self.view.subviews)
    {
        if ([class isKindOfClass:[UITextView class]] || [class isKindOfClass:[UITextField class]]) {
            [class endEditing:YES];
        }
    }
    [self.view endEditing:YES];
}

//当有一个或多个手指触摸事件在当前视图或window窗体中响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    [self closeBeyBoard];
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
