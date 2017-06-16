//
//  WJRechargeCenterCell.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRechargeCenterCell.h"

@interface WJRechargeCenterCell ()
{
    UIImageView  * imageIV;
}
@end

@implementation WJRechargeCenterCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        imageIV = [[UIImageView alloc]initForAutoLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = WJFont14;
        self.textLabel.textColor = WJColorMainTitle;

        imageIV.image = [UIImage imageNamed:@"language_area_btn_radio button_n"];
        [self.contentView addSubview:imageIV];
        [self.contentView addConstraints:[imageIV constraintsRightInContainer:12]];
        [self.contentView addConstraint:[imageIV constraintCenterYInContainer]];
    }
    return self;
}

- (void)conFigData:(BOOL)isSelcet
{
    if (isSelcet == YES) {
        imageIV.image = [UIImage imageNamed:@"language_area_btn_radio button_s"];
    }else{
        imageIV.image = [UIImage imageNamed:@"language_area_btn_radio button_n"];
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
