//
//  WJTradingHallTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallTableViewCell.h"

@interface WJTradingHallTableViewCell()
{
    UILabel         * titleLabel;
    UILabel         * timeLabel;
    UILabel         * priceLabel;
    UILabel         * inputLabel;
}
@end


@implementation WJTradingHallTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = WJFont15;
        titleLabel.textColor = WJColorDardGray3;
        titleLabel.text = @"5000积分";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:14]];
        [self.contentView addConstraints:[titleLabel constraintsLeftInContainer:15]];
        
        timeLabel = [[UILabel alloc]initForAutoLayout];
        timeLabel.font = WJFont12;
        timeLabel.textColor = WJColorDardGray9;
        timeLabel.text = @"2017-03-25";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTop:7 FromView:titleLabel]];
        [self.contentView addConstraints:[timeLabel constraintsLeftInContainer:15]];
        
        priceLabel = [[UILabel alloc]initForAutoLayout];
        priceLabel.font = WJFont15;
        priceLabel.textColor = WJColorDardGray3;
        priceLabel.text = @"+1000多功能积分";
        [self.contentView addSubview:priceLabel];
        [self.contentView addConstraints:[priceLabel constraintsTopInContainer:13]];
        [self.contentView addConstraints:[priceLabel constraintsRightInContainer:15]];
        
        inputLabel = [[UILabel alloc]initForAutoLayout];
        inputLabel.font = WJFont12;
        inputLabel.textColor = WJColorDardGray9;
        inputLabel.text = @"买入";
        [self.contentView addSubview:inputLabel];
        [self.contentView addConstraints:[inputLabel constraintsTop:7 FromView:priceLabel]];
        [self.contentView addConstraints:[inputLabel constraintsRightInContainer:15]];
        
        UIView * bottomLine = [[UIView alloc]initForAutoLayout];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:bottomLine];
        [self addConstraints:[bottomLine constraintsSize:CGSizeMake(kScreenWidth - 30, 0.5)]];
        [self addConstraints:[bottomLine constraintsBottomInContainer:0]];
        [self addConstraints:[bottomLine constraintsRightInContainer:15]];

    }
    return self;
}

@end
