//
//  WJConsumerServiceTopView.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerServiceTopView.h"

@interface WJConsumerServiceTopView ()
{
    UILabel     *redIntegralL;
    UILabel     *integralL;
    UILabel     *timeL;
    
    UIButton    *rechargeRedIntegralBtn;
}
@end

@implementation WJConsumerServiceTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        redIntegralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(20), ALD(50), ALD(20))];
        redIntegralL.text = @"红积分";
        redIntegralL.textColor = WJColorWhite;
        redIntegralL.font = WJFont15;
        
        
        integralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), redIntegralL.bottom + ALD(23), kScreenWidth - ALD(32) - ALD(120) , ALD(50))];
        integralL.textColor = WJColorWhite;
        integralL.textAlignment = NSTextAlignmentLeft;
        integralL.font = WJFont45;
        integralL.text = @"2350积分";
        
        
        rechargeRedIntegralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rechargeRedIntegralBtn.frame = CGRectMake(kScreenWidth - ALD(15) - ALD(120), frame.size.height - ALD(52) - ALD(44), ALD(120), ALD(44));
        [rechargeRedIntegralBtn setTitle:@"充值红积分" forState:UIControlStateNormal];
        [rechargeRedIntegralBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
        rechargeRedIntegralBtn.layer.cornerRadius = 22;
        rechargeRedIntegralBtn.layer.borderColor = WJColorWhite.CGColor;
        rechargeRedIntegralBtn.layer.borderWidth = 0.5;
        rechargeRedIntegralBtn.titleLabel.font = WJFont15;
        [rechargeRedIntegralBtn addTarget:self action:@selector(rechargeRedIntegralAction) forControlEvents:UIControlEventTouchUpInside];
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), integralL.bottom + ALD(30), kScreenWidth - ALD(24), ALD(20))];
        timeL.text = @"开始时间：2017-03-24 结束时间：2019-02-05";
        timeL.textColor = [WJUtilityMethod colorWithHexColorString:@"#95dcd5"];
        timeL.font = WJFont12;
        
        [self addSubview:redIntegralL];
        [self addSubview:integralL];
        [self addSubview:rechargeRedIntegralBtn];
        [self addSubview:timeL];
        
    }
    return self;
}

-(void)rechargeRedIntegralAction
{
    self.rechargeRedIntegralBlock();
    
}

@end
