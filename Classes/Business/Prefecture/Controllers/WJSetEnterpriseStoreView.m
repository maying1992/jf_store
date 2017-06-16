//
//  WJSetEnterpriseStoreView.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSetEnterpriseStoreView.h"
#import "WJStoreCategorySelectView.h"
@interface WJSetEnterpriseStoreView ()<UITextFieldDelegate>
{
    
    UILabel     *storeNameLabel;
    UILabel     *storeTypeLabel;
    UIImageView *typeIV;
    UILabel     *phoneLabel;
    UILabel     *regionLabel;
    UILabel     *detailAddressLabel;
    UILabel     *businessLicenseLabel;
    UIView      *line;
    UIView      *secondLine;
    UIView      *thirdLine;
    UIView      *fourLine;
    UIView      *bottomLine;
    
    
    UILabel     *organizationCodeLabel;
    UILabel     *accountPermissionLabel;
    UILabel     *taxRegisterLabel;
    UILabel     *legalIDCardLabel;

    
    UILabel     *businessLicenseTips;
    UILabel     *organizationCodeTips;
    UILabel     *accountPermissionTips;
    UILabel     *taxRegisterTips;

    UILabel     *frontTipsL;
    UILabel     *backTipsL;
}
@property(nonatomic,strong)UIScrollView               *scrollView;
@property(nonatomic,strong)WJStoreCategorySelectView *categorySelectView;


@end

