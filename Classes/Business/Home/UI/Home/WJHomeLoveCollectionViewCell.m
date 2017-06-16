//
//  WJHomeLoveCollectionViewCell.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJHomeLoveCollectionViewCell.h"

@implementation WJHomeLoveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [button setTitle:@"猜你喜欢的" forState:UIControlStateNormal];
        button.titleLabel.font = WJFont15;
        [button setTitleColor:WJColorMainTitle forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"home_love_icon"] forState:UIControlStateNormal];
        button.enabled = NO;
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.contentView addSubview:button];
    }
    return self;
}
@end
