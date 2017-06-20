//
//  WJTitleButton.m
//  HuPlus
//
//  Created by XT Xiong on 2016/12/27.
//  Copyright © 2016年 IHUJIA. All rights reserved.
//

#import "WJTitleButton.h"

@implementation WJTitleButton

- (void)setTapText:(NSString *)text
{
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:WJColorMainTitle forState:UIControlStateNormal];
//        [self setTitleColor:WJColorMainColor forState:UIControlStateSelected];
        self.titleLabel.font = WJFont14;
        [self setImage:[UIImage imageNamed:@"classified-screening_icon"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"classified-screening_icon_n"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+2;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    self.height = 40;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
    self.height = 40;
}

@end
