//
//  WJWinnerListTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJWinnerListTableViewCell.h"

@interface WJWinnerListTableViewCell()
{
    UILabel         * numLabel;
    UILabel         * userLabel;
    UILabel         * goodsLabel;
}

@end


@implementation WJWinnerListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        numLabel = [[UILabel alloc]initForAutoLayout];
        numLabel.font = WJFont14;
        numLabel.textColor = WJColorDardGray3;
        numLabel.text = @"期数";
        [self.contentView addSubview:numLabel];
        [self.contentView addConstraint:[numLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[numLabel constraintsLeftInContainer:12]];
        
        userLabel = [[UILabel alloc]initForAutoLayout];
        userLabel.font = WJFont14;
        userLabel.textColor = WJColorDardGray3;
        userLabel.text = @"用户编号";
        [self.contentView addSubview:userLabel];
        [self.contentView addConstraint:[userLabel constraintCenterYInContainer]];
        [self.contentView addConstraint:[userLabel constraintCenterXInContainer]];
        
        goodsLabel = [[UILabel alloc]initForAutoLayout];
        goodsLabel.font = WJFont14;
        goodsLabel.textColor = WJColorDardGray3;
        goodsLabel.text = @"奖品";
        [self.contentView addSubview:goodsLabel];
        [self.contentView addConstraint:[goodsLabel constraintCenterYInContainer]];
        [self.contentView addConstraints:[goodsLabel constraintsRightInContainer:12]];
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(12, self.height, kScreenWidth - 24, 0.5)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        [self.contentView addSubview:bottomLine];
        
    }
    return self;
}

-(void)configDataWithModel:(WJPrizeResultListModel *)model
{
    numLabel.text = model.prizeNum;
    userLabel.text = model.userName;
    goodsLabel.text = model.goodsName;
}

@end