@implementation WJSetEnterpriseStoreView

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
    [self addSubview:self.submitApplyButton];
    [self addSubview:self.scrollView];
    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"开户许可证" font:WJFont15];
    storeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    storeNameLabel.font = WJFont15;
    storeNameLabel.textColor = WJColorDardGray3;
    storeNameLabel.text = @"店铺名称";
    [_scrollView addSubview:storeNameLabel];
    [_scrollView addSubview:self.storeNameTextField];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), storeNameLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:line];
    
    
    storeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), line.bottom, phoneLabelWidth, ALD(44))];
    storeTypeLabel.font = WJFont15;
    storeTypeLabel.textColor = WJColorDardGray3;
    storeTypeLabel.text = @"店铺分类";
    [_scrollView addSubview:storeTypeLabel];
    [_scrollView addSubview:self.storeTypeTextField];
    
    UIImage *rightIV = [UIImage imageNamed:@"icon_arrow_right"];
    typeIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - rightIV.size.width - ALD(5), line.bottom + ALD(13), rightIV.size.width, rightIV.size.height)];
    typeIV.image = rightIV;
    [_scrollView addSubview:typeIV];
    
    secondLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), storeTypeLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    secondLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:secondLine];
    
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), secondLine.bottom, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"联系方式";
    [_scrollView addSubview:phoneLabel];
    [_scrollView addSubview:self.phoneTextField];
    
    thirdLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), phoneLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    thirdLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:thirdLine];
    
    regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), thirdLine.bottom, phoneLabelWidth, ALD(44))];
    regionLabel.font = WJFont15;
    regionLabel.textColor = WJColorDardGray3;
    regionLabel.text = @"所在地";
    [_scrollView addSubview:regionLabel];
    [_scrollView addSubview:self.regionTextField];
    
    fourLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), regionLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    fourLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:fourLine];
    
    detailAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), fourLine.bottom, phoneLabelWidth, ALD(44))];
    detailAddressLabel.font = WJFont15;
    detailAddressLabel.textColor = WJColorDardGray3;
    detailAddressLabel.text = @"详细地址";
    [_scrollView addSubview:detailAddressLabel];
    [_scrollView addSubview:self.detailAddressTextField];
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), detailAddressLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:bottomLine];
    
    businessLicenseLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), bottomLine.bottom, phoneLabelWidth, ALD(44))];
    businessLicenseLabel.font = WJFont15;
    businessLicenseLabel.textColor = WJColorDardGray3;
    businessLicenseLabel.text = @"营业执照";
    [_scrollView addSubview:businessLicenseLabel];
    [_scrollView addSubview:self.businessLicenseTextField];
    
    
    [_scrollView addSubview:self.businessLicenseButton];
    
    businessLicenseTips = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.businessLicenseButton.bottom + ALD(10), kScreenWidth - ALD(30), ALD(22))];
    businessLicenseTips.textAlignment = NSTextAlignmentCenter;
    businessLicenseTips.font = WJFont14;
    businessLicenseTips.textColor = WJColorDardGray6;
    businessLicenseTips.text = @"上传营业执照正面清晰照片，复印件无效";
    [_scrollView addSubview:businessLicenseTips];
    
    organizationCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), businessLicenseTips.bottom + ALD(5), phoneLabelWidth, ALD(44))];
    organizationCodeLabel.font = WJFont15;
    organizationCodeLabel.textColor = WJColorDardGray3;
    organizationCodeLabel.text = @"组织代码";
    [_scrollView addSubview:organizationCodeLabel];
    
    [_scrollView addSubview:self.organizationCodeButton];
    
    
    organizationCodeTips = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.organizationCodeButton.bottom, kScreenWidth - ALD(30), ALD(22))];
    organizationCodeTips.textAlignment = NSTextAlignmentCenter;
    organizationCodeTips.font = WJFont14;
    organizationCodeTips.textColor = WJColorDardGray6;
    organizationCodeTips.text = @"上传组织代码证清晰照片，复印件无效";
    [_scrollView addSubview:organizationCodeTips];
    
    
    accountPermissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), organizationCodeTips.bottom + ALD(5), phoneLabelWidth, ALD(44))];
    accountPermissionLabel.font = WJFont15;
    accountPermissionLabel.textColor = WJColorDardGray3;
    accountPermissionLabel.text = @"开户许可证";
    [_scrollView addSubview:accountPermissionLabel];
    [_scrollView addSubview:self.accountPermissionButton];

    accountPermissionTips = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.accountPermissionButton.bottom, kScreenWidth - ALD(30), ALD(22))];
    accountPermissionTips.textAlignment = NSTextAlignmentCenter;
    accountPermissionTips.font = WJFont14;
    accountPermissionTips.textColor = WJColorDardGray6;
    accountPermissionTips.text = @"上传开户许可证清晰照片，复印件无效";
    [_scrollView addSubview:accountPermissionTips];
    

    taxRegisterLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), accountPermissionTips.bottom + ALD(5), phoneLabelWidth, ALD(44))];
    taxRegisterLabel.font = WJFont15;
    taxRegisterLabel.textColor = WJColorDardGray3;
    taxRegisterLabel.text = @"税务登记证";
    [_scrollView addSubview:taxRegisterLabel];
    [_scrollView addSubview:self.taxRegisterButton];
    
    
    taxRegisterTips = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.taxRegisterButton.bottom, kScreenWidth - ALD(30), ALD(22))];
    taxRegisterTips.textAlignment = NSTextAlignmentCenter;
    taxRegisterTips.font = WJFont14;
    taxRegisterTips.textColor = WJColorDardGray6;
    taxRegisterTips.text = @"上传税务登记证清晰照片，复印件无效";
    [_scrollView addSubview:taxRegisterTips];
    
    
    
    legalIDCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), taxRegisterTips.bottom + ALD(5), phoneLabelWidth, ALD(44))];
    legalIDCardLabel.font = WJFont15;
    legalIDCardLabel.textColor = WJColorDardGray3;
    legalIDCardLabel.text = @"法人身份证";
    [_scrollView addSubview:legalIDCardLabel];
    [_scrollView addSubview:self.frontIdCardButton];
    
    frontTipsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.frontIdCardButton.bottom, kScreenWidth - ALD(30), ALD(22))];
    frontTipsL.textAlignment = NSTextAlignmentCenter;
    frontTipsL.font = WJFont14;
    frontTipsL.textColor = WJColorDardGray6;
    frontTipsL.text = @"上传身份证正面清晰照片，复印件无效";
    [_scrollView addSubview:frontTipsL];
    
    [_scrollView addSubview:self.backIdCardButton];
    
    backTipsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.backIdCardButton.bottom, kScreenWidth - ALD(30), ALD(22))];
    backTipsL.textAlignment = NSTextAlignmentCenter;
    backTipsL.font = WJFont14;
    backTipsL.textColor = WJColorDardGray6;
    backTipsL.text = @"上传身份证背面清晰照片，复印件无效";
    [_scrollView addSubview:backTipsL];
    
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.storeTypeTextField) {
        [_storeTypeTextField resignFirstResponder];
        [self addSubview:self.categorySelectView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneTextField) {
        if ([string length] > 0) {
            if (textField.text.length >= 11) {
                
                return NO;
            }
        }
    }
    
    
    if (string.length > 0 ) {
        
        if (self.storeNameTextField.text.length >0 && self.storeTypeTextField.text.length > 0 && self.phoneTextField.text.length > 0 && self.regionTextField.text.length > 0 && self.detailAddressTextField.text.length) {
            self.submitApplyButton.enabled = YES;
        }
        
    } else {
        
        if (textField.text.length <= 1) {
            
            if (self.storeNameTextField.text.length <= 1 && self.storeTypeTextField.text.length <= 1 && self.phoneTextField.text.length <= 11 && self.regionTextField.text.length <= 1 && self.detailAddressTextField.text.length <= 1) {
                self.submitApplyButton.enabled = NO;
            }
        }
    }
    
    return YES;
}

