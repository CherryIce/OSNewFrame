//
//  Function1ViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "Function1ViewController.h"

#import "OSDisplayListsCell.h"

#import "OSWebViewController.h"
#import "DYQBannerScrollView.h"

@interface Function1ViewController ()<UITableViewDelegate,UITableViewDataSource,DYQBannerScrollViewDelegate,SGScanningQRCodeVCDelegate>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) DYQBannerScrollView * bannerScrollView;

@end

static NSString * OSDisplayListsCellID = @"OSDisplayListsCell";

@implementation Function1ViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [OSUIFactory initTableViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped delegate:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:OSDisplayListsCellID bundle:nil] forCellReuseIdentifier:OSDisplayListsCellID];
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (DYQBannerScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        _bannerScrollView = [[DYQBannerScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width/2)];
        _bannerScrollView.pageControlPosition = PageControlPositionCenter;
        _bannerScrollView.timeInterval = 3;
        _bannerScrollView.delegate = self;
    }
    return _bannerScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationNavigation];
    [self configurationTableView];
    [self pullRefresh];
}

/**
 搜索框
 */
- (void) configurationNavigation
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIIMAGE(@"scan") style:UIBarButtonItemStylePlain target:self action:@selector(scanSomething:)];
}

- (void) configurationTableView
{
    self.dataArray = @[@"黑夜无论怎样悠长，白昼总会到来。",@"一个人思虑太多，就会失去做人的乐趣。",@"在时间的大钟上，只有两个字「现在」。",@"To be or not to be,that's a question.\n生存还是毁灭，这是个问题",@"爱所有人，信任少数人，不负任何人。",@"要和一个男人相处的快乐，你应该多多了解他而不必太爱他；要和一个女人相处的快乐，你应该多爱她，却别想要了解她！",@"适当的悲哀可以表示感情的深切，过度的伤心却可以证明智慧的欠缺。"].mutableCopy;
    self.tableView.tableHeaderView = self.bannerScrollView;
    self.bannerScrollView.imageUrls = [NSArray arrayWithObjects:@"http://a.cphotos.bdimg.com/timg?image&quality=100&size=b4000_4000&sec=1479712043&di=5c01c9250aaa411825d6802cf8c9c57e&src=http://pic.baike.soso.com/p/20111015/bki-20111015183540-1861675088.jpg",@"http://img4.duitang.com/uploads/item/201511/22/20151122231316_E5A8F.thumb.700_0.jpeg",@"http://img5.duitang.com/uploads/item/201502/24/20150224142121_axcUN.jpeg",@"http://a.cphotos.bdimg.com/timg?image&quality=100&size=b4000_4000&sec=1479712043&di=1ff2077e9749540187c1b1daae8b370b&src=http://img103.mypsd.com.cn/20130502/1/Mypsd_13585_201305020822350023B.jpg",nil];
}

/**下拉刷新*/
- (void) pullRefresh
{
    self.tableView.mj_header = [MyRefreshHeader headerWithRefreshingBlock:^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 二维码操作
 */
- (void)scanSomething:(UIBarButtonItem *)item
{
    [OSUtilityHelper scanRQCode:self];
}

/**
 二维码结果回掉
 */
-(void)scanSuccessBarcodeJump:(NSString*)str
{
    
}

#pragma mark YQBannerScrollViewDelegate
/**展示图点击事件**/
- (void)bannerScrollView:(DYQBannerScrollView *)bannerScrollView didSelectItemAtIndex:(NSInteger )index
{
    OSWebViewController * html = [[OSWebViewController alloc] init];
    html.url = @[@"https://www.baidu.com",@"https://www.weibo.com",@"http://www.jianshu.com",@"https://github.com"][index];
    html.jsMethodName = @"test";
    html.progressViewColor = [UIColor redColor];
    [self.navigationController pushViewController:html animated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSDisplayListsCell * cell = [tableView dequeueReusableCellWithIdentifier:OSDisplayListsCellID];
    cell.msg = self.dataArray[indexPath.row];
    //cell.showMsgLab.text = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //点击回调
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
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
