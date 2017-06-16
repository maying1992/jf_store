//
//  WJTradingHallOutputViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallOutputViewController.h"

#import "WJCanelOutputViewController.h"

@interface WJTradingHallOutputViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField * cellTextField;
}
@property(nonatomic ,strong) UITableView        * mainTableView;

@end

@implementation WJTradingHallOutputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    self.title = @"卖出";
    [self UISetUp];
    [self navigationSetup];
    [self.view addSubview:self.mainTableView];
}

- (void)navigationSetup
{
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 21);
    rightButton.titleLabel.font = WJFont14;
    [rightButton setTitle:@"撤销卖出" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)outputButtonAction
{
    
}

- (void)rightButtonAction
{
    WJCanelOutputViewController * canelOutputVC = [[WJCanelOutputViewController alloc]init];
    [self.navigationController pushViewController:canelOutputVC animated:YES];

}

- (void)cellCanelButtonAction:(UIButton *)button
{
    NSLog(@"点击了第%ld行按钮",button.tag-11000);
}


#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = WJFont15;
            cell.textLabel.textColor = WJColorDardGray3;
            cell.detailTextLabel.font = WJFont15;
            cell.detailTextLabel.textColor = WJColorDardGray3;
            UIView *bottomView = [[UIView alloc]initForAutoLayout];
            bottomView.backgroundColor = WJColorSeparatorLine;
            [cell.contentView addSubview:bottomView];
            [cell.contentView addConstraints:[bottomView constraintsSize:CGSizeMake(kScreenWidth, 0.5)]];
            [cell.contentView addConstraints:[bottomView constraintsAssignBottom]];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"可用积分数";
            cell.detailTextLabel.text = @"329000000积分";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"积分单位";
            cell.detailTextLabel.text = @"1000000可用积分";
        }else{
            cell.textLabel.text = @"当前价格";
            cell.detailTextLabel.text = @"20000多功能积分";
        }
        return cell;
        
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = WJFont15;
            cell.textLabel.textColor = WJColorDardGray3;
            cellTextField = [[UITextField alloc]initForAutoLayout];
            cellTextField.font = WJFont14;
            cellTextField.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:cellTextField];
            [cell.contentView addConstraints:[cellTextField constraintsRightInContainer:15]];
            [cell.contentView addConstraint:[cellTextField constraintCenterYInContainer]];
            [cell.contentView addConstraints:[cellTextField constraintsLeftInContainer:kScreenWidth - 220]];
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"卖出积分数";
            cellTextField.placeholder = @"输入交易积分1000的整数倍";
        }else{
            cell.textLabel.text = @"卖出价格";
            cellTextField.placeholder = @"不能低于当前价格";
        }
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - 44) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = WJColorViewBg;
        _mainTableView.bounces = NO;
    }
    return _mainTableView;
}

- (void)UISetUp
{
    UIButton * outputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outputButton.translatesAutoresizingMaskIntoConstraints = NO;
    [outputButton setTitle:@"卖出积分" forState:UIControlStateNormal];
    outputButton.titleLabel.font = WJFont16;
    [outputButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [outputButton setBackgroundColor:WJColorMainColor];
    [outputButton addTarget:self action:@selector(outputButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outputButton];
    [self.view addConstraints:[outputButton constraintsSize:CGSizeMake(kScreenWidth, 44)]];
    [self.view addConstraints:[outputButton constraintsBottomInContainer:0]];
    
}


@end
