//
//  WJRechargeOrderDetailViewController.m
//  jf_store
//
//  Created by reborn on 17/5/11.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRechargeOrderDetailViewController.h"
@interface WJRechargeOrderDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView      *bottomView;
    UILabel     *totalAmountL;
}
@property(nonatomic,strong)UITableView                  *tableView;

@end

@implementation WJRechargeOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.isHiddenTabBar = YES;
        
    [self initBottomView];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

-(void)initBottomView
{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavigationBarHeight - ALD(64), kScreenWidth, ALD(64))];
    
    bottomView.backgroundColor = WJColorWhite;
    bottomView.layer.borderWidth = 0.5f;
    bottomView.layer.borderColor =  WJColorSeparatorLine.CGColor;
    
    totalAmountL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), kScreenWidth - ALD(12) - ALD(160) - ALD(24), ALD(30))];
    totalAmountL.font = WJFont13;
    totalAmountL.textAlignment = NSTextAlignmentLeft;
    
    NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@元",@"4324"];
    totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
    [bottomView addSubview:totalAmountL];
    
    if (self.orderModel.orderStatus == OrderStatusUnfinished || self.orderModel.orderStatus == OrderStatusWaitCheck) {
        
        if (self.orderModel.individualOrderType == OrderTypeRecharge) {
            
            UIButton *payRigthNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            payRigthNowButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
            [payRigthNowButton setTitle:@"付款"
                               forState:UIControlStateNormal];
            [payRigthNowButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
            payRigthNowButton.titleLabel.font = WJFont14;
            payRigthNowButton.backgroundColor = WJColorMainColor;
            payRigthNowButton.layer.cornerRadius = 4;
            [payRigthNowButton addTarget:self action:@selector(payRigthNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:payRigthNowButton];
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@元",@"4324"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
            
        } else if (self.orderModel.individualOrderType == OrderTypeGiving) {
            
            UIButton *cancelCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelCheckButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
            [cancelCheckButton setTitle:@"取消审核"
                               forState:UIControlStateNormal];
            [cancelCheckButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
            cancelCheckButton.titleLabel.font = WJFont14;
            cancelCheckButton.backgroundColor = WJColorMainColor;
            cancelCheckButton.layer.cornerRadius = 4;
            [cancelCheckButton addTarget:self action:@selector(cancelCheckButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:cancelCheckButton];
            
        } else if (self.orderModel.individualOrderType == OrderTypeTrading) {
            
            UIButton *payRigthNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
            payRigthNowButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
            [payRigthNowButton setTitle:@"付款"
                               forState:UIControlStateNormal];
            [payRigthNowButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
            payRigthNowButton.titleLabel.font = WJFont14;
            payRigthNowButton.backgroundColor = WJColorMainColor;
            payRigthNowButton.layer.cornerRadius = 4;
            [payRigthNowButton addTarget:self action:@selector(payRigthNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:payRigthNowButton];
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"多功能积分: %@",@"4324"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:6];
        }
    
        
    } else if (self.orderModel.orderStatus == OrderStatusClose || self.orderModel.orderStatus == OrderStatusCancelCheck) {
        
        if (self.orderModel.individualOrderType == OrderTypeRecharge) {
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@元",@"4324"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
            
        } else if (self.orderModel.individualOrderType == OrderTypeGiving) {
            
            
        } else if (self.orderModel.individualOrderType == OrderTypeTrading) {
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"多功能积分: %@",@"5000"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:6];
        }
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
        [deleteButton setTitle:@"删除"
                      forState:UIControlStateNormal];
        [deleteButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        deleteButton.titleLabel.font = WJFont14;
        deleteButton.backgroundColor = WJColorMainColor;
        deleteButton.layer.cornerRadius = 4;
        [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:deleteButton];
        
    } else if (self.orderModel.orderStatus == OrderStatusSuccess) {
        
        if (self.orderModel.individualOrderType == OrderTypeRecharge) {
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@元",@"4324"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
            
        } else if (self.orderModel.individualOrderType == OrderTypeGiving) {
            
            bottomView.hidden = YES;
            
        } else if (self.orderModel.individualOrderType == OrderTypeTrading) {
            
            NSString *totalAmountStr = [NSString stringWithFormat:@"多功能积分: %@",@"12000"];
            totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:6];
        }
        
    }
    
    [self.view addSubview:bottomView];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ALD(90);
    } else {
        return ALD(200);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ALD(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *orderCellIdentifier = @"orderCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    switch (indexPath.section) {
        case 0:
        {
            UILabel *orderTypeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), ALD(150), ALD(20))];
            orderTypeL.text = @"充值";
            orderTypeL.textColor = WJColorDardGray3;
            orderTypeL.font = WJFont12;
            [cell.contentView addSubview:orderTypeL];

            
            UILabel *statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(50), ALD(10), ALD(50), ALD(20))];
            statusL.textAlignment = NSTextAlignmentRight;
            statusL.textColor = WJColorDardGray3;
            statusL.font = WJFont12;
            [cell.contentView addSubview:statusL];
            
            
            switch (self.orderModel.orderStatus) {
                case OrderStatusSuccess:
                {
                    statusL.text = @"完成";
                }
                    break;
                    
                case OrderStatusUnfinished:
                {
                    statusL.text = @"未支付";
                }
                    break;
                    
                case OrderStatusClose:
                {
                    statusL.text = @"取消订单";
                }
                    break;
                    
                case OrderStatusWaitDeliver:
                {
                    statusL.text = @"待发货";
                }
                    break;
                    
                case OrderStatusWaitReceive:
                {
                    statusL.text = @"待收货";
                }
                    break;
                    
                case OrderStatusRefunding:
                {
                    statusL.text = @"退款中";
                }
                    break;
                    
                    
                case OrderStatusWaitCheck:
                {
                    statusL.text = @"待审核";
                }
                    break;
                    
                case OrderStatusCancelCheck:
                {
                    statusL.text = @"取消审核";
                }
                    break;
                    
                default:
                    break;
            }
            
            UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), orderTypeL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
            line.backgroundColor = WJColorSeparatorLine;
            [cell.contentView addSubview:line];
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), line.bottom, kScreenWidth - ALD(24), ALD(20))];
            nameL.text = @"可用积分充值";
            nameL.textColor = WJColorDardGray3;
            nameL.font = WJFont13;
            [cell.contentView addSubview:nameL];
            
            UILabel *creditsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), nameL.bottom + ALD(5), kScreenWidth - ALD(24), ALD(20))];
            creditsL.text = [NSString stringWithFormat:@"积分充值：%@",@"213213"];
            creditsL.textColor = WJColorDardGray3;
            creditsL.font = WJFont12;
            [cell.contentView addSubview:creditsL];

        }
            break;
            
        case 1:
        {
            UILabel *orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, kScreenWidth - ALD(24), ALD(20))];
            orderNoL.text = [NSString stringWithFormat:@"订单编号：%@",@"213213"];
            orderNoL.textColor = WJColorDardGray3;
            orderNoL.font = WJFont13;
            [cell.contentView addSubview:orderNoL];
            
            UILabel *submitTimeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), orderNoL.bottom, kScreenWidth - ALD(24), ALD(20))];
            submitTimeL.text = [NSString stringWithFormat:@"提交时间：%@",@"213213"];
            submitTimeL.textColor = WJColorDardGray3;
            submitTimeL.font = WJFont12;
            [cell.contentView addSubview:submitTimeL];
        }
            break;
            
        default:
            break;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - Action
-(void)payRigthNowButtonAction
{
    
}

-(void)deleteButtonAction
{
    
}

-(void)logisticsButtonAction
{
    
}

-(void)buyAgainButtonAction
{
    
}

-(void)finishButtonAction
{
    
}

-(void)refundOnlyButtonAction
{
    
}

-(void)cancelCheckButtonAction
{
    
}

- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont12,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont12,
                                              NSForegroundColorAttributeName : WJColorSubColor,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

#pragma mark - setter& getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(64)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorInset = UIEdgeInsetsZero;
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
