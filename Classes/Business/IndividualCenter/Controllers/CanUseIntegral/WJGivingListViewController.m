//
//  WJGivingListViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingListViewController.h"
#import "WJGivingListTCell.h"
#import "WJIntegralGivingViewController.h"
@interface WJGivingListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WJRefreshTableView       *tableView;
@property(nonatomic,strong)NSMutableArray           *listArray;
@end

@implementation WJGivingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赠送";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJGivingListTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJGivingListTCellIdentifier"];
    
    if (cell == nil) {
        cell = [[WJGivingListTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJGivingListTCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    
    __weak typeof(self) weakSelf = self;

    cell.tapGivingBlock = ^{
        __strong typeof(self) strongSelf = weakSelf;

        WJIntegralGivingViewController *integralGivingVC = [[WJIntegralGivingViewController alloc] init];
        [strongSelf.navigationController pushViewController:integralGivingVC animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}



@end
