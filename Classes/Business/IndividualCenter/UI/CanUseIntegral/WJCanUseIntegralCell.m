//
//  WJCanUseIntegralCell.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCanUseIntegralCell.h"

@interface WJCanUseIntegralCell ()
{
    UILabel *orderNoL;
    UILabel *nameL;
    UILabel *integralL;
    UILabel *timeL;
}

@end

@implementation WJCanUseIntegralCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(5), ALD(200), ALD(22))];
        orderNoL.textColor = WJColorDardGray3;
        orderNoL.text = @"订单编号：93242424234234234";
        orderNoL.font = WJFont12;
        
        integralL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), ALD(5), ALD(200), ALD(22))];
        integralL.textColor = WJColorDardGray3;
        integralL.font = WJFont15;
        integralL.textAlignment = NSTextAlignmentRight;
        integralL.text = @"-3545积分";

        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(orderNoL.frame.origin.x, orderNoL.bottom + ALD(6), ALD(150), ALD(22))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont15;
        nameL.text = @"会员充值";
        
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), integralL.bottom + ALD(6), ALD(100), ALD(22))];
        timeL.textColor = WJColorDardGray9;
        timeL.font = WJFont15;
        timeL.text = @"2017-03-25";
        timeL.textAlignment = NSTextAlignmentRight;

        
        [self.contentView addSubview:orderNoL];
        [self.contentView addSubview:integralL];
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:timeL];
    }
    return self;
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
