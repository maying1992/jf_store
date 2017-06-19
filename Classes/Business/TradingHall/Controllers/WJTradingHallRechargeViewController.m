//
//  WJTradingHallRechargeViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallRechargeViewController.h"
#import "WJTradingHallRechargeTableViewCell.h"
#import "WJAdmissionModel.h"
#import "APITradeHallPaymentManager.h"

#import "WeixinPayManager.h"
#import "AlipayManager.h"

@interface WJTradingHallRechargeViewController ()<UITableViewDelegate,UITableViewDataSource,APIManagerCallBackDelegate>
{
    NSInteger selectCell;
}
@property(nonatomic ,strong) UITableView                        * mainTableView;
@property(nonatomic ,strong) WJAdmissionModel                   * admissionModel;
@property(nonatomic ,strong) APITradeHallPaymentManager         * tradeHallPaymentManager;

@end

@implementation WJTradingHallRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"交易大厅";
    selectCell = 3;
    [self navigationSetUp];
    [self UISetUp];
    [self.view addSubview:self.mainTableView];
    self.admissionModel = self.dataArray[0];
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
    if (self.rechargeFrom == TradingHallRechargeFromTradingHallView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTraingHallVCGoOutVC object:nil];
    }
}

- (void)paymentButtonAction
{
    if ([self.admissionModel.admissionType isEqualToString:@"个人"]) {
        self.tradeHallPaymentManager.feeType = @"1";
    }else{
        self.tradeHallPaymentManager.feeType = @"2";
    }
    self.tradeHallPaymentManager.payType = NumberToString(selectCell - 2);
    [self.tradeHallPaymentManager loadData];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary * dic = [manager fetchDataWithReformer:nil];
    if (selectCell - 2 == 1) {
        [[AlipayManager alipayManager]callAlipayWithOrderString:dic[@"prepayid"] NowController:self TotleCash:dic[@"order_total"]];
    }else{
        [[WeixinPayManager WXPayManager]callWexinPayWithPrePayid:dic[@"prepayid"]NowController:self TotleCash:dic[@"order_total"]];
    }
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
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
    if (indexPath.row == 2) {
        return 10;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <= 2) {
        UITableViewCell     * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = WJFont14;
        cell.textLabel.textColor = WJColorMainTitle;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"开通方式";
            UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 0.5)];
            bottomLine.backgroundColor = WJColorSeparatorLine1;
            [cell.contentView addSubview:bottomLine];
            
            UIImageView * imageIV = [[UIImageView alloc]initForAutoLayout];
            imageIV.image = [UIImage imageNamed:@"icon_arrow_right"];
            [cell.contentView addSubview:imageIV];
            [cell.contentView addConstraints:[imageIV constraintsRightInContainer:12]];
            [cell.contentView addConstraint:[imageIV constraintCenterYInContainer]];
            
            UILabel     * rightLabel = [[UILabel alloc]initForAutoLayout];
            rightLabel.font = WJFont14;
            rightLabel.textColor = WJColorMainTitle;
            rightLabel.text = self.admissionModel.admissionType;
            [cell.contentView addSubview:rightLabel];
            [cell.contentView addConstraints:[rightLabel constraintsRight:10 FromView:imageIV]];
            [cell.contentView addConstraint:[rightLabel constraintCenterYInContainer]];
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"金额";
            UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 0.5)];
            bottomLine.backgroundColor = WJColorSeparatorLine1;
            [cell.contentView addSubview:bottomLine];
            
            UILabel     * rightLabel = [[UILabel alloc]initForAutoLayout];
            rightLabel.font = WJFont14;
            rightLabel.textColor = WJColorMainTitle;
            rightLabel.text = [NSString stringWithFormat:@"%@元/季",self.admissionModel.admissionMoney];
            [cell.contentView addSubview:rightLabel];
            [cell.contentView addConstraints:[rightLabel constraintsRightInContainer:15]];
            [cell.contentView addConstraint:[rightLabel constraintCenterYInContainer]];
            
        }else{
            cell.backgroundColor = WJColorViewBg;
        }
        return cell;
        
    }else{
        WJTradingHallRechargeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJTradingHallRechargeTableViewCell"];
        if (cell == nil) {
            cell = [[WJTradingHallRechargeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJTradingHallRechargeTableViewCell"];
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"支付宝支付";
            [self cellSelect:indexPath.row Cell:cell];
        }else{
            cell.textLabel.text = @"微信支付";
            [self cellSelect:indexPath.row Cell:cell];
        }
        return cell;
    }
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
    if (indexPath.row == 0) {
        [self alertChoose];
    }
    if (indexPath.row > 2) {
        selectCell = indexPath.row;
        [self.mainTableView reloadData];
    }
}


- (void)alertChoose
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    for (WJAdmissionModel *model in self.dataArray) {
        [alert addAction:[UIAlertAction actionWithTitle:model.admissionType style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            for(WJAdmissionModel *model in self.dataArray) {
                if ([action.title isEqualToString:model.admissionType]) {
                    self.admissionModel = model;
                    [self.mainTableView reloadData];
                }
            }
        }]];
    }
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44*4 + 10) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.bounces = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


- (void)UISetUp
{
//    UILabel * topLabel= [[UILabel alloc]initForAutoLayout];
//    topLabel.backgroundColor = WJColorWhite;
//    NSString * textString = @"100元/季";
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
//    NSUInteger length = [textString length];
//    
//    NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.firstLineHeadIndent = 15;//距离左边
//    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
//    [attrString addAttribute:NSFontAttributeName value:WJFont14 range:NSMakeRange(0, length)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:WJColorDardGray3 range:NSMakeRange(0, length)];
//    topLabel.attributedText = attrString;
//    [self.view addSubview:topLabel];
//    [self.view addConstraints:[topLabel constraintsSize:CGSizeMake(kScreenWidth, 44)]];
//    [self.view addConstraints:[topLabel constraintsAssignTop]];
    
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

- (APITradeHallPaymentManager *)tradeHallPaymentManager
{
    if (_tradeHallPaymentManager == nil) {
        _tradeHallPaymentManager = [[APITradeHallPaymentManager alloc]init];
        _tradeHallPaymentManager.delegate = self;
    }
    return _tradeHallPaymentManager;
}


@end
