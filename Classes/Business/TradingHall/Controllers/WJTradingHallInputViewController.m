//
//  WJTradingHallInputViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallInputViewController.h"

@interface WJTradingHallInputViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField * cellTextField;
    UILabel * totalLabel;
}

@property(nonatomic ,strong) UITableView        * mainTableView;

@end

@implementation WJTradingHallInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买入";
    self.isHiddenTabBar = YES;
    [self UISetUp];
    [self.view addSubview:self.mainTableView];
}

- (void)sureButtonAction
{
    
}


#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
        cell.textLabel.text = @"积分总数";
        cell.detailTextLabel.text = @"329000000积分";
        return cell;
        
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = WJFont15;
            cell.textLabel.textColor = WJColorDardGray3;
            cellTextField = [[UITextField alloc]initForAutoLayout];
            cellTextField.placeholder = @"输入交易积分1000的整数倍";
            cellTextField.font = WJFont14;
            cellTextField.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:cellTextField];
            [cell.contentView addConstraints:[cellTextField constraintsRightInContainer:15]];
            [cell.contentView addConstraint:[cellTextField constraintCenterYInContainer]];
            [cell.contentView addConstraints:[cellTextField constraintsLeftInContainer:kScreenWidth - 220]];
        }
        cell.textLabel.text = @"购买积分数";

        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - 49) style:UITableViewStylePlain];
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
    UIView * bottomView = [[UIView alloc]initForAutoLayout];
    bottomView.backgroundColor = WJColorWhite;
    [self.view addSubview:bottomView];
    [self.view addConstraints:[bottomView constraintsSize:CGSizeMake(kScreenWidth, 49)]];
    [self.view addConstraints:[bottomView constraintsLeftInContainer:0]];
    [self.view addConstraints:[bottomView constraintsBottomInContainer:0]];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.translatesAutoresizingMaskIntoConstraints = NO;
    [sureButton setTitle:@"结算" forState:UIControlStateNormal];
    sureButton.titleLabel.font = WJFont14;
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 4;
    [sureButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [sureButton setBackgroundColor:WJColorMainColor];
    [sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureButton];
    [bottomView addConstraints:[sureButton constraintsSize:CGSizeMake(102, 35)]];
    [bottomView addConstraints:[sureButton constraintsRightInContainer:15]];
    [bottomView addConstraint:[sureButton constraintCenterYInContainer]];
    
    totalLabel = [[UILabel alloc]initForAutoLayout];
    NSString * textString = @"合计：20000多功能积分";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    NSUInteger length = [textString length];
    [attrString addAttribute:NSFontAttributeName value:WJFont14 range:NSMakeRange(0, length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:WJColorSubColor range:NSMakeRange(3, length-3)];
    totalLabel.attributedText = attrString;
    [bottomView addSubview:totalLabel];
    [bottomView addConstraints:[totalLabel constraintsSize:CGSizeMake(kScreenWidth, 44)]];
    [bottomView addConstraint:[totalLabel constraintCenterYInContainer]];
    [bottomView addConstraints:[totalLabel constraintsLeftInContainer:15]];
    
}

@end
