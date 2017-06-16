//
//  WJCategoryCell.m
//  jf_store
//
//  Created by reborn on 17/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryCell.h"
#import "WJCategoryListModel.h"
@interface WJCategoryCell ()
{
    UIView  *leftLine;
    UILabel *nameL;
}

@end

@implementation WJCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALD(2), ALD(42))];
        leftLine.backgroundColor = WJColorMainColor;
        [self.contentView addSubview:leftLine];
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(leftLine.right, 0, ALD(90) - ALD(2), ALD(42))];
        nameL.textColor = WJColorDardGray3;
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.font = WJFont14;
        [self.contentView addSubview:nameL];
    }
    return self;
}

-(void)configDataWithCategoryListModel:(WJCategoryListModel *)model
{
    nameL.text = model.categoryName;
    if (model.isSelect) {
        nameL.textColor = WJColorMainColor;
        leftLine.backgroundColor = WJColorMainColor;
        
        
    } else {
        nameL.textColor = WJColorDardGray3;
        leftLine.backgroundColor = [UIColor clearColor];
    }
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
