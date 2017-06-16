//
//  WJTradingHallRechargeViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallRechargeViewController.h"
#import "WJTradingHallRechargeTableViewCell.h"

@interface WJTradingHallRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selectCell;

}
@property(nonatomic ,strong) UITableView        * mainTableView;

@end

@implementation WJTradingHallRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"交易大厅";
    selectCell = 0;
    [self navigationSetUp];
    [self UISetUp];
    [self.view addSubview:self.mainTableView];
}

- (void)navigationSetUp
{
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.titleLabel setFont:WJFont14];
    [cancelButton setFrame:CGRectMake(0, 0, 40, 30)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)cancelAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentButtonAction
{
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJTradingHallRechargeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[WJTradingHallRechargeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"微信支付";
        [self cellSelect:indexPath.row Cell:cell];
    }else{
        cell.textLabel.text = @"支付宝支付";
        [self cellSelect:indexPath.row Cell:cell];
    }
    return cell;
}

- (void)cellSelect:(NSInteger )indexPathRow Cell:(WJTradingHallRechargeTableViewCell *)cell
{
    if (indexPathRow == selectCell) {
        [cell conFigData:YES];
    }else{
        [cell conFigData:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectCell = indexPath.row;
    [self.mainTableView reloadData];
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 + 10, kScreenWidth, kScreenHeight -kNavBarAndStatBarHeight - 88 - 10) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


- (void)UISetUp
{
    UILabel * topLabel= [[UILabel alloc]initForAutoLayout];
    topLabel.backgroundColor = WJColorWhite;
    NSString * textString = @"100元/季";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    NSUInteger length = [textString length];
    
    NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = 15;//距离左边
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
    [attrString addAttribute:NSFontAttributeName value:WJFont14 range:NSMakeRange(0, length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:WJColorDardGray3 range:NSMakeRange(0, length)];
    topLabel.attributedText = attrString;
    [self.view addSubview:topLabel];
    [self.view addConstraints:[topLabel constraintsSize:CGSizeMake(kScreenWidth, 44)]];
    [self.view addConstraints:[topLabel constraintsAssignTop]];
    
    UIButton * paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentButton.translatesAutoresizingMaskIntoConstraints = NO;
    [paymentButton setTitle:@"支付" forState:UIControlStateNormal];
    paymentButton.titleLabel.font = WJFont16;
    [paymentButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [paymentButton setBackgroundColor:WJColorMainColor];
    [paymentButton addTarget:self action:@selector(paymentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
    [self.view addConstraints:[paymentButton constraintsSize:CGSizeMake(kScreenWidth, 44)]];
    [self.view addConstraints:[paymentButton constraintsBottomInContainer:0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
