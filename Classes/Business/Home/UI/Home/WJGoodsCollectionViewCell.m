//
//  WJGoodsCollectionViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodsCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface WJGoodsCollectionViewCell()
{
    UIImageView *imageView;
    UILabel     *titleLabel;
    UILabel     *integralLabel;
}

@end


@implementation WJGoodsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = WJColorWhite;
        
        imageView = [[UIImageView alloc]initForAutoLayout];
        imageView.image = [WJUtilityMethod createImageWithColor:WJRandomColor];
        [self.contentView addSubview:imageView];
        [self.contentView addConstraints:[imageView constraintsSize:CGSizeMake(frame.size.width, frame.size.width)]];
        [self.contentView addConstraints:[imageView constraintsAssignTop]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = WJFont14;
        titleLabel.text = @"韩版撒旦法和卡的撒法国队撒方面";
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = WJColorMainTitle;
//        titleLabel.backgroundColor = WJColorCardRed;
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsSize:CGSizeMake(frame.size.width - 20, 34)]];
        [self.contentView addConstraints:[titleLabel constraintsTop:10 FromView:imageView]];
        [self.contentView addConstraints:[titleLabel constraintsLeftInContainer:10]];

        
        integralLabel = [[UILabel alloc]initForAutoLayout];
        integralLabel.textColor = WJColorMainTitle;
//        integralLabel.backgroundColor = WJColorCardRed;
        [self.contentView addSubview:integralLabel];
        [self.contentView addConstraints:[integralLabel constraintsSize:CGSizeMake(frame.size.width - 20, 12)]];
        [self.contentView addConstraints:[integralLabel constraintsLeftInContainer:10]];
        [self.contentView addConstraints:[integralLabel constraintsBottomInContainer:10]];
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"3599积分"];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont14,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,attrStr.length - 2)];
        [attrStr addAttributes:@{NSFontAttributeName:WJFont11,NSForegroundColorAttributeName:WJColorMainTitle,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 2, 2)];
        integralLabel.attributedText = attrStr;

    }
    return self;
}

-(void)configDataWithModel:(WJGoodsModel *)goodsModel
{
    titleLabel.text = goodsModel.goodsName;
    [imageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.picUrl]];
    NSString * string = [NSString stringWithFormat:@"%@积分",goodsModel.sellingPrice];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attrStr addAttributes:@{NSFontAttributeName:WJFont14,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,attrStr.length - 2)];
    [attrStr addAttributes:@{NSFontAttributeName:WJFont11,NSForegroundColorAttributeName:WJColorMainTitle,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 2, 2)];
    integralLabel.attributedText = attrStr;
}



@end
