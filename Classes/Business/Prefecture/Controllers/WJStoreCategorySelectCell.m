//
//  WJStoreCategorySelectCell.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreCategorySelectCell.h"
#import "WJStoreCategoryModel.h"
@interface WJStoreCategorySelectCell ()
{
    UILabel *label;
}
@end

@implementation WJStoreCategorySelectCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = WJColorDardGray6.CGColor;
        label.layer.borderWidth = 0.5;
        label.backgroundColor = WJColorWhite;
        label.font = WJFont13;
        label.textColor = WJColorDardGray3;
        [self.contentView addSubview:label];
    }
    return self;
    
}

-(void)configDataWithStoreCategoryModel:(WJStoreCategoryModel *)model
{
    label.text = model.categoryName;
    
    if (model.isSelect) {
        label.textColor = WJColorWhite;
        label.layer.borderColor = WJColorMainColor.CGColor;
        label.backgroundColor = WJColorMainColor;
        
    } else {
     
        label.textColor = WJColorDardGray3;
        label.layer.borderColor = WJColorDardGray6.CGColor;
        label.backgroundColor = WJColorWhite;
    }
}


@end
