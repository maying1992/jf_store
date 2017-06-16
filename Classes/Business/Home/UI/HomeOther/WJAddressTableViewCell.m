//
//  WJAddressTableViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/8.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAddressTableViewCell.h"

@interface WJAddressTableViewCell()
{
    UIImageView  * imageIV;
}

@end

@implementation WJAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        imageIV = [[UIImageView alloc]initForAutoLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = WJFont14;
        self.textLabel.textColor = WJColorMainTitle;
        self.textLabel.text = @"北京";
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 0.5)];
        bottomLine.backgroundColor = WJColorSeparatorLine1;
        imageIV.image = [UIImage imageNamed:@"language_area_btn_radio button_n"];
        [self.contentView addSubview:imageIV];
        [self.contentView addConstraints:[imageIV constraintsRightInContainer:12]];
        [self.contentView addConstraint:[imageIV constraintCenterYInContainer]];
        [self.contentView addSubview:bottomLine];
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


@end
