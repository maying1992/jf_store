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
    UILabel      *submitTimeL;
    UILabel      *userCodeL;
    UILabel      *integralL;

    UIImageView  * imageIV;
}
@end

@implementation WJConsumerActivateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        submitTimeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(50), ALD(10), ALD(120), ALD(20))];
        submitTimeL.textColor = WJColorBlack;
        submitTimeL.font = WJFont12;
        
        
        userCodeL = [[UILabel alloc] initWithFrame:CGRectMake(submitTimeL.right + ALD(10), ALD(10), ALD(80), ALD(20))];
        userCodeL.textColor = WJColorBlack;
        userCodeL.font = WJFont12;
        
        integralL = [[UILabel alloc] initWithFrame:CGRectMake(userCodeL.right, ALD(10), ALD(100), ALD(20))];
        integralL.textColor = WJColorBlack;
        integralL.textAlignment = NSTextAlignmentCenter;
        integralL.font = WJFont12;
        
        imageIV = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(12), (ALD(44) - ALD(20))/2, ALD(12), ALD(12))];
        imageIV.image = [UIImage imageNamed:@"activate_nor"];

        
        [self.contentView addSubview:imageIV];
        [self.contentView addSubview:submitTimeL];
        [self.contentView addSubview:userCodeL];
        [self.contentView addSubview:integralL];



    }
    return self;
}

- (void)conFigDataWithModel:(WJServiceCenterActivateModel *)model
{
    submitTimeL.text = model.submitTime;
    userCodeL.text = model.userCode;
    integralL.text = [NSString stringWithFormat:@"%@积分",model.integral];
    
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
