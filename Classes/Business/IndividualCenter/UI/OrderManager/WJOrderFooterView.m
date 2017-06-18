//
//  WJOrderFooterView.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderFooterView.h"
#import "WJOrderModel.h"
@interface WJOrderFooterView ()
{
    UILabel     *totalMoneyL;
    UILabel     *freightL;
    UILabel     *addressL;

    UIButton    *deliverGoodsButton;     //发货
    UIButton    *confirmRefundButton;    //确认退款
}

@end

@implementation WJOrderFooterView

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
    
    UIView *middleLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), freightL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
    middleLine.backgroundColor = WJColorSeparatorLine;
    
    
    deliverGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deliverGoodsButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), middleLine.bottom + ALD(10), ALD(90), ALD(30));
    [deliverGoodsButton setTitle:@"发货" forState:UIControlStateNormal];
    [deliverGoodsButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    deliverGoodsButton.layer.cornerRadius = 4;
    deliverGoodsButton.layer.borderColor = WJColorMainColor.CGColor;
    deliverGoodsButton.layer.borderWidth = 0.5;
    deliverGoodsButton.titleLabel.font = WJFont14;
    deliverGoodsButton.hidden = YES;
    [deliverGoodsButton addTarget:self action:@selector(deliverGoodsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    confirmRefundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmRefundButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), middleLine.bottom + ALD(10), ALD(90), ALD(30));
    [confirmRefundButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [confirmRefundButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
    confirmRefundButton.layer.cornerRadius = 4;
    confirmRefundButton.layer.borderColor = WJColorMainColor.CGColor;
    confirmRefundButton.layer.borderWidth = 0.5;
    confirmRefundButton.titleLabel.font = WJFont14;
    confirmRefundButton.hidden = YES;
    [confirmRefundButton addTarget:self action:@selector(confirmRefundButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), middleLine.bottom + ALD(44), kScreenWidth - ALD(24), 0.5f)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    
    
    addressL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), bottomLine.bottom, kScreenWidth - ALD(24), ALD(44))];
    addressL.numberOfLines = 0;
    addressL.textColor = WJColorDardGray9;
    addressL.font = WJFont12;
    

    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, ALD(164) - ALD(10), kScreenWidth, ALD(10))];
    spaceView.backgroundColor = WJColorViewBg;
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:totalMoneyL];
    [self.contentView addSubview:freightL];
    [self.contentView addSubview:middleLine];
    [self.contentView addSubview:bottomLine];
    
    
    [self.contentView addSubview:deliverGoodsButton];
    [self.contentView addSubview:confirmRefundButton];
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
    
    switch (order.orderStatus) {
        case OrderStatusSuccess:
        {
            deliverGoodsButton.hidden = YES;
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusUnfinished:
        {
            deliverGoodsButton.hidden = YES;
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusClose:
        {
            deliverGoodsButton.hidden = YES;
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusWaitDeliver:
        {
            deliverGoodsButton.hidden = NO;
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusWaitReceive:
        {
            deliverGoodsButton.hidden = YES;
            confirmRefundButton.hidden = YES;
        }
            break;
            
        case OrderStatusRefunding:
        {
            deliverGoodsButton.hidden = YES;
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

#pragma mark - Action
-(void)deliverGoodsButtonAction
{
    
    self.deliverGoodsBlock();
}

-(void)confirmRefundButtonAction
{
    self.confirmRefundBlock();
}

@end
