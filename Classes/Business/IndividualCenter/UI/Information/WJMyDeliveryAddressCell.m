//
//  WJMyDeliveryAddressCell.m
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMyDeliveryAddressCell.h"
#import "WJDeliveryAddressModel.h"

@interface WJMyDeliveryAddressCell ()
{
    UILabel     *nameL;
    UILabel     *phoneL;
    UILabel     *addressL;
    UIImageView *defaultImageView;
    UIButton    *setDefaultButton;
    UIButton    *editButton;
//    UIButton    *deleteButton;
}
@end

@implementation WJMyDeliveryAddressCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), ALD(15), ALD(80), ALD(20))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont14;
        
        
        phoneL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.right + ALD(5), ALD(15), ALD(100), ALD(20))];
        phoneL.textColor = WJColorDardGray3;
        phoneL.font = WJFont14;
        
        
        addressL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10),phoneL.bottom + ALD(5), kScreenWidth - ALD(20), ALD(20))];
        addressL.textColor = WJColorLightGray;
        addressL.font = WJFont14;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ALD(12), addressL.bottom + ALD(5), kScreenWidth - ALD(24), 0.5)];
        lineView.backgroundColor = WJColorSeparatorLine;
        
        
        setDefaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        setDefaultButton.frame = CGRectMake(ALD(10), lineView.bottom + ALD(10), ALD(120), ALD(30));
        [setDefaultButton setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [setDefaultButton setTitleColor:WJColorLightGray forState:UIControlStateNormal];
        [setDefaultButton setTitleColor:WJColorDardGray3 forState:UIControlStateSelected];
        [setDefaultButton setImage:[UIImage imageNamed:@"address_nor"] forState:UIControlStateNormal];
        [setDefaultButton setImage:[UIImage imageNamed:@"address_sel"] forState:UIControlStateSelected];
        setDefaultButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ALD(70));
        setDefaultButton.titleEdgeInsets = UIEdgeInsetsMake(0, ALD(10), 0, 0);
        setDefaultButton.titleLabel.font = WJFont14;
        [setDefaultButton addTarget:self action:@selector(setDefaultButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame = CGRectMake(kScreenWidth - ALD(10) - ALD(90), setDefaultButton.frame.origin.y, ALD(90), ALD(30));
        [editButton setTitle:@"修改" forState:UIControlStateNormal];
        [editButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        editButton.imageEdgeInsets = UIEdgeInsetsMake(0, ALD(15), 0, ALD(40));
        [editButton setImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
        editButton.titleLabel.font = WJFont14;
        [editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.contentView addSubview:nameL];
        [self.contentView addSubview:phoneL];
        [self.contentView addSubview:addressL];
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:setDefaultButton];
        [self.contentView addSubview:editButton];
        
    }
    return self;
    
}

-(void)configAddressdDataWithModel:(WJDeliveryAddressModel *)model
{
    nameL.text = model.name;
    phoneL.text = model.phone;
    addressL.text = [NSString stringWithFormat:@"%@%@%@%@",model.provinceName,model.cityName,model.districtName,model.detailAddress];
    
    if (model.isDefaultAddress) {
        
        [setDefaultButton setImage:[UIImage imageNamed:@"address_sel"] forState:UIControlStateNormal];
        [setDefaultButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        
    } else {
        
        [setDefaultButton setImage:[UIImage imageNamed:@"address_nor"] forState:UIControlStateNormal];
        [setDefaultButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        
    }
}

#pragma mark - Action
-(void)setDefaultButtonAction:(UIButton *)button
{
    self.settingDefaultAddressBlock();
}

-(void)editButtonAction:(UIButton *)button
{
    self.editAddressBlock();
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
