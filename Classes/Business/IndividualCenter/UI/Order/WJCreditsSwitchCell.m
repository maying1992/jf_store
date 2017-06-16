//
//  WJCreditsSwitchCell.m
//  jf_store
//
//  Created by reborn on 17/5/10.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCreditsSwitchCell.h"

@interface WJCreditsSwitchCell ()
{
    UILabel     *orderTypeL;
    UILabel     *statusL;
    
    UILabel     *nameL;
    UILabel     *chargeCreditsL;

}
@end

@implementation WJCreditsSwitchCell
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
        
        [self.contentView addSubview:orderTypeL];
        [self.contentView addSubview:statusL];
        [self.contentView addSubview:line];
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:chargeCreditsL];
        
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
            statusL.text = @"已完成";
        }
            break;
            
//        case OrderStatusWaitCheck:
//        {
//            statusL.text = @"待审核";
//        }
//            break;
//            
//        case OrderStatusCancelCheck:
//        {
//            statusL.text = @"取消审核";
//            
//        }
//            break;
            
        default:
            break;
    }
    
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
