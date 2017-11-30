//
//  Function4ViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "Function4ViewController.h"

#import "XFCameraController.h"

#import "OSPlayView.h"

@interface Function4ViewController ()

@property (nonatomic,strong) UIImageView * showImg;

@property (nonatomic,retain) UIButton * playBtn;

@property (nonatomic,strong) NSURL * videoUrl;

@end

@implementation Function4ViewController

- (UIImageView *)showImg
{
    if (!_showImg) {
        _showImg = [[UIImageView alloc] initWithFrame:CGRectMake(2*OSCellHeight, KNavBarHeight+OSSpace*2+OSCellHeight, self.view.width - 4*OSCellHeight, (self.view.width - 4*OSCellHeight)*kScreenHeight/kScreenWidth)];
        _showImg.backgroundColor = Color235;
    }
    return _showImg;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [OSUIFactory initButtonWithFrame:CGRectMake(0, 0, 2*OSCellHeight, 2*OSCellHeight) image:UIIMAGE(@"4s") cornerRadius:OSSpace tag:11 target:self action:@selector(buttonClick:)];
        _playBtn.hidden = true;
        _playBtn.enabled = false;
        _playBtn.center = self.showImg.center;
    }
    return _playBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationUI];
}

/**
 搭UI
 */
- (void) configurationUI
{
    UIButton * videoBtn = [OSUIFactory initButtonWithFrame:CGRectMake(OSCellHeight, KNavBarHeight+OSSpace, self.view.width - 2*OSCellHeight, OSCellHeight) title:@"仿微信录制视频拍照" textColor:[UIColor darkTextColor] font:nil cornerRadius:OSSpace tag:10 target:self action:@selector(buttonClick:)];
    videoBtn.backgroundColor = Color235;
    [self.view addSubview:videoBtn];
    
    [self.view addSubview:self.showImg];
    [self.view addSubview:self.playBtn];
}

- (void) showImgResetUI:(UIImage *)showImage
{
    self.showImg.image = showImage;
    self.playBtn.enabled = true;
    self.playBtn.hidden = false;
}

- (void) buttonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 10:
        {
            [self transcribe];
        }
            break;
        case 11:
        {
            [self playVideo];
        }
            break;
        default:
            break;
    }
}

/**
 录制
 */
- (void) transcribe
{
    XFCameraController *cameraController = [XFCameraController defaultCameraController];
    
    __weak XFCameraController *weakCameraController = cameraController;
    
    cameraController.takePhotosCompletionBlock = ^(UIImage *image, NSError *error) {
#pragma mark 此处是拍照
        //回归主线程操作
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    };
    
    cameraController.shootCompletionBlock = ^(NSURL *videoUrl, CGFloat videoTimeLength, UIImage *thumbnailImage, NSError *error) {
#pragma mark 此处是视频
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _videoUrl = videoUrl;
            [self showImgResetUI:thumbnailImage];
        }];
        [weakCameraController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:cameraController animated:YES completion:nil];
}

/**
 播放
 */
- (void) playVideo
{
    OSPlayView * playView = [[OSPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds videoUrl:_videoUrl];
    [[UIApplication sharedApplication].keyWindow addSubview:playView];
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
