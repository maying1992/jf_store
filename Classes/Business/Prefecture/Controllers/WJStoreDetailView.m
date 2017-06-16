//
//  WJStoreDetailView.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreDetailView.h"

@interface WJStoreDetailView ()<UITextFieldDelegate>
{
    UILabel     *storeNameLabel;
    UILabel     *storeNoticeLabel;
    UIImageView *rightArrowIV;
    UILabel     *phoneLabel;
    UILabel     *regionLabel;
    UILabel     *addressLabel;
    UIView      *line;
    UIView      *secondLine;
    UIView      *thirdLine;
    UIView      *bottomLine;
}
@end

@implementation WJStoreDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    self.backgroundColor = WJColorViewBg;
    [self addSubview:self.storeImageView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.storeImageView.bottom + ALD(10), kScreenWidth, ALD(220))];
    bgView.backgroundColor = WJColorWhite;
    [self addSubview:bgView];

    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"店铺名称" font:WJFont15];
    storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    storeNameLabel.font = WJFont15;
    storeNameLabel.textColor = WJColorDardGray3;
    storeNameLabel.text = @"店铺名称";
    [bgView addSubview:storeNameLabel];
    [bgView addSubview:self.storeNameTextField];
    

    line = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), storeNameLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [bgView addSubview:line];
    
    storeNoticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), line.bottom, phoneLabelWidth, ALD(44))];
    storeNoticeLabel.font = WJFont15;
    storeNoticeLabel.textColor = WJColorDardGray3;
    storeNoticeLabel.text = @"店铺公告";
    [bgView addSubview:storeNoticeLabel];
    [bgView addSubview:self.storeNoticeTextField];
    
    
    UIImage *rightIV = [UIImage imageNamed:@"icon_arrow_right"];
    rightArrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - rightIV.size.width - ALD(5), line.bottom + ALD(13), rightIV.size.width, rightIV.size.height)];
    rightArrowIV.image = rightIV;
    [bgView addSubview:rightArrowIV];
    
    
    secondLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), storeNoticeLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    secondLine.backgroundColor = WJColorSeparatorLine;
    [bgView addSubview:secondLine];
    
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), secondLine.bottom, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"联系方式";
    [bgView addSubview:phoneLabel];
    [bgView addSubview:self.phoneTextField];
    
    thirdLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), phoneLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    thirdLine.backgroundColor = WJColorSeparatorLine;
    [bgView addSubview:thirdLine];
    
    
    regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), thirdLine.bottom, phoneLabelWidth, ALD(44))];
    regionLabel.font = WJFont15;
    regionLabel.textColor = WJColorDardGray3;
    regionLabel.text = @"所在地";
    [bgView addSubview:regionLabel];
    [bgView addSubview:self.regionTextField];
    
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), regionLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [bgView addSubview:bottomLine];
    
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), bottomLine.bottom, phoneLabelWidth, ALD(44))];
    addressLabel.font = WJFont15;
    addressLabel.textColor = WJColorDardGray3;
    addressLabel.text = @"地址";
    [bgView addSubview:addressLabel];
    [bgView addSubview:self.addressTextField];
    
}

-(void)configDataWithModel:(WJStoreModel *)storeModel
{
    _storeNameTextField.text = storeModel.storeName;
    _storeNoticeTextField.text = storeModel.storeNotice;
    _phoneTextField.text = storeModel.phone;
    _regionTextField.text = storeModel.region;
    _addressTextField.text = storeModel.address;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.storeNoticeTextField) {
        [_storeNoticeTextField resignFirstResponder];
        self.tapStoreNoticeBlock();
    }
}

#pragma mark - setter& getter

-(UIImageView *)storeImageView
{
    if (_storeImageView == nil) {
        _storeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(200))];
        _storeImageView.backgroundColor = WJRandomColor;
    }
    return _storeImageView;
}

- (UITextField *)storeNameTextField
{
    if (_storeNameTextField == nil) {
        _storeNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(storeNameLabel.right+ALD(35), storeNameLabel.origin.y, kScreenWidth - ALD(65) - storeNameLabel.width, ALD(44))];
        _storeNameTextField.font = WJFont15;
        _storeNameTextField.textAlignment = NSTextAlignmentRight;
        _storeNameTextField.keyboardType = UIKeyboardTypeDefault;
        _storeNameTextField.placeholder = @"";
        _storeNameTextField.textColor = WJColorDardGray3;
        _storeNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _storeNameTextField.delegate = self;
        _storeNameTextField.userInteractionEnabled = NO;

    }
    return _storeNameTextField;
}


- (UITextField *)storeNoticeTextField
{
    if (_storeNoticeTextField == nil) {
        _storeNoticeTextField = [[UITextField alloc] initWithFrame:CGRectMake(storeNoticeLabel.right+ALD(35), line.bottom, kScreenWidth - ALD(65) -storeNoticeLabel.width, ALD(44))];
        _storeNoticeTextField.font = WJFont15;
        _storeNoticeTextField.keyboardType = UIKeyboardTypeDefault;
        _storeNoticeTextField.placeholder = @"";
        _storeNoticeTextField.textColor = WJColorDardGray3;
        _storeNoticeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _storeNoticeTextField.delegate = self;
    }
    return _storeNoticeTextField;
}


- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(35), secondLine.bottom, kScreenWidth - ALD(65)- phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.textAlignment = NSTextAlignmentRight;
        _phoneTextField.keyboardType = UIKeyboardTypeDefault;
        _phoneTextField.placeholder = @"";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.userInteractionEnabled = NO;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (UITextField *)regionTextField
{
    if (_regionTextField == nil) {
        _regionTextField = [[UITextField alloc] initWithFrame:CGRectMake(regionLabel.right+ALD(35), thirdLine.bottom, kScreenWidth - ALD(65) - regionLabel.width, ALD(44))];
        _regionTextField.font = WJFont15;
        _regionTextField.textAlignment = NSTextAlignmentRight;
        _regionTextField.keyboardType = UIKeyboardTypeDefault;
        _regionTextField.placeholder = @"";
        _regionTextField.textColor = WJColorDardGray3;
        _regionTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _regionTextField.userInteractionEnabled = NO;
        _regionTextField.delegate = self;
    }
    return _regionTextField;
}



- (UITextField *)addressTextField
{
    if (_addressTextField == nil) {
        _addressTextField = [[UITextField alloc] initWithFrame:CGRectMake(addressLabel.right+ALD(35), bottomLine.bottom, kScreenWidth - ALD(65) - addressLabel.width, ALD(44))];
        _addressTextField.font = WJFont15;
        _addressTextField.textAlignment = NSTextAlignmentRight;
        _addressTextField.keyboardType = UIKeyboardTypeDefault;
        _addressTextField.placeholder = @"";
        _addressTextField.textColor = WJColorDardGray3;
        _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addressTextField.userInteractionEnabled = NO;
        _addressTextField.delegate = self;
    }
    return _addressTextField;
}

@end
