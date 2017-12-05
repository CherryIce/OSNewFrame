//
//  OSRegisterViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSRegisterViewController.h"

#import "OSWebViewController.h"

@interface OSRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *userAccountTf;
@property (weak, nonatomic) IBOutlet UIButton *regsiterBtn;


@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation OSRegisterViewController

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (IBAction)gainAuthCode:(UIButton *)sender
{
    if (![OSVerifyHelper checkMobileTel:_userAccountTf.text]) {
        return;
    }
    LoadingView * load = [[LoadingView alloc] init];
    [load show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [load dismiss];
        _time = KAuthCodeSecond;
        [self countDown];
    });
}

- (IBAction)registerAccount:(UIButton *)sender
{
    /**注册成功直接登录**/
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
#pragma mark 故事版的
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isStroyBoardShow"]) {
        [UIApplication sharedApplication].delegate.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
#pragma mark 纯代码的
    else{
        [UIApplication sharedApplication].delegate.window.rootViewController = [[OSCodeTabBarController alloc] init];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfo" object:nil];
    }
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:TransitionAnimTypeRippleEffect subType:TransitionSubtypesFromRamdom curve:TransitionCurveRamdom duration:1.0f];
}

- (IBAction)protocolShow:(UIButton *)sender {
    OSWebViewController * html = [[OSWebViewController alloc] init];
    html.url = @"https://www.baidu.com";
    html.jsMethodName = @"test";
    html.progressViewColor = [UIColor redColor];
    [self.navigationController showViewController:html sender:self];
}

- (IBAction)isCheckProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
    _regsiterBtn.backgroundColor = sender.selected ? kWhiteColor : Color235;
    _regsiterBtn.enabled = sender.selected;
}

/**
开始读秒
*/
- (void) countDown
{
    self.verifyBtn.enabled = NO;
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"%zd秒", _time] forState:UIControlStateNormal];
    self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timeAction:)
                                               userInfo:nil
                                                repeats:YES];
}

- (void)timeAction:(NSTimer *)timer
{
    --_time ;
    
    [self.verifyBtn setTitle:[NSString stringWithFormat:@"%zd秒", _time] forState:UIControlStateNormal];
    
    if (_time == 0) {
        [self stop];
    }
}

/**
 关掉定时器
 */
- (void)stop
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    self.verifyBtn.enabled = true;
    [self.verifyBtn setTitle:@"验证码" forState:UIControlStateNormal];
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
