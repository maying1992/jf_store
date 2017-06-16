//
//  WJGivingOrderCell.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingOrderCell.h"

@interface WJGivingOrderCell ()
{
    UILabel     *orderTypeL;
    UILabel     *statusL;
    
    UILabel     *nameL;
    UILabel     *chargeCreditsL;
    
    UILabel     *shareCreditsL;
    
    UIButton    *cancelCheckButton;     //取消审核
    UIButton    *deleteOrderButton;     //删除
}

@end

@implementation WJGivingOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = WJColorWhite;
        
        orderTypeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(100), ALD(22))];
        orderTypeL.textAlignment = NSTextAlignmentLeft;
        orderTypeL.textColor = WJColorDarkGray;
        orderTypeL.font = WJFont12;
        
        statusL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), 0, ALD(100), ALD(22))];
        statusL.textAlignment = NSTextAlignmentRight;
        statusL.textColor = WJColorDarkGray;
        statusL.font = WJFont12;
        
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), orderTypeL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
        line.backgroundColor = WJColorSeparatorLine;
        
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), line.bottom + ALD(5),kScreenWidth - ALD(24), ALD(22))];
        nameL.textAlignment = NSTextAlignmentLeft;
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont15;
        
        chargeCreditsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), nameL.bottom,kScreenWidth - ALD(24), ALD(22))];
        chargeCreditsL.textAlignment = NSTextAlignmentLeft;
        chargeCreditsL.textColor = WJColorDardGray9;
        chargeCreditsL.font = WJFont12;
        
//        UIView *middleLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), line.bottom + ALD(66), kScreenWidth - ALD(24), 0.5f)];
//        middleLine.backgroundColor = WJColorSeparatorLine;
        
        
        shareCreditsL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), chargeCreditsL.origin.y, ALD(150), ALD(44))];
        shareCreditsL.textAlignment = NSTextAlignmentRight;
        shareCreditsL.textColor = WJColorDardGray3;
        shareCreditsL.font = WJFont12;
//        shareCreditsL.hidden = YES;
        
        
        UIView *bottomLine =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), chargeCreditsL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5f)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        
        
        
        cancelCheckButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelCheckButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), bottomLine.bottom + ALD(10), ALD(90), ALD(30));
        [cancelCheckButton setTitle:@"取消审核" forState:UIControlStateNormal];
        [cancelCheckButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        cancelCheckButton.layer.cornerRadius = 4;
        cancelCheckButton.layer.borderColor = WJColorMainColor.CGColor;
        cancelCheckButton.layer.borderWidth = 0.5;
        cancelCheckButton.titleLabel.font = WJFont14;
        cancelCheckButton.hidden = YES;
        [cancelCheckButton addTarget:self action:@selector(cancelCheckButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
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
        [self.contentView addSubview:shareCreditsL];
        [self.contentView addSubview:bottomLine];
        [self.contentView addSubview:cancelCheckButton];
        [self.contentView addSubview:deleteOrderButton];
        
    }
    return self;
}


-(void)configDataWithOrder:(WJOrderModel *)order
{
    orderTypeL.text = order.orderType;
    nameL.text = order.shopName;
    chargeCreditsL.text = [NSString stringWithFormat:@"可用积分:%@",order.chargeCredits];
    
    
    switch (order.orderStatus) {
        case OrderStatusSuccess:
        {
            cancelCheckButton.hidden = YES;
            deleteOrderButton.hidden = YES;
            statusL.text = @"完成";
        }
            break;
            
        case OrderStatusWaitCheck:
        {
            deleteOrderButton.hidden = YES;
            cancelCheckButton.hidden = NO;
            statusL.text = @"待审核";
        }
            break;
            
        case OrderStatusCancelCheck:
        {
            cancelCheckButton.hidden = YES;
            deleteOrderButton.hidden = NO;
            statusL.text = @"取消审核";
            
        }
            break;
            
        default:
            break;
    }
    
}
//- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len{
//    
//    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
//                                         initWithString:text];
//    NSDictionary *attributesForFirstWord = @{
//                                             NSFontAttributeName : WJFont12,
//                                             NSForegroundColorAttributeName : WJColorDarkGray,
//                                             };
//    
//    NSDictionary *attributesForSecondWord = @{
//                                              NSFontAttributeName : WJFont12,
//                                              NSForegroundColorAttributeName : WJColorSubColor,
//                                              };
//    [result setAttributes:attributesForFirstWord
//                    range:NSMakeRange(0, len)];
//    [result setAttributes:attributesForSecondWord
//                    range:NSMakeRange(len, text.length - len)];
//    
//    
//    return [[NSAttributedString alloc] initWithAttributedString:result];
//}

#pragma mark - Action


-(void)cancelCheckButtonAction
{
    self.cancelCheckBlock();
}

-(void)deleteOrderButtonAction
{
    self.deleteOrderBlock();
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
