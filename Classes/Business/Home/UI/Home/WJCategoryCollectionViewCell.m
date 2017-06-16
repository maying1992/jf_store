//
//  WJCategoryCollectionViewCell.m
//  HuPlus
//
//  Created by reborn on 16/12/19.
//  Copyright © 2016年 IHUJIA. All rights reserved.
//

#import "WJCategoryCollectionViewCell.h"
//#import "WJCategoryListModel.h"
#import "UIImageView+WebCache.h"

@interface WJCategoryCollectionViewCell ()
{
    UIImageView *categoryImageView;
    UILabel     *categoryL;
}
@end

@implementation WJCategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WJColorWhite;

        categoryL = [[UILabel alloc] initForAutoLayout];
        categoryL.font = WJFont13;
        categoryL.textAlignment = NSTextAlignmentCenter;
        categoryL.textColor = WJColorMainTitle;
        [self.contentView addSubview:categoryL];
        [self.contentView addConstraint:[categoryL constraintHeight:15]];
        [self.contentView addConstraints:[categoryL constraintsBottomInContainer:10]];
        [self.contentView addConstraints:[categoryL constraintsAssignLeft]];
        [self.contentView addConstraints:[categoryL constraintsAssignRight]];

        categoryImageView = [[UIImageView alloc]initForAutoLayout];
        categoryImageView.backgroundColor = WJColorWhite;
        [self.contentView addSubview:categoryImageView];
        [self.contentView addConstraints:[categoryImageView constraintsSize:CGSizeMake(40, 40)]];
        [self.contentView addConstraint:[categoryImageView constraintCenterXInContainer]];
        [self.contentView addConstraints:[categoryImageView constraintsBottom:ALD(10) FromView:categoryL]];
    }
    return self;
}

- (void)conFigData:(UIImage *)image title:(NSString *)titleStr
{
    categoryL.text = titleStr;
    categoryImageView.image = image;
}

-(void)configDataWithModel:(WJChannelModel *)channelModel
{
    categoryL.text = channelModel.channelName;
    [categoryImageView sd_setImageWithURL:[NSURL URLWithString:channelModel.channelPic]];
}


@end
