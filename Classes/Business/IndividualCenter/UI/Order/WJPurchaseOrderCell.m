//
//  WJPurchaseOrderCell.m
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPurchaseOrderCell.h"
#import "WJProductModel.h"
#import "WJOrderModel.h"
#import <UIImageView+WebCache.h>
#import "WJAttributeDetailModel.h"


@interface WJPurchaseOrderCell ()
{    
    UIImageView *iconIV;
    
    UILabel     *nameL;
    UILabel     *standardL;
    UILabel     *countL;
}
@end

@implementation WJPurchaseOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(5), ALD(10), ALD(100), ALD(100))];
        iconIV.layer.borderColor = WJColorSeparatorLine.CGColor;
        iconIV.layer.borderWidth = 0.5f;
        iconIV.hidden = NO;
        

        nameL = [[UILabel alloc] initWithFrame:CGRectMake(iconIV.right+ ALD(15), iconIV.frame.origin.y + ALD(10), kScreenWidth - ALD(139), ALD(35))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont15;
        nameL.numberOfLines = 2;
        
        standardL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.frame.origin.x, nameL.bottom + ALD(20), ALD(150), ALD(22))];
        standardL.textColor = WJColorDardGray9;
        standardL.font = WJFont15;
        
        countL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(10) - ALD(40), standardL.origin.y, ALD(40), ALD(22))];
        countL.textAlignment = NSTextAlignmentRight;
        countL.textColor = WJColorDarkGray;
        countL.font = WJFont12;
        
        [self.contentView addSubview:iconIV];
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:standardL];
        [self.contentView addSubview:countL];
        
    }
    return self;
}


- (void)configDataWithProduct:(WJProductModel *)product
{
    NSString * standardStr = @"";
    for (WJAttributeDetailModel *model in product.attributeArray) {
        standardStr = [standardStr stringByAppendingFormat:@"%@:%@  ",model.attributeName,model.valueName];
    }
    standardL.text = standardStr;
    
    countL.text = [NSString stringWithFormat:@"x %ld",(long)product.count];
    
    [iconIV sd_setImageWithURL:[NSURL URLWithString:product.imageUrl] placeholderImage:BitmapCommodityImage];
    nameL.text = product.name;
}

@end
