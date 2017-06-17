//
//  WJPurchaseFooterView.m
//  jf_store
//
//  Created by reborn on 17/5/9.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPurchaseFooterView.h"
#import "WJOrderModel.h"
@interface WJPurchaseFooterView ()
{
    UILabel     *totalMoneyL;
    UILabel     *freightL;
    
    UIView      *bottomLine;
    
    UIButton    *payRightNowButton;     //付款
    UIButton    *cancelOrderButton;     //取消订单
    UIButton    *deleteOrderButton;     //删除订单
    UIButton    *refundButton;          //退款
    UIButton    *checkLogisticseButton; //查看物流
    UIButton    *finishOrderButton;     //完成订单
    UIButton    *buyAgainButton;        //再次购买
    UIButton    *refundDetailButton;    //退款详情
    UIButton    *cancelRefundButton;     //取消退款
}

@end

@implementation WJPurchaseFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    
    return self;
}


-(void)initView
{
    
    self.contentView.backgroundColor = WJColorWhite;
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), 0, kScreenWidth - ALD(24), 0.5f)];
    line.backgroundColor = WJColorSeparatorLine;
    
    totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom, kScreenWidth - ALD(12), ALD(30))];
    totalMoneyL.textAlignment = NSTextAlignmentRight;
    totalMoneyL.textColor = WJColorDarkGray;
    totalMoneyL.font = WJFont12;
    
    
    freightL = [[UILabel alloc] initWithFrame:CGRectMake(0, totalMoneyL.bottom, kScreenWidth - ALD(12), ALD(30))];
    freightL.textAlignment = NSTextAlignmentRight;
    freightL.textColor = WJColorDardGray9;
    freightL.font = WJFont12;
    
    bottomLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), freightL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
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
    
    finishOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishOrderButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
    [finishOrderButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishOrderButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    finishOrderButton.layer.cornerRadius = 4;
    finishOrderButton.layer.borderColor = WJColorMainColor.CGColor;
    finishOrderButton.layer.borderWidth = 0.5;
    finishOrderButton.titleLabel.font = WJFont14;
    finishOrderButton.hidden = YES;
    [finishOrderButton addTarget:self action:@selector(finishOrderButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    checkLogisticseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    checkLogisticseButton.frame = CGRectMake((kScreenWidth - finishOrderButton.width * 2 - ALD(15)), CGRectGetMinY(finishOrderButton.frame), ALD(90), ALD(30));
    [checkLogisticseButton setTitle:@"查看物流" forState:UIControlStateNormal];
    [checkLogisticseButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    checkLogisticseButton.layer.cornerRadius = 4;
    checkLogisticseButton.layer.borderColor = WJColorMainColor.CGColor;
    checkLogisticseButton.layer.borderWidth = 0.5;
    checkLogisticseButton.titleLabel.font = WJFont14;
    checkLogisticseButton.hidden = YES;
    [checkLogisticseButton addTarget:self action:@selector(checkLogisticseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    
    refundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refundButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
    [refundButton setTitle:@"退款" forState:UIControlStateNormal];
    [refundButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    refundButton.layer.cornerRadius = 4;
    refundButton.layer.borderColor = WJColorMainColor.CGColor;
    refundButton.layer.borderWidth = 0.5;
    refundButton.titleLabel.font = WJFont14;
    refundButton.hidden = YES;
    [refundButton addTarget:self action:@selector(refundButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    cancelRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelRefundButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
    [cancelRefundButton setTitle:@"取消退款" forState:UIControlStateNormal];
    [cancelRefundButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    cancelRefundButton.layer.cornerRadius = 4;
    cancelRefundButton.layer.borderColor = WJColorMainColor.CGColor;
    cancelRefundButton.layer.borderWidth = 0.5;
    cancelRefundButton.titleLabel.font = WJFont14;
    cancelRefundButton.hidden = YES;
    [cancelRefundButton addTarget:self action:@selector(cancelRefundButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    refundDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refundDetailButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
    [refundDetailButton setTitle:@"退款详情" forState:UIControlStateNormal];
    [refundDetailButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    refundDetailButton.layer.cornerRadius = 4;
    refundDetailButton.layer.borderColor = WJColorMainColor.CGColor;
    refundDetailButton.layer.borderWidth = 0.5;
    refundDetailButton.titleLabel.font = WJFont14;
    refundDetailButton.hidden = YES;
    [refundDetailButton addTarget:self action:@selector(refundDetailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
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

    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, ALD(130) - ALD(10), kScreenWidth, ALD(10))];
    spaceView.backgroundColor = WJColorViewBg;
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:totalMoneyL];
    [self.contentView addSubview:freightL];
    [self.contentView addSubview:bottomLine];
    
    
    [self.contentView addSubview:payRightNowButton];
    [self.contentView addSubview:cancelOrderButton];
    [self.contentView addSubview:finishOrderButton];
    [self.contentView addSubview:checkLogisticseButton];
    [self.contentView addSubview:buyAgainButton];
    [self.contentView addSubview:refundButton];
    [self.contentView addSubview:deleteOrderButton];
    [self.contentView addSubview:refundDetailButton];
    [self.contentView addSubview:cancelRefundButton];
    [self.contentView addSubview:spaceView];
}


-(void)configDataWithOrder:(WJOrderModel *)order
{
    NSString * totalMoneyStr = @"商品小计：";
    if (![order.PayAmount isEqualToString:@"0"]) {
        totalMoneyStr = [totalMoneyStr stringByAppendingFormat:@"%@元",order.PayAmount];
    }
    if (![order.payIntegral isEqualToString:@"0"]) {
        if ([totalMoneyStr isEqualToString:@"商品小计："]) {
            totalMoneyStr = [totalMoneyStr stringByAppendingFormat:@"%@积分",order.payIntegral];
        }else{
            totalMoneyStr = [totalMoneyStr stringByAppendingFormat:@"+%@积分",order.payIntegral];
        }
    }
    totalMoneyL.text = totalMoneyStr;
//    NSString *totalMoneyStr = [NSString stringWithFormat:@"商品小计: %@",order.PayAmount];
//    totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:5];
    
    
    NSString * freightStr = @"运费：";
    if (![order.freight isEqualToString:@"0"]) {
        freightStr = [freightStr stringByAppendingFormat:@"%@元",order.freight];
    }
    if (![order.freightIntegral isEqualToString:@"0"]) {
        if ([freightStr isEqualToString:@"运费："]) {
            freightStr = [freightStr stringByAppendingFormat:@"%@积分",order.freightIntegral];
        }else{
            freightStr = [freightStr stringByAppendingFormat:@"+%@积分",order.freightIntegral];
        }
    }
    freightL.text = freightStr;
//    NSString *freightStr = [NSString stringWithFormat:@"运费: %@",order.freight];
//    freightL.attributedText= [self attributedText:freightStr firstLength:3];
    
    switch (order.orderStatus) {
        case OrderStatusSuccess:
        {
            payRightNowButton.hidden = YES;
            cancelOrderButton.hidden = YES;
            refundButton.hidden = YES;
            refundDetailButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            checkLogisticseButton.hidden = NO;
            buyAgainButton.hidden = NO;
        }
            break;
            
        case OrderStatusUnfinished:
        {
            refundButton.hidden = YES;
            refundDetailButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            buyAgainButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            payRightNowButton.hidden = NO;
            cancelOrderButton.hidden = NO;
        }
            break;
            
        case OrderStatusClose:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            refundButton.hidden = YES;
            refundDetailButton.hidden = YES;
            buyAgainButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            finishOrderButton.hidden = YES;
            deleteOrderButton.hidden = NO;
        }
            break;
            
        case OrderStatusWaitDeliver:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            refundDetailButton.hidden = YES;
            buyAgainButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            refundButton.hidden = NO;
        }
            break;
            
        case OrderStatusWaitReceive:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            refundButton.hidden = YES;
            refundDetailButton.hidden = YES;
            buyAgainButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            checkLogisticseButton.hidden = NO;
            finishOrderButton.hidden = NO;
        }
            break;
            
        case OrderStatusApplyRefund:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            buyAgainButton.hidden = YES;
            refundButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = NO;
            refundDetailButton.hidden = NO;
            
            cancelRefundButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
           
            refundDetailButton.frame =  CGRectMake((kScreenWidth - cancelRefundButton.width * 2 - ALD(15)), CGRectGetMinY(cancelRefundButton.frame), ALD(90), ALD(30));

            
        }
            break;
            
        case OrderStatusRefunding:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            buyAgainButton.hidden = YES;
            refundButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            refundDetailButton.hidden = NO;
            
        }
            break;
            
        case OrderStatusAlreadyRefund:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            buyAgainButton.hidden = YES;
            refundButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            refundDetailButton.hidden = NO;
            
        }
            
        case OrderStatusRefuseRefund:
        {
            cancelOrderButton.hidden = YES;
            payRightNowButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            checkLogisticseButton.hidden = YES;
            buyAgainButton.hidden = YES;
            refundButton.hidden = YES;
            finishOrderButton.hidden = YES;
            cancelRefundButton.hidden = YES;
            refundDetailButton.hidden = NO;
            
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

-(void)refundButtonAction
{
    self.refundBlock();
}


-(void)finishOrderButtonAction
{
    self.finishBlock();
}


-(void)checkLogisticseButtonAction
{
    self.checkLogisticseBlock();
}

-(void)buyAgainButtonAction
{
    self.buyAgainBlock();
}

-(void)refundDetailButtonAction
{
    self.refundDetailBlock();
}

-(void)cancelRefundButtonAction
{
    self.cancelRefundBlock();
}

@end
