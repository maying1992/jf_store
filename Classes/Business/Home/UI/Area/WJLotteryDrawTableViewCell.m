//
//  WJLotteryDrawTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface WJLotteryDrawTableViewCell()
{
    UIImageView     * imageView;
    UILabel         * titleLabel;
    UILabel         * integralLabel;
    UILabel         * yetDrawLabel;
    UILabel         * totalLabel;
    UIView          * bottomView;
}
@end

@implementation WJLotteryDrawTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WJColorWhite;
        
        bottomView = [[UIView alloc]initForAutoLayout];
        bottomView.backgroundColor = WJColorViewBg;
        [self.contentView addSubview:bottomView];
        [self.contentView addConstraints:[bottomView constraintsSize:CGSizeMake(kScreenWidth, 10)]];
        [self.contentView addConstraints:[bottomView constraintsBottomInContainer:0]];
        
        imageView = [[UIImageView alloc]initForAutoLayout];
        imageView.image = [WJUtilityMethod createImageWithColor:WJRandomColor];
        [self.contentView addSubview:imageView];
        [self.contentView addConstraints:[imageView constraintsSize:CGSizeMake(100, 100)]];
        [self.contentView addConstraints:[imageView constraintsTopInContainer:10]];
        [self.contentView addConstraints:[imageView constraintsLeftInContainer:12]];
        
        titleLabel = [[UILabel alloc]initForAutoLayout];
        titleLabel.font = WJFont15;
        titleLabel.textColor = WJColorMainTitle;
        titleLabel.text = @"茶水壶";
        [self.contentView addSubview:titleLabel];
        [self.contentView addConstraints:[titleLabel constraintsTopInContainer:15]];
        [self.contentView addConstraints:[titleLabel constraintsLeft:10 FromView:imageView]];
        
        integralLabel = [[UILabel alloc]initForAutoLayout];
        integralLabel.font = WJFont13;
        integralLabel.textColor = WJColorDardGray6;
        integralLabel.text = @"积分：1800";
        [self.contentView addSubview:integralLabel];
        [self.contentView addConstraints:[integralLabel constraintsTop:8 FromView:titleLabel]];
        [self.contentView addConstraints:[integralLabel constraintsLeft:10 FromView:imageView]];
        
        yetDrawLabel = [[UILabel alloc]initForAutoLayout];
        yetDrawLabel.font = WJFont13;
        yetDrawLabel.textColor = WJColorDardGray6;
        yetDrawLabel.text = @"已抽奖：51";
        [self.contentView addSubview:yetDrawLabel];
        [self.contentView addConstraints:[yetDrawLabel constraintsTop:8 FromView:integralLabel]];
        [self.contentView addConstraints:[yetDrawLabel constraintsLeft:10 FromView:imageView]];
        
        totalLabel = [[UILabel alloc]initForAutoLayout];
        totalLabel.font = WJFont13;
        totalLabel.textColor = WJColorDardGray6;
        totalLabel.text = @"总抽奖人数1000人";
        [self.contentView addSubview:totalLabel];
        [self.contentView addConstraints:[totalLabel constraintsTop:8 FromView:yetDrawLabel]];
        [self.contentView addConstraints:[totalLabel constraintsLeft:10 FromView:imageView]];
    }
    return self;
}

-(void)configDataWithModel:(WJLotteryDrawListModel *)model
{
    titleLabel.text = model.goodsName;
    integralLabel.text = [NSString stringWithFormat:@"积分：%@",model.integral];
    yetDrawLabel.text = [NSString stringWithFormat:@"已抽奖：%@",model.prizeCount];
    totalLabel.text = [NSString stringWithFormat:@"总抽奖人数：%@人",model.prizeTimes];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}


@end
