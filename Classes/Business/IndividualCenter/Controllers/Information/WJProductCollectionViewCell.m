//
//  WJProductCollectionViewCell.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJProductCollectionViewCell.h"
#import "WJCategoryProductModel.h"
#import <UIImageView+WebCache.h>
@interface WJProductCollectionViewCell ()
{
    UIImageView *imageView;
    UILabel     *titleLabel;
    UILabel     *integralLabel;
    UILabel     *priceLabel;
    UILabel     *shopLabel;
    UILabel     *districtLabel;
}

@end

@implementation WJProductCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = WJColorWhite;
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self.contentView addSubview:imageView];
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), imageView.bottom + ALD(10), frame.size.width - ALD(20), ALD(34))];
        titleLabel.font = WJFont14;
        titleLabel.text = @"韩版女装针织连衣裙民族风长轴中";
        titleLabel.numberOfLines = 2;
        titleLabel.textColor = WJColorMainTitle;
        [self.contentView addSubview:titleLabel];
        
        
        integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), titleLabel.bottom + ALD(12), frame.size.width - ALD(20), ALD(12))];
        integralLabel.textColor = WJColorMainTitle;
        integralLabel.font = WJFont12;
        integralLabel.text = @"3599积分";
        [self.contentView addSubview:integralLabel];
        

        shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), integralLabel.bottom + ALD(7), ALD(150), ALD(20))];
        shopLabel.text = @"Dior香水专营";
        shopLabel.textColor = WJColorDardGray9;
        shopLabel.font = WJFont11;
        [self.contentView addSubview:shopLabel];
        
        districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - ALD(5) - ALD(50), shopLabel.frame.origin.y, ALD(50), ALD(20))];
        districtLabel.text = @"北京";
        districtLabel.textAlignment = NSTextAlignmentRight;
        districtLabel.textColor = WJColorDardGray9;
        districtLabel.font = WJFont11;
        [self.contentView addSubview:districtLabel];
        
    }
    return self;
}

-(void)configDataWithModel:(WJCategoryProductModel *)productModel
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分+%@元",productModel.sellingIntegral,productModel.price]];
    
    [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSForegroundColorAttributeName:WJColorSubColor} range:NSMakeRange(0,productModel.sellingIntegral.length)];
    
    [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(productModel.sellingIntegral.length, 3)];
    
    
    [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSStrikethroughColorAttributeName:WJColorSubColor} range:NSMakeRange(productModel.sellingIntegral.length + 3, productModel.price.length)];
    
    [attrStr addAttributes:@{NSFontAttributeName:WJFont12,NSStrikethroughColorAttributeName:WJColorDardGray9} range:NSMakeRange(attrStr.length - 1, 1)];
    integralLabel.attributedText = attrStr;
    

    [imageView sd_setImageWithURL:[NSURL URLWithString:productModel.picUrl] placeholderImage:BitmapCommodityImage];
    titleLabel.text = productModel.name;
    
    
    shopLabel.text = productModel.shopName;
    districtLabel.text = productModel.district;
}



@end
