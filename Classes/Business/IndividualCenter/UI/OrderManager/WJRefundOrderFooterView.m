//
//  WJRefundOrderFooterView.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRefundOrderFooterView.h"


@interface WJRefundOrderFooterView ()
{
    UILabel     *refundReasonL;
    UILabel     *totalMoneyL;
    UILabel     *freightL;
    UILabel     *addressL;
    UIButton    *confirmRefundButton;    //确认退款
}
@end


@implementation WJRefundOrderFooterView

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
    
    refundReasonL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, kScreenWidth - ALD(24), ALD(44))];
    refundReasonL.textAlignment = NSTextAlignmentLeft;
    refundReasonL.textColor = WJColorDarkGray;
    refundReasonL.font = WJFont12;
    
    UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), refundReasonL.bottom, kScreenWidth - ALD(24), 0.5f)];
    line.backgroundColor = WJColorSeparatorLine;
    
    totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom, kScreenWidth - ALD(12), ALD(30))];
    totalMoneyL.textAlignment = NSTextAlignmentRight;
    totalMoneyL.textColor = WJColorDarkGray;
    totalMoneyL.font = WJFont12;
    
    
    freightL = [[UILabel alloc] initWithFrame:CGRectMake(0, totalMoneyL.bottom, kScreenWidth - ALD(12), ALD(30))];
    freightL.textAlignment = NSTextAlignmentRight;
    freightL.textColor = WJColorDardGray9;
    freightL.font = WJFont12;
    
    UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), freightL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    
    
    addressL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), bottomLine.bottom, kScreenWidth - ALD(24), ALD(44))];
    addressL.numberOfLines = 0;
    addressL.textColor = WJColorDardGray9;
    addressL.font = WJFont12;
    
    confirmRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmRefundButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
    [confirmRefundButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [confirmRefundButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    confirmRefundButton.layer.cornerRadius = 4;
    confirmRefundButton.layer.borderColor = WJColorMainColor.CGColor;
    confirmRefundButton.layer.borderWidth = 0.5;
    confirmRefundButton.titleLabel.font = WJFont14;
    confirmRefundButton.hidden = YES;
    [confirmRefundButton addTarget:self action:@selector(confirmRefundButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, ALD(164) - ALD(10), kScreenWidth, ALD(10))];
    spaceView.backgroundColor = WJColorViewBg;
    
    [self.contentView addSubview:refundReasonL];
    [self.contentView addSubview:line];
    [self.contentView addSubview:totalMoneyL];
    [self.contentView addSubview:freightL];
    [self.contentView addSubview:bottomLine];
    
    [self.contentView addSubview:addressL];
    [self.contentView addSubview:spaceView];
}


-(void)configDataWithOrder:(WJOrderModel *)order
{
    NSString *totalMoneyStr = [NSString stringWithFormat:@"合计: %@",order.PayAmount];
    totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:3];
    
    NSString *freightStr = [NSString stringWithFormat:@"运费: %@",order.freight];
    freightL.attributedText= [self attributedText:freightStr firstLength:3];
    
//    addressL.text = [NSString stringWithFormat:@"地址:%@",order.address];
    
    
    NSString *refundTimeStr = [NSString stringWithFormat:@"(%@)",order.remainingRefundTime];
    NSString *reasonStr = [NSString stringWithFormat:@"退款原因:%@%@",order.refundReason,refundTimeStr];
    refundReasonL.attributedText = [self attributedText:reasonStr refundReasonFirstLength:order.refundReason.length + 5];
    
    
    switch (order.orderStatus) {
        case OrderStatusSuccess:
        {
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusUnfinished:
        {
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusClose:
        {
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusWaitDeliver:
        {
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusWaitReceive:
        {
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusRefunding:
        {
            confirmRefundButton.hidden = NO;
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

- (NSAttributedString *)attributedText:(NSString *)text refundReasonFirstLength:(NSInteger)len{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont12,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont12,
                                              NSForegroundColorAttributeName : WJColorDardGray9,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:result];
}



#pragma mark - Action
-(void)confirmRefundButtonAction
{
    self.confirmRefundBlock();
}


@end
