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
#import "WJAddressReformer.h"
#import "WJAddressModel.h"


@interface WJAddressViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    NSInteger selectAddress;
    NSInteger selectLanguage;
}

@property(nonatomic ,strong) UITableView            * addressTableView;
@property(nonatomic ,strong) APISiteListManager     * siteListManager;
@property(nonatomic,strong) NSMutableArray          * addressArray;
@property(nonatomic,strong) NSMutableArray          * languageArray;


@end

@implementation WJAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语言地区";
    if (SITE_NAME == nil) {
        selectAddress = 0;
    }else{
        selectAddress = [SITE_NUM integerValue];
    }
    if (LANGUAGE_NAME == nil) {
        selectLanguage = 0;
    }else{
        selectLanguage = [LANGUAGE_NUM integerValue];
    }
    
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
    self.addressArray = [manager fetchDataWithReformer:[WJAddressReformer new]];
    [self.addressTableView reloadData];
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}


#pragma mark - UITableViewDelagate/UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.addressArray.count;
    }else{
        return self.languageArray.count;
    }
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
        if (SITE_NAME == nil) {
            WJAddressModel * model = self.addressArray[0];
            headerLabel.text = [NSString stringWithFormat:@"当前地区：%@",model.siteName];
        }else{
            headerLabel.text = [NSString stringWithFormat:@"当前地区：%@",SITE_NAME];
        }
    }else{
        if (LANGUAGE_NAME == nil){
            headerLabel.text = [NSString stringWithFormat:@"当前语言：%@",self.languageArray[0]];
        }else{
            headerLabel.text = [NSString stringWithFormat:@"当前语言：%@",LANGUAGE_NAME];
        }
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
        WJAddressModel * model = self.addressArray[indexPath.row];
        cell.textLabel.text = model.siteName;
        if (indexPath.row == selectAddress) {
            [cell conFigData:YES];
        }else{
            [cell conFigData:NO];
        }
    }else{
        cell.textLabel.text = self.languageArray[indexPath.row];
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
        WJAddressModel * model = self.addressArray[indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:model.siteName forKey:KSitName];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:KSitNum];
        [[NSUserDefaults standardUserDefaults] setObject:model.siteId forKey:KSitID];
    }else{
        selectLanguage = indexPath.row;
        [[NSUserDefaults standardUserDefaults] setObject:self.languageArray[indexPath.row] forKey:KLanguageName];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:KLanguageNum];
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

- (NSMutableArray *)languageArray
{
    if (_languageArray == nil) {
        _languageArray = [[NSMutableArray alloc]initWithArray:@[@"中文",@"英文",@"韩文",@"日文",@"俄文",@"希腊文"]];
    }
    return _languageArray;
}

@end
