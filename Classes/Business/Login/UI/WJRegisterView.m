//
//  WJRegisterView.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRegisterView.h"

#define countTimeDown   60

@interface WJRegisterView ()<UITextFieldDelegate>
{
    UIView      *backgroundView;
    UILabel     *userNumberLabel;
    UILabel     *phoneLabel;
    UILabel     *passwordLabel;
    UILabel     *verifyLabel;
    UILabel     *recommendNumberLabel;

    UIView      *firstLine;
    UIView      *sectionLine;
    UIView      *thirdLine;
    UIView      *fourLine;
    UIView      *bottomLine;
    
    NSInteger   timeCount;
}

@end

@implementation WJRegisterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

#pragma mark - Cusitom Function

- (void)addUI
{
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(220)+2.5)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"推荐人编码" font:WJFont15];
    userNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    userNumberLabel.font = WJFont15;
    userNumberLabel.textColor = WJColorDardGray3;
    userNumberLabel.text = @"用户编号";
    [self addSubview:userNumberLabel];
    [self addSubview:self.userNumberTextField];
    [self addSubview:self.changeUserNumberBtn];
    
    firstLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), userNumberLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    firstLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:firstLine];
    
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), firstLine.bottom, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"手机号";
    [self addSubview:phoneLabel];
    [self addSubview:self.phoneTextField];
    
    sectionLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), phoneLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    sectionLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:sectionLine];
    
    passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), sectionLine.bottom, phoneLabelWidth, ALD(44))];
    passwordLabel.font = WJFont15;
    passwordLabel.textColor = WJColorDardGray3;
    passwordLabel.text = @"密码";
    [self addSubview:passwordLabel];
    [self addSubview:self.passwordTextField];
    
    thirdLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), passwordLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    thirdLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:thirdLine];


    verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), thirdLine.bottom, phoneLabelWidth, ALD(44))];
    verifyLabel.font = WJFont15;
    verifyLabel.textColor = WJColorDardGray3;
    verifyLabel.text = @"验证码";
    [self addSubview:verifyLabel];
    [self addSubview:self.verifyTextField];
    [self addSubview:self.getVerifyCodeBtn];
    
    fourLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), verifyLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    fourLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:fourLine];
    
    recommendNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), fourLine.bottom, phoneLabelWidth, ALD(44))];
    recommendNumberLabel.font = WJFont15;
    recommendNumberLabel.textColor = WJColorDardGray3;
    recommendNumberLabel.text = @"推荐人编码";
    [self addSubview:recommendNumberLabel];
    [self addSubview:self.recommendedTextField];
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _recommendedTextField.bottom, kScreenWidth, 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:bottomLine];
    
    [self addSubview:self.serviceBtn];
    [self addSubview:self.registerBtn];
    
    timeCount = countTimeDown;
}

#pragma mark - 倒计时功能

- (void)startTimer{
    [self.getVerifyCodeBtn setTitle:@"60秒" forState:UIControlStateNormal];
    self.getVerifyCodeBtn.enabled = NO;
    [self.verifyTimer invalidate];
    self.verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBtnTitle) userInfo:nil repeats:YES];
    [_verifyTimer fire];
}

- (void)changeBtnTitle{
    
    if (timeCount <= 0) {
        timeCount = 60;
        [self.verifyTimer invalidate];
        _verifyTimer = nil;
        [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerifyCodeBtn.enabled = YES;
        return;
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.getVerifyCodeBtn setTitle:[NSString stringWithFormat:@"%@秒", @(timeCount--)] forState:UIControlStateNormal];
        });
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phoneTextField) {
        if ([string length] > 0) {
            if (textField.text.length >= 11) {
                
                return NO;
            }
        }
    }
    
    if (textField == self.passwordTextField) {
        if ([string length] > 0) {
            if (textField.text.length >= 6) {
                return NO;
            }
        }
    }
    
    if (textField == self.verifyTextField) {
        if ([string length] > 0) {
            if (textField.text.length >= 6) {
                return NO;
            }
        }
    }
    
    if (string.length > 0 ) {
        
        if (self.phoneTextField.text.length >0 && self.passwordTextField.text.length > 0 && self.verifyTextField.text.length > 0 && self.recommendedTextField.text.length > 0) {
            self.registerBtn.enabled = YES;
        }
    } else {
        
        if (textField.text.length <= 1) {
            
            if (self.phoneTextField.text.length <= 11 && self.passwordTextField.text.length <= 1 && self.verifyTextField.text.length <= 1 && self.recommendedTextField.text.length <= 1) {
                self.registerBtn.enabled = NO;
            }
        }
    }
    
    return YES;
}


