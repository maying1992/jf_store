//
//  WJLotteryQueryCell.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryQueryCell.h"

@interface WJLotteryQueryCell ()
{
    UILabel         * numLabel;
    UILabel         * timeLabel;
    UILabel         * integralLabel;
    UILabel         * lotteryStatusLabel;

}

@end

@implementation WJLotteryQueryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        numLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(50), ALD(44))];
        numLabel.font = WJFont14;
        numLabel.textColor = WJColorDardGray3;
        numLabel.text = @"1期";
        [self.contentView addSubview:numLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(numLabel.right, 0, ALD(150), ALD(44))];
        timeLabel.font = WJFont14;
        timeLabel.textColor = WJColorDardGray3;
        timeLabel.text = @"2017-04-24 16:30";
        [self.contentView addSubview:timeLabel];
        
        integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.right, 0, ALD(100), ALD(44))];
        integralLabel.font = WJFont14;
        integralLabel.textColor = WJColorDardGray3;
        integralLabel.text = @"-5000积分";
        integralLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:integralLabel];
        
        lotteryStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(60), 0, ALD(60), ALD(44))];
        lotteryStatusLabel.font = WJFont14;
        lotteryStatusLabel.textColor = WJColorDardGray3;
        lotteryStatusLabel.text = @"待开奖";
        lotteryStatusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:lotteryStatusLabel];
        
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
