//
//  OSSearchViewController.m
//  OSNewFrame
//
//  Created by Macx on 2017/11/29.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "OSSearchViewController.h"

#import "OSSearchNavBar.h"
#import "SectionLabelHeader.h"
#import "OSSearchTableHeaderView.h"
#import "OSSearchHistoryCell.h"

@interface OSSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) OSSearchNavBar * searchNavBar;

@property (nonatomic,strong) OSSearchTableHeaderView * tableHeaderView;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * recentArray;

@property (nonatomic,strong) NSMutableArray * suggstArray;

@end

static NSString * OSSearchHistoryCellID = @"OSSearchHistoryCell";

@implementation OSSearchViewController

- (OSSearchNavBar *)searchNavBar
{
    if (!_searchNavBar) {
        _searchNavBar = [[OSSearchNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KNavBarHeight)];
    }
    return _searchNavBar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [OSUIFactory initTableViewWithFrame:CGRectMake(0, KNavBarHeight, kScreenWidth, kScreenHeight - KNavBarHeight) style:UITableViewStyleGrouped delegate:self];
        _tableView.backgroundColor = kWhiteColor;
        [_tableView registerNib:[UINib nibWithNibName:OSSearchHistoryCellID bundle:nil] forCellReuseIdentifier:OSSearchHistoryCellID];
    }
    return _tableView;
}

- (NSMutableArray *)recentArray
{
    if (!_recentArray) {
        _recentArray = [NSMutableArray array];
    }
    return _recentArray;
}

- (NSMutableArray *)suggstArray
{
    if (!_suggstArray) {
        _suggstArray = [NSMutableArray array];
    }
    return _suggstArray;
}

- (OSSearchTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        CGFloat h = [self fitSizeHeight:self.suggstArray];
        _tableHeaderView = [[OSSearchTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, h) dataArray:self.suggstArray];
    }
    return _tableHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self configurationNavBar];
    [self configurationTableView];
}

/**
 请求数据
 */
- (void) initData
{
    self.suggstArray = [NSMutableArray arrayWithArray:@[@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师",@"UI设计师"]];
    __weak typeof(self) weakSelf = self;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableHeaderView.SuggstContentClickCallBack = ^(NSString *content) {
        [weakSelf updateCacheArray:content];
        //跳转到搜索显示列表
    };
}

/**
 导航栏
 */
- (void) configurationNavBar
{
    [self.view addSubview:self.searchNavBar];
    __weak typeof(self) weakSelf = self;
    self.searchNavBar.OSSearchCancelCallBack = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.searchNavBar.OSSearchSelectCityCallBack = ^{
        [weakSelf showAlertWithTitle:@"选择城市" message:@"可自定义popView或跳转选择城市" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, EJAlertViewController * _Nonnull alertSelf) {
            
        }];
    };
    self.searchNavBar.searchKeyWordCall = ^(NSString *keyword) {
        [weakSelf updateCacheArray:keyword];
        //跳转到搜索显示列表
        [weakSelf showAlertWithTitle:@"搜索结果" message:@"可跳转到搜索显示界面,按项目需求做" appearanceProcess:^(EJAlertViewController * _Nonnull alertMaker) {
            alertMaker.addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, EJAlertViewController * _Nonnull alertSelf) {
            
        }];
    };
}

/**
 表格视图
 */
- (void) configurationTableView
{
    [self.view addSubview:self.tableView];
    NSArray * dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"History_Search"];
    self.recentArray = dataArr.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSSearchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:OSSearchHistoryCellID];
    cell.content.text = self.recentArray[indexPath.row];
    cell.recentSearchDelteCallBack = ^{
        //删除当前这条历史数据
        [self.recentArray removeObject:self.recentArray[indexPath.row]];
        [[NSUserDefaults standardUserDefaults] setObject:self.recentArray forKey:@"History_Search"];
        [self.tableView reloadData];
    };
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return OSCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.recentArray.count > 0) {
        return OSCellHeight;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.recentArray.count > 0) {
        return OSCellHeight;
    }
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.recentArray.count > 0) {
        SectionLabelHeader * header = [[NSBundle mainBundle] loadNibNamed:@"SectionLabelHeader" owner:nil options:nil].lastObject;
        [header setFrame:CGRectMake(0, 0, kScreenWidth, OSCellHeight)];
        header.sectionTitleLab.text = @"最近搜索";
        return header;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.recentArray.count > 0) {
        UIView * footer = [OSUIFactory initViewWithFrame:CGRectMake(0, 0, kScreenWidth, OSCellHeight) color:kWhiteColor];
        UIButton * deleteAll = [OSUIFactory initButtonWithFrame:CGRectMake(OSCellHeight, 15, footer.width - 2*OSCellHeight, 35) title:@"清除历史记录" textColor:[UIColor darkGrayColor] font:systemOfFont(14) cornerRadius:0 tag:10 target:self action:@selector(delteAllClick)];
        [footer addSubview:deleteAll];
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**搜索之前的关键词**/
}

/**
 清除所有历史搜索记录
 */
- (void) delteAllClick
{
    [self.recentArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setObject:self.recentArray forKey:@"History_Search"];
    [self.tableView reloadData];
}

/**
 刷新缓存内容
 */
- (void) updateCacheArray:(NSString *)keyword
{
    NSArray * dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"History_Search"];
    NSMutableArray * dataArray = [NSMutableArray arrayWithArray:dataArr];
    if (![dataArray containsObject:keyword]) {
        [dataArray addObject:keyword];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"History_Search"];
}

/**
 隐藏系统导航栏
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

/**
 显示系统导航栏
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}

/**
 计算高度
 */
- (CGFloat ) fitSizeHeight:(NSArray *)dataArray
{
    CGFloat w = 0;
    CGFloat h = OSCellHeight;
    for (int i = 0; i < dataArray.count; i++) {
        //根据计算文字的大小
        CGFloat length = [OSUtilityHelper fitSizeWithLabel:dataArray[i] size:CGSizeMake(kScreenWidth - 20, 1000) font:systemOfFont(14)].width;
        
        if(OSSpace + w + length + 15 >= kScreenWidth){
            w = 0; //换行时将w置为0
            h = h + 30 + OSSpace;//距离父视图也变化
        }
        w = OSSpace + w + length + 15;
    }
    return h + 30 + OSSpace + 5;
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
