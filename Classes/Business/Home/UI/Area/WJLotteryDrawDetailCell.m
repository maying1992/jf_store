//
//  WJLotteryDrawDetailCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/6/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawDetailCell.h"

@interface WJLotteryDrawDetailCell ()
{
    UILabel         * titleLabel;
    UILabel         * integralLabel;
    UILabel         * nowNumLabel;
    UILabel         * totalNumLabel;
    UILabel         * goodsNumLabel;
    UILabel         * cityLabel;
    
}

@end

@implementation WJLotteryDrawDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = WJFont15;
        titleLabel.textColor = WJColorMainTitle;
        titleLabel.text = @"茶水壶";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:10]];
        [self.contentView addConstraints:[titleLabel constraintsLeftInContainer:10]];
        
        integralLabel = [[UILabel alloc]initForAutoLayout];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"3599积分"];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont16,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,attrStr.length - 2)];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSForegroundColorAttributeName:WJColorMainTitle,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 2, 2)];
        integralLabel.attributedText = attrStr;
        [self.contentView addSubview:integralLabel];
        [self.contentView addConstraints:[integralLabel constraintsTop:10 FromView:titleLabel]];
        [self.contentView addConstraints:[integralLabel constraintsLeftInContainer:10]];
        
        UIView *line = [[UIView alloc]initForAutoLayout];
        line.backgroundColor = WJColorSeparatorLine;
        [self.contentView addSubview:line];
        [self.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 20, 0.5)]];
        [self.contentView addConstraints:[line constraintsLeftInContainer:10]];
        [self.contentView addConstraints:[line constraintsTop:10 FromView:integralLabel]];
        
        totalNumLabel = [[UILabel alloc]initForAutoLayout];
        totalNumLabel.font = WJFont14;
        totalNumLabel.textColor = WJColorDardGray6;
        totalNumLabel.text = @"总抽奖人数1000人";
        [self.contentView addSubview:totalNumLabel];
        [self.contentView addConstraints:[totalNumLabel constraintsTop:10 FromView:line]];
        [self.contentView addConstraints:[totalNumLabel constraintsLeftInContainer:10]];
        
        nowNumLabel = [[UILabel alloc]initForAutoLayout];
        nowNumLabel.font = WJFont14;
        nowNumLabel.textColor = WJColorDardGray6;
        nowNumLabel.text = @"已抽奖人数51人";
        [self.contentView addSubview:nowNumLabel];
        [self.contentView addConstraints:[nowNumLabel constraintsTop:10 FromView:titleLabel]];
        [self.contentView addConstraints:[nowNumLabel constraintsRightInContainer:10]];
        
        goodsNumLabel = [[UILabel alloc]initForAutoLayout];
        goodsNumLabel.font = WJFont14;
        goodsNumLabel.textColor = WJColorDardGray6;
        goodsNumLabel.text = @"货品货号：0002050";
        [self.contentView addSubview:goodsNumLabel];
        [self.contentView addConstraints:[goodsNumLabel constraintsTop:10 FromView:line]];
        [self.contentView addConstraints:[goodsNumLabel constraintsRightInContainer:10]];
    }
    return self;
}


-(void)configDataWithModel:(WJLotteryDrawDetailModel *)model
{
    NSString * integralStr = [NSString stringWithFormat:@"%@积分",model.integral];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:integralStr];
    [attrStr addAttributes:@{NSFontAttributeName:WJFont16,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,attrStr.length - 2)];
    [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSForegroundColorAttributeName:WJColorMainTitle,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 2, 2)];
    integralLabel.attributedText = attrStr;
//    numLabel.text = [NSString stringWithFormat:@"%@期",model.prizeNum];
    titleLabel.text = model.goodsName;
    nowNumLabel.text = [NSString stringWithFormat:@"以抽奖人数%@人",model.prizeCount];
    totalNumLabel.text = [NSString stringWithFormat:@"总抽奖人数%@人",model.prizeTimes];
    goodsNumLabel.text = [NSString stringWithFormat:@"货品货号：%@",model.goodsId];
}

@end
