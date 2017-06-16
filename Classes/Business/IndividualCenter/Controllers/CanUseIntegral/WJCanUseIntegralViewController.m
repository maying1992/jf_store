//
//  WJCanUseIntegralViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCanUseIntegralViewController.h"
#import "WJCanUseIntegralCell.h"
#import "WJRefreshTableView.h"
@interface WJCanUseIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WJRefreshTableView       *tableView;
@property(nonatomic,strong)NSMutableArray           *listArray;
@end

@implementation WJCanUseIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可用积分";
    self.isHiddenTabBar = YES;
    
    [self SetUI];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetUI
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(170))];
    topView.backgroundColor = WJColorMainColor;
    
    UILabel *canUseIntegralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(20), ALD(100), ALD(20))];
    canUseIntegralL.text = @"可用积分";
    canUseIntegralL.textColor = WJColorWhite;
    canUseIntegralL.font = WJFont15;
    
    
    UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), canUseIntegralL.bottom + ALD(23), kScreenWidth - ALD(32) - ALD(120) , ALD(50))];
    integralL.textColor = WJColorWhite;
    integralL.textAlignment = NSTextAlignmentLeft;
    integralL.font = WJFont45;
    integralL.text = @"2350积分";
    
    
    [self.view addSubview:topView];
    [topView addSubview:canUseIntegralL];
    [topView addSubview:integralL];
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
    
    WJCanUseIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCanUseIntegralCellIdentifier"];
    
    if (cell == nil) {
        cell = [[WJCanUseIntegralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJCanUseIntegralCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, ALD(170), kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(170)) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
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
