//
//  WJLotteryQueryViewController.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryQueryViewController.h"
#import "WJLotteryQueryCell.h"
@interface WJLotteryQueryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong) UITableView     *mainTableView;

@end

@implementation WJLotteryQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"抽奖查询";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ALD(44);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(44);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerVIew = [UIView new];
    
    UILabel *numL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, (kScreenWidth - ALD(24))/4, ALD(44))];
    numL.text = @"期数";
    numL.textColor = WJColorDardGray3;
    numL.font = WJFont12;
    numL.textAlignment = NSTextAlignmentLeft;
    [headerVIew addSubview:numL];
    
    UILabel *lotteryTimeL = [[UILabel alloc] initWithFrame:CGRectMake(numL.right, 0,(kScreenWidth - ALD(24))/4, ALD(44))];
    lotteryTimeL.text = @"抽奖时间";
    lotteryTimeL.textColor = WJColorDardGray3;
    lotteryTimeL.font = WJFont12;
    lotteryTimeL.textAlignment = NSTextAlignmentLeft;
    [headerVIew addSubview:lotteryTimeL];
    
    UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(lotteryTimeL.right, 0, (kScreenWidth - ALD(24))/4, ALD(44))];
    integralL.text = @"积分";
    integralL.textColor = WJColorDardGray3;
    integralL.font = WJFont12;
    integralL.textAlignment = NSTextAlignmentRight;
    [headerVIew addSubview:integralL];
    
    UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - integralL.width - ALD(12) , 0, (kScreenWidth - ALD(24))/4, ALD(44))];
    statusL.text = @"中奖状态";
    statusL.textColor = WJColorDardGray3;
    statusL.font = WJFont12;
    statusL.textAlignment = NSTextAlignmentRight;
    [headerVIew addSubview:statusL];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(ALD(12), ALD(44) - 1, kScreenWidth - ALD(24), 1)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [headerVIew addSubview:bottomLine];
    
    return headerVIew;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJLotteryQueryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJLotteryQueryTableViewCellIdentifier"];
    if (cell == nil) {
        cell = [[WJLotteryQueryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJLotteryQueryTableViewCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    return cell;
}


#pragma mark - Setter && Getter
- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = WJColorWhite;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}

@end
