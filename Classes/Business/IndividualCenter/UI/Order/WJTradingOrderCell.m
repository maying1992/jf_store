//
//  WJTradingOrderCell.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingOrderCell.h"

@interface WJTradingOrderCell ()
{
    UILabel     *orderTypeL;
    UILabel     *statusL;
    
    UILabel     *nameL;
    UILabel     *chargeCreditsL;
    
    UILabel     *totalMoneyL;
    
    UIButton    *payRightNowButton;     //付款
    UIButton    *cancelOrderButton;     //取消订单
    UIButton    *deleteOrderButton;     //删除订单
    UIButton    *buyAgainButton;      //再次购买
}

@end

@implementation WJTradingOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = WJColorWhite;
        
        orderTypeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(200), ALD(22))];
        orderTypeL.textAlignment = NSTextAlignmentLeft;
        orderTypeL.textColor = WJColorDarkGray;
        orderTypeL.font = WJFont12;
        
        statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), 0, ALD(100), ALD(22))];
        statusL.textAlignment = NSTextAlignmentRight;
        statusL.textColor = WJColorDarkGray;
        statusL.font = WJFont12;
        
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), orderTypeL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
        line.backgroundColor = WJColorSeparatorLine;
        
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), line.bottom,kScreenWidth - ALD(24), ALD(22))];
        nameL.textAlignment = NSTextAlignmentLeft;
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont15;
        
        chargeCreditsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), nameL.bottom,kScreenWidth - ALD(24), ALD(22))];
        chargeCreditsL.textAlignment = NSTextAlignmentLeft;
        chargeCreditsL.textColor = WJColorDardGray9;
        chargeCreditsL.font = WJFont12;
        
        UIView *middleLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), line.bottom + ALD(66), kScreenWidth - ALD(24), 0.5f)];
        middleLine.backgroundColor = WJColorSeparatorLine;
        
        
        totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(0, middleLine.bottom, kScreenWidth - ALD(12), ALD(44))];
        totalMoneyL.textAlignment = NSTextAlignmentRight;
        totalMoneyL.textColor = WJColorDardGray3;
        totalMoneyL.font = WJFont12;
        
        
        
        UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), middleLine.bottom + ALD(44), kScreenWidth - ALD(24), 0.5f)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        
        
        payRightNowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        payRightNowButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
        [payRightNowButton setTitle:@"付款" forState:UIControlStateNormal];
        [payRightNowButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        payRightNowButton.layer.cornerRadius = 4;
        payRightNowButton.layer.borderColor = WJColorMainColor.CGColor;
        payRightNowButton.layer.borderWidth = 0.5;
        payRightNowButton.titleLabel.font = WJFont14;
        payRightNowButton.hidden = YES;
        [payRightNowButton addTarget:self action:@selector(payRightNowButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        cancelOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelOrderButton.frame = CGRectMake((kScreenWidth - payRightNowButton.width * 2 - ALD(15)), CGRectGetMinY(payRightNowButton.frame), ALD(90), ALD(30));
        [cancelOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelOrderButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        cancelOrderButton.layer.cornerRadius = 4;
        cancelOrderButton.layer.borderColor = WJColorMainColor.CGColor;
        cancelOrderButton.layer.borderWidth = 0.5;
        cancelOrderButton.titleLabel.font = WJFont14;
        cancelOrderButton.hidden = YES;
        [cancelOrderButton addTarget:self action:@selector(cancelOrderButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        buyAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyAgainButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
        [buyAgainButton setTitle:@"再次购买" forState:UIControlStateNormal];
        [buyAgainButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        buyAgainButton.layer.cornerRadius = 4;
        buyAgainButton.layer.borderColor = WJColorMainColor.CGColor;
        buyAgainButton.layer.borderWidth = 0.5;
        buyAgainButton.titleLabel.font = WJFont14;
        buyAgainButton.hidden = YES;
        [buyAgainButton addTarget:self action:@selector(buyAgainButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        deleteOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteOrderButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
        [deleteOrderButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteOrderButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        deleteOrderButton.layer.cornerRadius = 4;
        deleteOrderButton.layer.borderColor = WJColorMainColor.CGColor;
        deleteOrderButton.layer.borderWidth = 0.5;
        deleteOrderButton.titleLabel.font = WJFont14;
        deleteOrderButton.hidden = YES;
        [deleteOrderButton addTarget:self action:@selector(deleteOrderButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView addSubview:orderTypeL];
        [self.contentView addSubview:statusL];
        [self.contentView addSubview:line];
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:chargeCreditsL];
        [self.contentView addSubview:middleLine];
        [self.contentView addSubview:totalMoneyL];
        [self.contentView addSubview:bottomLine];
        
        
        [self.contentView addSubview:payRightNowButton];
        [self.contentView addSubview:cancelOrderButton];
        [self.contentView addSubview:buyAgainButton];
        [self.contentView addSubview:deleteOrderButton];
        
    }
    return self;
}

-(void)configDataWithOrder:(WJOrderModel *)order
{
    orderTypeL.text = order.orderType;
    nameL.text = order.shopName;
    chargeCreditsL.text = [NSString stringWithFormat:@"充值积分:%@",order.chargeCredits];
    NSString *totalMoneyStr = [NSString stringWithFormat:@"多功能积分: %@",order.PayAmount];
    totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:6];
    
    
    switch (order.orderStatus) {
        case OrderStatusSuccess:
        {
            payRightNowButton.hidden = YES;
            cancelOrderButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            buyAgainButton.hidden = NO;
            statusL.text = @"完成";
        }
            break;
            
        case OrderStatusUnfinished:
        {
            deleteOrderButton.hidden = YES;
            buyAgainButton.hidden = YES;
            payRightNowButton.hidden = NO;
            cancelOrderButton.hidden = NO;
            statusL.text = @"未支付";
        }
            break;
            
        case OrderStatusClose:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            buyAgainButton.hidden = YES;
            deleteOrderButton.hidden = NO;
            statusL.text = @"取消订单";
            
        }
            break;
            
        default:
            break;
    }
    
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

#pragma mark - Action
-(void)payRightNowButtonAction
{
    
    self.payRightNowBlock();
}

-(void)cancelOrderButtonAction
{
    self.cancelOrderBlock();
}

-(void)deleteOrderButtonAction
{
    self.deleteOrderBlock();
}


-(void)buyAgainButtonAction
{
    self.buyAgainBlock();
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
