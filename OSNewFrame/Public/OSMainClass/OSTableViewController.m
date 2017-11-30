//
//  OSTableViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/30.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSTableViewController.h"

@interface OSTableViewController ()<OSPlaceholderViewDelegate>

@end

@implementation OSTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self checkIsConnectNet]) {
        [self showLoading];
    }else{
        [self showNoNetwork];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior =  UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    self.tableView.tableFooterView = [UIView new];
}

/** 判断当前网络 */
- (BOOL) checkIsConnectNet
{
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
//    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            return false;
//        }else{
//            return true;
//        }
//    }];
    /** 正确判断是上面注释的判断,以下判断是为了第一次进来是默认没网状态 */
    return netManager.isReachable;
}

/** 没网络 */
- (void) showNoNetwork
{
    OSPlaceholderView * placeholderView = [[OSPlaceholderView alloc]initWithFrame:CGRectMake(0, KNavBarHeight, kScreenWidth, kScreenHeight - KNavBarHeight) type:OSPlaceholderViewTypeNoNetwork table:OSHomeTableViewType delegate:self];
    [self.tableView addSubview:placeholderView];
}

/** 试试没品 */
- (void) showNoGoods
{
    OSPlaceholderView * placeholderView = [[OSPlaceholderView alloc]initWithFrame:CGRectMake(0, KNavBarHeight, kScreenWidth, kScreenHeight - KNavBarHeight) type:OSPlaceholderViewTypeNoGoods table:OSHomeTableViewType delegate:self];
    [self.tableView addSubview:placeholderView];
}

/** 恐怖的占位图 */
- (void) showLoading
{
    OSPlaceholderView * placeholderView = [[OSPlaceholderView alloc]initWithFrame:CGRectMake(0, KNavBarHeight, kScreenWidth, kScreenHeight - KNavBarHeight) type:OSPlaceholderViewTypeLoading table:OSHomeTableViewType delegate:self];
    [self.tableView addSubview:placeholderView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [placeholderView removeFromSuperview];
        [self showNoGoods];
    });
}

#pragma mark - Delegate - 占位图
/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(OSPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
    switch (placeholderView.type) {
        case OSPlaceholderViewTypeNoGoods:
        {
            //要么去添加,要么gg
            [self showLoading];
        }
            break;
        case OSPlaceholderViewTypeNoNetwork:
        {
            //网络好了就去刷新数据
            [self showLoading];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
