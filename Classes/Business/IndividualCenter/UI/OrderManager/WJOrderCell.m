//
//  WJOrderCell.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderCell.h"
#import "WJProductModel.h"
#import <UIImageView+WebCache.h>
@interface WJOrderCell ()
{
    UIImageView *iconIV;
    
    UILabel     *nameL;
    UILabel     *standardL;
    UILabel     *countL;

}
@end

@implementation WJOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(5), ALD(5), ALD(92), ALD(108))];
        iconIV.layer.borderColor = WJColorSeparatorLine.CGColor;
        iconIV.layer.borderWidth = 0.5f;
        iconIV.backgroundColor = WJRandomColor;
        iconIV.hidden = NO;
        
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(iconIV.right+ ALD(15), iconIV.frame.origin.y, kScreenWidth - ALD(139), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont15;

        
        standardL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.frame.origin.x, nameL.bottom + ALD(10), ALD(150), ALD(22))];
        standardL.textColor = WJColorDardGray9;
        standardL.font = WJFont15;
        
        countL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(10) - ALD(40), nameL.bottom, ALD(40), ALD(22))];
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
    standardL.text = [NSString stringWithFormat:@"规格:%@",product.standardDes];
    
    countL.text = [NSString stringWithFormat:@"x %ld",(long)product.count];
    
    [iconIV sd_setImageWithURL:[NSURL URLWithString:product.imageUrl] placeholderImage:BitmapCommodityImage];
    nameL.text = product.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
