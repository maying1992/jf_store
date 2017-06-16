//
//  WJAddressButton.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAddressButton.h"

@implementation WJAddressButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:WJColorWhite forState:UIControlStateNormal];
        self.titleLabel.font = WJFont14;
        [self setImage:[UIImage imageNamed:@"home_region-selection_btn_n"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+4;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.height = 20;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
    self.height = 20;
}

@end
