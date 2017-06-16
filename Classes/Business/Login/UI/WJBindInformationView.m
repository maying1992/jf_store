//
//  WJBindInformationView.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBindInformationView.h"

@interface WJBindInformationView ()<UITextFieldDelegate>
{
    UIView      *backgroundView;
    UILabel     *nameLabel;
    UILabel     *phoneLabel;
    UILabel     *identityCardLabel;
    UILabel     *identityLabel;

    UIView      *line;
    UIView      *middleLine;
    UIView      *bottomLine;
    
    UILabel     *frontTipsL;
    UILabel     *backTipsL;

    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation WJBindInformationView

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
    [self addSubview:self.confirmButton];
    [self addSubview:self.scrollView];
    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"身份证号" font:WJFont15];
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    nameLabel.font = WJFont15;
    nameLabel.textColor = WJColorDardGray3;
    nameLabel.text = @"姓名";
    [_scrollView addSubview:nameLabel];
    [_scrollView addSubview:self.nameTextField];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), nameLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:line];
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), line.bottom, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"手机号码";
    [_scrollView addSubview:phoneLabel];
    [_scrollView addSubview:self.phoneTextField];
    
    middleLine = [[UIView alloc] initWithFrame:CGRectMake(0, phoneLabel.bottom, kScreenWidth, 0.5)];
    middleLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:middleLine];
    
    
    identityCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), middleLine.bottom, phoneLabelWidth, ALD(44))];
    identityCardLabel.font = WJFont15;
    identityCardLabel.textColor = WJColorDardGray3;
    identityCardLabel.text = @"身份证号";
    [_scrollView addSubview:identityCardLabel];
    [_scrollView addSubview:self.identityCardTextField];
    
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, identityCardLabel.bottom, kScreenWidth, 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [_scrollView addSubview:bottomLine];
    
    identityLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), bottomLine.bottom, phoneLabelWidth, ALD(44))];
    identityLabel.font = WJFont15;
    identityLabel.textColor = WJColorDardGray3;
    identityLabel.text = @"身份证";
    [_scrollView addSubview:identityLabel];
    
    [_scrollView addSubview:self.frontIdCardButton];
    
    frontTipsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.frontIdCardButton.bottom, kScreenWidth - ALD(30), ALD(44))];
    frontTipsL.textAlignment = NSTextAlignmentCenter;
    frontTipsL.font = WJFont14;
    frontTipsL.textColor = WJColorDardGray6;
    frontTipsL.text = @"上传身份证正面清晰照片，复印件无效";
    [_scrollView addSubview:frontTipsL];
    
    [_scrollView addSubview:self.backIdCardButton];

    backTipsL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), self.backIdCardButton.bottom, kScreenWidth - ALD(30), ALD(44))];
    backTipsL.textAlignment = NSTextAlignmentCenter;
    backTipsL.font = WJFont14;
    backTipsL.textColor = WJColorDardGray6;
    backTipsL.text = @"上传身份证背面清晰照片，复印件无效";
    [_scrollView addSubview:backTipsL];
    
}

#pragma mark - Setter And Getter

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = WJColorWhite;
        _scrollView.contentSize = CGSizeMake(_scrollView.width, kScreenHeight * 1.2);
    }
    
    return _scrollView;
}

- (UITextField *)nameTextField
{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-nameLabel.width, ALD(44))];
        _nameTextField.font = WJFont15;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.placeholder = @"";
        _nameTextField.textColor = WJColorDardGray3;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.delegate = self;
    }
    return _nameTextField;
}


- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}


- (UITextField *)identityCardTextField
{
    if (_identityCardTextField == nil) {
        _identityCardTextField = [[UITextField alloc] initWithFrame:CGRectMake(identityCardLabel.right+ALD(15), middleLine.bottom, SCREEN_WIDTH - ALD(140)-identityCardLabel.width, ALD(44))];
        _identityCardTextField.font = WJFont15;
        _identityCardTextField.keyboardType = UIKeyboardTypeDefault;
        _identityCardTextField.placeholder = @"";
        _identityCardTextField.textColor = WJColorDardGray3;
        _identityCardTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _identityCardTextField.delegate = self;
    }
    return _identityCardTextField;
}

-(UIButton *)frontIdCardButton
{
    if (nil == _frontIdCardButton) {
        
        _frontIdCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _frontIdCardButton.frame = CGRectMake(ALD(30), bottomLine.bottom + ALD(44), kScreenWidth - ALD(60), ALD(200));
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

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0,kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth, ALD(44));
        _confirmButton.titleLabel.font = WJFont16;
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        _confirmButton.titleLabel.textColor = WJColorWhite;
        _confirmButton.backgroundColor = WJColorMainColor;

    }
    return _confirmButton;
}

@end
