//
//  WJConsumerServiceIntegralCell.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerServiceIntegralCell.h"

@interface WJConsumerServiceIntegralCell ()
{
    UILabel *timeL;
    UILabel *detailL;
    UILabel *integralL;
}

@end

@implementation WJConsumerServiceIntegralCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WJColorViewBg2;
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kScreenWidth/3,  ALD(60))];
        timeL.textAlignment = NSTextAlignmentCenter;
        timeL.font = WJFont12;
        timeL.numberOfLines = 0;
        timeL.textColor = WJColorDardGray3;
        
        
        detailL = [[UILabel alloc] initWithFrame:CGRectMake(timeL.right,0, kScreenWidth/3,  ALD(60))];
        detailL.textAlignment = NSTextAlignmentCenter;
        detailL.font = WJFont12;
        detailL.numberOfLines = 0;
        detailL.textColor = WJColorDardGray3;
        

        integralL = [[UILabel alloc] initWithFrame:CGRectMake(detailL.right,0, kScreenWidth/3,  ALD(60))];
        integralL.textAlignment = NSTextAlignmentCenter;
        integralL.font = WJFont12;
        integralL.numberOfLines = 0;
        integralL.textColor = WJColorDardGray3;
        
        [self.contentView addSubview:timeL];
        [self.contentView addSubview:detailL];
        [self.contentView addSubview:integralL];
     
        
    }
    return self;
}

-(void)configDataWithModel:(WJConsumeModel *)model
{
    timeL.text = model.date;
    detailL.text = model.desc;
    if ([model.integral integerValue] > 0) {
        
        integralL.text = [NSString stringWithFormat:@"%@积分",model.integral];
    } else {
        integralL.text = @"0积分";
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
