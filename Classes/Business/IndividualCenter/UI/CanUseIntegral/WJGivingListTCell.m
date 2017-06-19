//
//  WJGivingListTCell.m
//  jf_store
//
//  Created by reborn on 2017/5/27.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGivingListTCell.h"

@interface WJGivingListTCell ()
{
    UILabel *timeL;
    UILabel *integralL;
    UILabel *typeL;
    
    UIButton *givingButton;
}
@end

@implementation WJGivingListTCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        integralL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(5), ALD(150), ALD(22))];
        integralL.textColor = WJColorDardGray3;
        integralL.font = WJFont15;
        
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), integralL.bottom + ALD(6), kScreenWidth - ALD(24) - ALD(90) - ALD(10), ALD(22))];
        timeL.textColor = WJColorDardGray3;
        timeL.font = WJFont12;
        
        givingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        givingButton.frame = CGRectMake(kScreenWidth - ALD(12) - ALD(90), (ALD(60) - ALD(30))/2, ALD(80), ALD(30));
        [givingButton setTitle:@"赠送" forState:UIControlStateNormal];
        [givingButton setTitleColor:WJColorDardGray6 forState:UIControlStateNormal];
        givingButton.layer.cornerRadius = 16;
        givingButton.layer.borderWidth = 0.5;
        givingButton.layer.borderColor = WJColorDardGray6.CGColor;
        givingButton.userInteractionEnabled = NO;
        [givingButton addTarget:self action:@selector(givingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(90) - ALD(15), (ALD(60) - ALD(44))/2,1, ALD(44))];
        lineView.backgroundColor = WJColorSeparatorLine;
        
        typeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(90) - ALD(15) - ALD(40) - ALD(40), ALD(5), ALD(40), ALD(30))];
        typeL.textColor = WJColorDardGray3;
        typeL.font = WJFont15;
        typeL.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:timeL];
        [self.contentView addSubview:integralL];
        [self.contentView addSubview:givingButton];
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:typeL];
    }
    return self;
}

-(void)configDataWithModel:(WJGivingIntegralModel *)model
{
    timeL.text = [NSString stringWithFormat:@"开始：%@ 结束:%@",model.startTime,model.endTime];
    integralL.text = [NSString stringWithFormat:@"%@积分",model.integral];
    typeL.text = model.remark;
    
    if (model.isDoubly == 1) {
        
        givingButton.userInteractionEnabled = YES;
        
        givingButton.layer.cornerRadius = 16;
        givingButton.layer.borderWidth = 0.5;
        givingButton.layer.borderColor = WJColorMainColor.CGColor;
        [givingButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];

        
    } else {
        
        givingButton.userInteractionEnabled = NO;
        
        givingButton.layer.cornerRadius = 16;
        givingButton.layer.borderWidth = 0.5;
        givingButton.layer.borderColor = WJColorDardGray6.CGColor;
        [givingButton setTitleColor:WJColorDardGray6 forState:UIControlStateNormal];


    }


}


#pragma mark - Action
-(void)givingButtonAction
{
    self.tapGivingBlock();
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