#pragma mark - setter& getter

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = WJColorWhite;
        _scrollView.contentSize = CGSizeMake(_scrollView.width, kScreenHeight * 2.8);
    }
    
    return _scrollView;
}

- (UITextField *)storeNameTextField
{
    if (_storeNameTextField == nil) {
        _storeNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(storeNameLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-storeNameLabel.width, ALD(44))];
        _storeNameTextField.font = WJFont15;
        _storeNameTextField.keyboardType = UIKeyboardTypeDefault;
        _storeNameTextField.placeholder = @"";
        _storeNameTextField.textColor = WJColorDardGray3;
        _storeNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _storeNameTextField.delegate = self;
    }
    return _storeNameTextField;
}

- (UITextField *)storeTypeTextField
{
    if (_storeTypeTextField == nil) {
        _storeTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(storeTypeLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-storeTypeLabel.width, ALD(44))];
        _storeTypeTextField.font = WJFont15;
        _storeTypeTextField.keyboardType = UIKeyboardTypeDefault;
        _storeTypeTextField.placeholder = @"";
        _storeTypeTextField.textColor = WJColorDardGray3;
        _storeTypeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _storeTypeTextField.delegate = self;
    }
    return _storeTypeTextField;
}

-(UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(15), secondLine.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

-(UITextField *)regionTextField
{
    if (_regionTextField == nil) {
        _regionTextField = [[UITextField alloc] initWithFrame:CGRectMake(regionLabel.right+ALD(15), thirdLine.bottom, SCREEN_WIDTH - ALD(140)-regionLabel.width, ALD(44))];
        _regionTextField.font = WJFont15;
        _regionTextField.keyboardType = UIKeyboardTypeNumberPad;
        _regionTextField.placeholder = @"";
        _regionTextField.textColor = WJColorDardGray3;
        _regionTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _regionTextField.delegate = self;
    }
    return _regionTextField;
}

-(UITextField *)detailAddressTextField
{
    if (_detailAddressTextField == nil) {
        _detailAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(detailAddressLabel.right+ALD(15), fourLine.bottom, SCREEN_WIDTH - ALD(140)-detailAddressLabel.width, ALD(44))];
        _detailAddressTextField.font = WJFont15;
        _detailAddressTextField.keyboardType = UIKeyboardTypeNumberPad;
        _detailAddressTextField.placeholder = @"";
        _detailAddressTextField.textColor = WJColorDardGray3;
        _detailAddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _detailAddressTextField.delegate = self;
    }
    return _regionTextField;
}


- (UITextField *)businessLicenseTextField
{
    if (_businessLicenseTextField == nil) {
        _businessLicenseTextField = [[UITextField alloc] initWithFrame:CGRectMake(businessLicenseLabel.right+ALD(15), bottomLine.bottom, SCREEN_WIDTH - ALD(140)-businessLicenseLabel.width, ALD(44))];
        _businessLicenseTextField.font = WJFont15;
        _businessLicenseTextField.keyboardType = UIKeyboardTypeDefault;
        _businessLicenseTextField.placeholder = @"";
        _businessLicenseTextField.textColor = WJColorDardGray3;
        _businessLicenseTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _businessLicenseTextField.delegate = self;
    }
    return _businessLicenseTextField;
}

