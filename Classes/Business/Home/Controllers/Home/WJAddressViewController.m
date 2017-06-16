//
//  WJAddressViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAddressViewController.h"
#import "WJAddressTableViewCell.h"
#import "APISiteListManager.h"


@interface WJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    NSInteger selectAddress;
    NSInteger selectLanguage;
}

@property(nonatomic ,strong) UITableView            * addressTableView;
@property(nonatomic ,strong) APISiteListManager     * siteListManager;

@end

@implementation WJAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语言地区";
    selectAddress = 0;
    selectLanguage = 0;
    
    [self.view addSubview:self.addressTableView];
    [self UISetUp];
    [self.siteListManager loadData];
}

- (void)UISetUp
{
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.titleLabel setFont:WJFont14];
    [cancelButton setFrame:CGRectMake(0, 0, 25, 25)];
    [cancelButton setImage:[UIImage imageNamed:@"ommon_nav_btn_close"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton.titleLabel setFont:WJFont14];
    sureButton.backgroundColor = WJColorMainColor;
    [sureButton setFrame:CGRectMake(0, kScreenHeight -kNavBarAndStatBarHeight - 44, kScreenWidth, 44)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}


- (void)sureAction
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    
}
- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    
}


#pragma mark - UITableViewDelagate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, 30)];
    headerView.backgroundColor = WJColorViewBg;
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenHeight - 24, 30)];
    headerLabel.font = WJFont13;
    headerLabel.textColor = WJColorMainTitle;
    if (section == 0) {
        headerLabel.text = @"当前地区：中国大陆";
    }else{
        headerLabel.text = @"当前语言：简体中文";
    }
    [headerView addSubview:headerLabel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriceListCell"];
    if (cell == nil) {
        cell = [[WJAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriceListCell"];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == selectAddress) {
            [cell conFigData:YES];
        }else{
            [cell conFigData:NO];
        }
    }else{
        if (indexPath.row == selectLanguage) {
            [cell conFigData:YES];
        }else{
            [cell conFigData:NO];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        selectAddress = indexPath.row;
    }else{
        selectLanguage = indexPath.row;
    }
    [self.addressTableView reloadData];
}

- (UITableView *)addressTableView
{
    if (_addressTableView == nil) {
        _addressTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
        _addressTableView.backgroundColor = WJColorViewBg;
    }
    return _addressTableView;
}

- (APISiteListManager *)siteListManager
{
    if (_siteListManager == nil) {
        _siteListManager = [[APISiteListManager alloc]init];
        _siteListManager.delegate = self;
    }
    return _siteListManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
