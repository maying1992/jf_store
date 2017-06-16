//
//  WJPushMessageCell.m
//  jf_store
//
//  Created by WJSystemMessageCell on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPushMessageCell.h"
#import "WJSystemMessageModel.h"
@interface WJPushMessageCell ()
{
    UILabel           *timeL;
    UILabel           *titleL;
    UILabel           *dateL;
    UIImageView       *imageView;
    UILabel           *contentL;
    UIView            *bgView;
    UIView            *line;
    UILabel           *detailL;
    UIImageView       *rightArrowIV;
}

@end

@implementation WJPushMessageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WJColorViewBg2;
        
        timeL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12),contentL.bottom + ALD(10), ALD(200),  ALD(15))];
        timeL.textAlignment = NSTextAlignmentCenter;
        timeL.font = WJFont12;
        timeL.textColor = WJColorDardGray9;
        
        bgView = [[UIView alloc] initWithFrame:CGRectZero];
        bgView.backgroundColor = WJColorWhite;
        bgView.layer.cornerRadius = ALD(4);
        bgView.layer.masksToBounds = YES;
        
        titleL = [[UILabel alloc] initWithFrame:CGRectZero];
        titleL.font = WJFont16;
        titleL.textColor =WJColorDardGray3;
        
        dateL = [[UILabel alloc] initWithFrame:CGRectZero];
        dateL.font = WJFont10;
        dateL.textColor =WJColorDardGray9;
        
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor orangeColor];
        
        contentL = [[UILabel alloc] initWithFrame:CGRectZero];
        contentL.textAlignment = NSTextAlignmentLeft;
        contentL.lineBreakMode = NSLineBreakByWordWrapping;
        contentL.numberOfLines = 0;
        contentL.font          = WJFont14;
        contentL.textColor     = WJColorDardGray3;
        
        line =[[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = WJColorSeparatorLine;
        
        detailL = [[UILabel alloc] initWithFrame:CGRectZero];
        detailL.textAlignment = NSTextAlignmentLeft;
        detailL.text = @"详情";
        detailL.font          = WJFont12;
        detailL.textColor     = WJColorDardGray3;
        
        rightArrowIV = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:timeL];
        [self.contentView addSubview:bgView];
        [bgView addSubview:titleL];
        [bgView addSubview:dateL];
        [bgView addSubview:imageView];
        [bgView addSubview:contentL];
        [bgView addSubview:line];
        [bgView addSubview:detailL];
        [bgView addSubview:rightArrowIV];
        
    }
    return self;
}

- (void)configData:(WJSystemMessageModel *)model{
    
    timeL.text  = [NSString stringWithFormat:@"%@",model.time];
    timeL.frame = CGRectMake((kScreenWidth - ALD(200))/2,ALD(10), ALD(200), ALD(15));
    titleL.text = model.title;
    dateL.text = model.date;
    contentL.text = model.content;
    
    NSDictionary *dic           = [NSDictionary dictionaryWithObjectsAndKeys:WJFont14,NSFontAttributeName,nil];
    CGSize sizeText             = [contentL.text boundingRectWithSize:CGSizeMake(kScreenWidth - ALD(24), MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin  | NSStringDrawingTruncatesLastVisibleLine
                                                           attributes:dic context:nil].size;
    
    
    bgView.frame           = CGRectMake(ALD(12), timeL.bottom + ALD(5), kScreenWidth - ALD(24), sizeText.height + ALD(300));
    titleL.frame           = CGRectMake(ALD(12), ALD(12), ALD(kScreenWidth - ALD(34)), ALD(20));
    dateL.frame            = CGRectMake(ALD(12), titleL.bottom + ALD(8), ALD(100), ALD(15));
    imageView.frame        = CGRectMake(ALD(12), dateL.bottom + ALD(5), bgView.width - ALD(24), ALD(175));
    contentL.frame         = CGRectMake(ALD(12), imageView.bottom + ALD(10), kScreenWidth - ALD(54), sizeText.height);
    line.frame             = CGRectMake(ALD(12), contentL.bottom + ALD(15), bgView.width - ALD(24), 0.5);
    detailL.frame          = CGRectMake(ALD(12), line.bottom + ALD(10), ALD(50), ALD(20));
    
    UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
    rightArrowIV.frame     = CGRectMake(bgView.width-image.size.width-ALD(10), detailL.origin.y, image.size.width, image.size.height);
    
    rightArrowIV.image = image;
    
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
