//
//  WJConsumerActivateCell.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerActivateCell.h"

@interface WJConsumerActivateCell ()
{
    UIImageView  * imageIV;
}
@end

@implementation WJConsumerActivateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        imageIV = [[UIImageView alloc]initForAutoLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = WJFont14;
        self.textLabel.textColor = WJColorMainTitle;
        
        imageIV.image = [UIImage imageNamed:@"activate_nor"];
        [self.contentView addSubview:imageIV];
        [self.contentView addConstraints:[imageIV constraintsRightInContainer:12]];
        [self.contentView addConstraint:[imageIV constraintCenterYInContainer]];
    }
    return self;
}

- (void)conFigDataWithMemberModel:(WJMemberModel *)model
{
    self.textLabel.text = model.name;
    if (model.isSelect) {
        imageIV.image = [UIImage imageNamed:@"activate_select"];

    } else {
        
        imageIV.image = [UIImage imageNamed:@"activate_nor"];

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
