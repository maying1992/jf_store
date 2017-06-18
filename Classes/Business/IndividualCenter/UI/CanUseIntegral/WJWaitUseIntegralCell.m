//
//  WJWaitUseIntegralCell.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJWaitUseIntegralCell.h"

@interface WJWaitUseIntegralCell ()
{
    UILabel     *orderNoL;
    UIView      *line;
    UILabel     *integralTypeL;
    UIImageView *leftIV;
    UIView      *progressLine;
    UIImageView *rightIV;
    UILabel     *nameL;
    UILabel     *returnIntegralL;
    UILabel     *startTimeL;
    UILabel     *endTimeL;

}

@end

@implementation WJWaitUseIntegralCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(5), ALD(200), ALD(44))];
        orderNoL.textColor = WJColorDardGray3;
        orderNoL.text = @"订单编号：93242424234234234";
        orderNoL.font = WJFont12;
        
        
        integralTypeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), orderNoL.origin.y, ALD(150), ALD(44))];
        integralTypeL.textColor = WJColorDardGray3;
        integralTypeL.text = @"消费返还：3421积分";
        integralTypeL.font = WJFont12;
        integralTypeL.textAlignment = NSTextAlignmentRight;
        
        line = [[UIView alloc] initWithFrame:CGRectMake(ALD(12), orderNoL.bottom, kScreenWidth - ALD(24), 0.5)];
        line.backgroundColor = WJColorSeparatorLine;
        
        leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(32), line.bottom + ALD(15), ALD(16), ALD(16))];
        leftIV.image = [UIImage imageNamed:@"shoppingCart_nor"];
        
        progressLine = [[UIView alloc] initWithFrame:CGRectMake(leftIV.right, leftIV.origin.y + ALD(8), kScreenWidth - ALD(64) - ALD(32), 2)];
        progressLine.backgroundColor = WJColorMainColor;
        
        rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(32) - leftIV.width, leftIV.origin.y, ALD(16), ALD(16))];
        rightIV.image = [UIImage imageNamed:@"shoppingCart_sel"];

        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(20), leftIV.bottom + ALD(8), ALD(100), ALD(22))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont14;
        nameL.text = @"确认订单";
        
    
        returnIntegralL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), nameL.origin.y, ALD(100), ALD(22))];
        returnIntegralL.textColor = WJColorDardGray3;
        returnIntegralL.font = WJFont14;
        returnIntegralL.text = @"返还积分";
        returnIntegralL.textAlignment = NSTextAlignmentRight;
        
        
        startTimeL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.origin.x, nameL.bottom + ALD(5), ALD(100), ALD(22))];
        startTimeL.textColor = WJColorDardGray3;
        startTimeL.font = WJFont14;
        startTimeL.text = @"2017-03-25";
        
        endTimeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(100), startTimeL.origin.y, ALD(100), ALD(22))];
        endTimeL.textColor = WJColorDardGray3;
        endTimeL.font = WJFont14;
        endTimeL.text = @"2017-05-25";
        
        
        [self.contentView addSubview:orderNoL];
        [self.contentView addSubview:integralTypeL];
        [self.contentView addSubview:line];
        [self.contentView addSubview:leftIV];
        [self.contentView addSubview:rightIV];
        [self.contentView addSubview:progressLine];
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:returnIntegralL];
        [self.contentView addSubview:startTimeL];
        [self.contentView addSubview:endTimeL];

    }
    return self;
}

-(void)configDataWithModel:(WJIntegralModel *)model
{
    orderNoL.text = [NSString stringWithFormat:@"订单编号：%@",model.integralNo];
    integralTypeL.text = [NSString stringWithFormat:@"%@: %@积分",model.tradeType,model.total];
    startTimeL.text = model.tradeTime;
    endTimeL.text = model.returnTime;
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
