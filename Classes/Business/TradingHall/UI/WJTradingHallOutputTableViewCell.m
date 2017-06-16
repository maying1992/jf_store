//
//  WJTradingHallOutputTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/22.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJTradingHallOutputTableViewCell.h"

@interface WJTradingHallOutputTableViewCell()
{
    UILabel         * titleLabel;
    UILabel         * timeLabel;
    UILabel         * priceLabel;
//    UILabel         * inputLabel;
}
@end

@implementation WJTradingHallOutputTableViewCell

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
        timeLabel.text = @"2017-03-25 16:30";
        [self.contentView addSubview:timeLabel];
        [self.contentView addConstraints:[timeLabel constraintsTop:7 FromView:titleLabel]];
        [self.contentView addConstraints:[timeLabel constraintsLeftInContainer:15]];
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 35/2;
        _cancelButton.layer.borderWidth = 1;
        [_cancelButton setBackgroundColor:WJColorWhite];
        [self.contentView addSubview:_cancelButton];
        [self.contentView addConstraints:[_cancelButton constraintsSize:CGSizeMake(90, 35)]];
        [self.contentView addConstraint:[_cancelButton constraintCenterYInContainer]];
        [self.contentView addConstraints:[_cancelButton constraintsRightInContainer:12]];

        UIView * verticalLine = [[UIView alloc]initForAutoLayout];
        verticalLine.backgroundColor = WJColorSeparatorLine;
        [self.contentView addSubview:verticalLine];
        [self.contentView addConstraints:[verticalLine constraintsSize:CGSizeMake(1, 44)]];
        [self.contentView addConstraints:[verticalLine constraintsBottomInContainer:(60-44)/2]];
        [self.contentView addConstraints:[verticalLine constraintsRight:15 FromView:_cancelButton]];
        
        priceLabel = [[UILabel alloc]initForAutoLayout];
        priceLabel.font = WJFont15;
        priceLabel.textColor = WJColorDardGray3;
        priceLabel.text = @"+1000多功能积分";
        [self.contentView addSubview:priceLabel];
        [self.contentView addConstraint:[priceLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[priceLabel constraintsRight:15 FromView:verticalLine]];
        
        UIView * horizontalLine = [[UIView alloc]initForAutoLayout];
        horizontalLine.backgroundColor = WJColorSeparatorLine;
        [self.contentView addSubview:horizontalLine];
        [self.contentView addConstraints:[horizontalLine constraintsSize:CGSizeMake(kScreenWidth - 30, 0.5)]];
        [self.contentView addConstraints:[horizontalLine constraintsBottomInContainer:0]];
        [self.contentView addConstraints:[horizontalLine constraintsLeftInContainer:15]];
    }
    return self;
}

@end