- (UITextField *)userNumberTextField
{
    if (_userNumberTextField == nil) {
        _userNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(userNumberLabel.right+ALD(15), firstLine.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _userNumberTextField.font = WJFont15;
//        _userNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userNumberTextField.userInteractionEnabled = NO;
        _userNumberTextField.textColor = WJColorDardGray3;
        _userNumberTextField.placeholder = @"请输入用户编号";

        _userNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNumberTextField.delegate = self;
    }
    return _userNumberTextField;
}


- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(15), firstLine.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"请输入11位手机号码";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right+ALD(15), sectionLine.bottom, SCREEN_WIDTH - ALD(120)-phoneLabel.width, ALD(44))];
        _passwordTextField.font = WJFont15;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.placeholder = @"请输入6位密码字母数字组合";
        _passwordTextField.textColor = WJColorDardGray3;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UITextField *)verifyTextField
{
    if (_verifyTextField == nil) {
        _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(verifyLabel.right+ALD(15), thirdLine.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _verifyTextField.font = WJFont15;
        _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _verifyTextField.placeholder = @"请输入验证码";
        _verifyTextField.textColor = WJColorDardGray3;
        _verifyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyTextField.delegate = self;
    }
    return _verifyTextField;
}

- (UITextField *)recommendedTextField
{
    if (_recommendedTextField == nil) {
        _recommendedTextField = [[UITextField alloc] initWithFrame:CGRectMake(recommendNumberLabel.right+ALD(15), fourLine.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _recommendedTextField.font = WJFont15;
        _recommendedTextField.keyboardType = UIKeyboardTypeDefault;
        _recommendedTextField.placeholder = @"请输入推荐人编码";
        _recommendedTextField.textColor = WJColorDardGray3;
        _recommendedTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _recommendedTextField.delegate = self;
    }
    return _recommendedTextField;
}


- (UIButton *)getVerifyCodeBtn
{
    if (_getVerifyCodeBtn == nil) {
        _getVerifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getVerifyCodeBtn.frame = CGRectMake(kScreenWidth - ALD(95), _verifyTextField.centerY - ALD(15), ALD(80), ALD(30));
        [_getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifyCodeBtn setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        _getVerifyCodeBtn.titleLabel.font = WJFont12;
        _getVerifyCodeBtn.layer.cornerRadius = 4;
        _getVerifyCodeBtn.layer.borderColor = [WJColorMainColor CGColor];
        _getVerifyCodeBtn.layer.borderWidth = 0.5;
    }
    return _getVerifyCodeBtn;
}

- (UIButton *)changeUserNumberBtn
{
    if (_changeUserNumberBtn == nil) {
        _changeUserNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeUserNumberBtn.frame = CGRectMake(kScreenWidth - ALD(95), _userNumberTextField.centerY - ALD(15), ALD(80), ALD(30));
        [_changeUserNumberBtn setTitle:@"更换用户编号" forState:UIControlStateNormal];
        [_changeUserNumberBtn setTitleColor:WJColorMainColor forState:UIControlStateNormal];
        _changeUserNumberBtn.titleLabel.font = WJFont12;
        _changeUserNumberBtn.layer.cornerRadius = 4;
        _changeUserNumberBtn.layer.borderColor = [WJColorMainColor CGColor];
        _changeUserNumberBtn.layer.borderWidth = 0.5;
    }
    return _changeUserNumberBtn;
}


- (UIButton *)serviceBtn
{
    if (_serviceBtn == nil) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn setFrame:CGRectMake(ALD(15), ALD(10) + bottomLine.bottom, kScreenWidth, ALD(44))];
        [_serviceBtn setTitle:@"《世通智能易物商城》服务协议" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:WJColorDardGray9 forState:UIControlStateNormal];
        [_serviceBtn.titleLabel setFont:WJFont13];
        [_serviceBtn setImage:[UIImage imageNamed:@"registerService_icon"] forState:UIControlStateNormal];
        _serviceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, ALD(12), 0, ALD(180));
        _serviceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ALD(180));
    }
    return _serviceBtn;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setFrame:CGRectMake(ALD(15), ALD(50) + bottomLine.bottom, kScreenWidth - ALD(30), ALD(44))];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
        [_registerBtn.titleLabel setFont:WJFont15];
        [_registerBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorViewNotEditable] forState:UIControlStateDisabled];
        [_registerBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorMainColor] forState:UIControlStateNormal];
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 4;
        _registerBtn.enabled = NO;
        _registerBtn.adjustsImageWhenHighlighted = NO;
    }
    return _registerBtn;
}


@end