-(UIButton *)businessLicenseButton
{
    if (nil == _businessLicenseButton) {
        
        _businessLicenseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _businessLicenseButton.frame = CGRectMake(ALD(30), bottomLine.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
        [_businessLicenseButton setImage:[UIImage imageNamed:@"IDCardFront_icon"] forState:UIControlStateNormal];
        _businessLicenseButton.layer.cornerRadius = 10;
        _businessLicenseButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _businessLicenseButton.layer.borderWidth = 0.5;
        _businessLicenseButton.titleLabel.font = WJFont14;
        _businessLicenseButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _businessLicenseButton;
}

-(UIButton *)organizationCodeButton
{
    if (nil == _organizationCodeButton) {
        
        _organizationCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _organizationCodeButton.frame = CGRectMake(ALD(30), businessLicenseTips.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
        [_organizationCodeButton setImage:[UIImage imageNamed:@"IDCardFront_icon"] forState:UIControlStateNormal];
        _organizationCodeButton.layer.cornerRadius = 10;
        _organizationCodeButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _organizationCodeButton.layer.borderWidth = 0.5;
        _organizationCodeButton.titleLabel.font = WJFont14;
        _organizationCodeButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _organizationCodeButton;
}

-(UIButton *)accountPermissionButton
{
    if (nil == _accountPermissionButton) {
        
        _accountPermissionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accountPermissionButton.frame = CGRectMake(ALD(30), organizationCodeTips.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
        [_accountPermissionButton setImage:[UIImage imageNamed:@"IDCardFront_icon"] forState:UIControlStateNormal];
        _accountPermissionButton.layer.cornerRadius = 10;
        _accountPermissionButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _accountPermissionButton.layer.borderWidth = 0.5;
        _accountPermissionButton.titleLabel.font = WJFont14;
        _accountPermissionButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _accountPermissionButton;
}

-(UIButton *)taxRegisterButton
{
    if (nil == _taxRegisterButton) {
        
        _taxRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _taxRegisterButton.frame = CGRectMake(ALD(30),accountPermissionTips.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
        [_taxRegisterButton setImage:[UIImage imageNamed:@"IDCardFront_icon"] forState:UIControlStateNormal];
        _taxRegisterButton.layer.cornerRadius = 10;
        _taxRegisterButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _taxRegisterButton.layer.borderWidth = 0.5;
        _taxRegisterButton.titleLabel.font = WJFont14;
        _taxRegisterButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _taxRegisterButton;
}


-(UIButton *)frontIdCardButton
{
    if (nil == _frontIdCardButton) {
        
        _frontIdCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _frontIdCardButton.frame = CGRectMake(ALD(30), taxRegisterTips.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
        [_frontIdCardButton setImage:[UIImage imageNamed:@"IDCardFront_icon"] forState:UIControlStateNormal];
        _frontIdCardButton.layer.cornerRadius = 10;
        _frontIdCardButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _frontIdCardButton.layer.borderWidth = 0.5;
        _frontIdCardButton.titleLabel.font = WJFont14;
        _frontIdCardButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _frontIdCardButton;
}

-(UIButton *)backIdCardButton
{
    if (nil == _backIdCardButton) {
        
        _backIdCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backIdCardButton.frame = CGRectMake(ALD(30), frontTipsL.bottom + ALD(20), kScreenWidth - ALD(60), ALD(200));
        [_backIdCardButton setImage:[UIImage imageNamed:@"IDCardBack_icon"] forState:UIControlStateNormal];
        _backIdCardButton.layer.cornerRadius = 10;
        _backIdCardButton.layer.borderColor = WJColorSeparatorLine.CGColor;
        _backIdCardButton.layer.borderWidth = 0.5;
        _backIdCardButton.titleLabel.font = WJFont14;
        _backIdCardButton.backgroundColor = [UIColor whiteColor];
        
    }
    return _backIdCardButton;
}

-(UIButton *)submitApplyButton
{
    if (nil == _submitApplyButton) {
        
        _submitApplyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitApplyButton.frame = CGRectMake(0,kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth, ALD(44));
        _submitApplyButton.titleLabel.font = WJFont16;
        [_submitApplyButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _submitApplyButton.titleLabel.textColor = WJColorWhite;
        _submitApplyButton.backgroundColor = WJColorMainColor;
        
    }
    return _submitApplyButton;
}

-(WJStoreCategorySelectView *)categorySelectView
{
    if (!_categorySelectView) {
        _categorySelectView = [[WJStoreCategorySelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  kNavBarAndStatBarHeight - ALD(300), kScreenWidth, ALD(300))];
        
        __weak typeof(self) weakSelf = self;
        _categorySelectView.cancelButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.categorySelectView removeFromSuperview];

        };
        
        _categorySelectView.confirmButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.categorySelectView removeFromSuperview];
            strongSelf.confirmButtonBlock();
        };
        
    }
    return _categorySelectView;
}

@end
