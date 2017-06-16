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
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(5), ALD(200), ALD(22))];
        timeL.textColor = WJColorDardGray3;
        timeL.text = @"2017-03-25";
        timeL.font = WJFont12;
    
        

        integralL = [[UILabel alloc] initWithFrame:CGRectMake(timeL.frame.origin.x, timeL.bottom + ALD(6), ALD(150), ALD(22))];
        integralL.textColor = WJColorDardGray3;
        integralL.font = WJFont15;
        integralL.text = @"3545积分";
        
        givingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        givingButton.frame = CGRectMake(kScreenWidth - ALD(12) - ALD(90), (ALD(60) - ALD(30))/2, ALD(80), ALD(30));
        [givingButton setTitle:@"赠送" forState:UIControlStateNormal];
        [givingButton setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        givingButton.layer.cornerRadius = 16;
        givingButton.layer.borderWidth = 0.5;
        givingButton.layer.borderColor = WJColorMainColor.CGColor;
        [givingButton addTarget:self action:@selector(givingButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(90) - ALD(15), (ALD(60) - ALD(44))/2,1, ALD(44))];
        lineView.backgroundColor = WJColorSeparatorLine;
        
        typeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(90) - ALD(15) - ALD(40) - ALD(40), (ALD(60) - ALD(30))/2, ALD(40), ALD(30))];
        typeL.textColor = WJColorDardGray3;
        typeL.font = WJFont15;
        typeL.text = @"激活";
        typeL.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:timeL];
        [self.contentView addSubview:integralL];
        [self.contentView addSubview:givingButton];
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:typeL];
    }
    return self;
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
