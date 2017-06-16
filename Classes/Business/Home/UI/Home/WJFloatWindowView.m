//
//  WJFloatWindowView.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJFloatWindowView.h"

@implementation WJFloatWindowView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setImage:[UIImage imageNamed:@"home_activity_btn_close"] forState:UIControlStateNormal];
        [self addSubview:_cancelButton];
        [self addConstraints:[_cancelButton constraintsTopInContainer:120]];
        [self addConstraints:[_cancelButton constraintsRightInContainer:34]];
        
        self.advertisementIV = [[UIImageView alloc]initForAutoLayout];
        _advertisementIV.image = [WJUtilityMethod createImageWithColor:WJColorCardRed];
        [self addSubview:_advertisementIV];
        [self addConstraints:[_advertisementIV constraintsSize:CGSizeMake(250, 300)]];
        [self addConstraints:[_advertisementIV constraintsTopInContainer:134]];
        [self addConstraint:[_advertisementIV constraintCenterXInContainer]];
    }
    return self;
}

@end
