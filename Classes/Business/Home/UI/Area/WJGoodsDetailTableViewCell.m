//
//  WJGoodsDetailTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/26.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsDetailTableViewCell.h"

@interface WJGoodsDetailTableViewCell ()
{
    UILabel         * titleLabel;
    UILabel         * subLabel;
    UILabel         * integralLabel;
    UILabel         * postageLabel;
    UILabel         * salesLabel;
    UILabel         * cityLabel;

}

@end

@implementation WJGoodsDetailTableViewCell

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

        subLabel = [[UILabel alloc]initForAutoLayout];
        subLabel.font = WJFont13;
        subLabel.textColor = WJColorDardGray6;
        subLabel.text = @"圣.帕特里克节创立于5世纪，是爱尔兰纪念守护神圣.帕特里克节创立于5世纪，是爱尔兰纪念守护神圣.帕特里克节创立于5世纪，是爱尔兰纪念守护神";
        subLabel.numberOfLines = 2;
        [self.contentView addSubview:subLabel];
        [self.contentView addConstraint:[subLabel constraintWidth:kScreenWidth - 20]];
        [self.contentView addConstraints:[subLabel constraintsTop:8 FromView:titleLabel]];
        [self.contentView addConstraints:[subLabel constraintsLeftInContainer:10]];
        
        integralLabel = [[UILabel alloc]initForAutoLayout];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"3599积分"];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont16,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,attrStr.length - 2)];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont11,NSForegroundColorAttributeName:WJColorMainTitle,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 2, 2)];
        integralLabel.attributedText = attrStr;
        [self.contentView addSubview:integralLabel];
        [self.contentView addConstraints:[integralLabel constraintsTop:8 FromView:subLabel]];
        [self.contentView addConstraints:[integralLabel constraintsLeftInContainer:10]];
        
        postageLabel = [[UILabel alloc]initForAutoLayout];
        postageLabel.font = WJFont11;
        postageLabel.textColor = WJColorDardGray6;
        postageLabel.text = @"邮费：18";
        [self.contentView addSubview:postageLabel];
        [self.contentView addConstraints:[postageLabel constraintsTop:8 FromView:integralLabel]];
        [self.contentView addConstraints:[postageLabel constraintsLeftInContainer:10]];
        
        salesLabel = [[UILabel alloc]initForAutoLayout];
        salesLabel.font = WJFont11;
        salesLabel.textColor = WJColorDardGray6;
        salesLabel.text = @"销量：1384";
        [self.contentView addSubview:salesLabel];
        [self.contentView addConstraints:[salesLabel constraintsTop:8 FromView:integralLabel]];
        [self.contentView addConstraint:[salesLabel constraintCenterXInContainer]];
        
        cityLabel = [[UILabel alloc]initForAutoLayout];
        cityLabel.font = WJFont11;
        cityLabel.textColor = WJColorDardGray6;
        cityLabel.text = @"北京";
        [self.contentView addSubview:cityLabel];
        [self.contentView addConstraints:[cityLabel constraintsTop:8 FromView:integralLabel]];
        [self.contentView addConstraints:[cityLabel constraintsRightInContainer:10]];
    }
    return self;
}

@end
