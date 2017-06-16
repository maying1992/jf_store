//
//  WJForgetPasswordView.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJForgetPasswordView.h"

#define countTimeDown   60
@interface WJForgetPasswordView ()<UITextFieldDelegate>
{
    UIView      *backgroundView;
    UILabel     *phoneLabel;
    UILabel     *newPasswordLabel;
    UILabel     *verifyLabel;
    UIView      *line;
    UIView      *middleLine;
    UIView      *bottomLine;
    
    NSInteger   timeCount;
}
@end

@implementation WJForgetPasswordView


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
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(132)+1.5)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"手机号" font:WJFont15];
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"手机号";
    [self addSubview:phoneLabel];
    [self addSubview:self.phoneTextField];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), phoneLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [self addSubview:line];
    
    newPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), line.bottom, phoneLabelWidth, ALD(44))];
    newPasswordLabel.font = WJFont15;
    newPasswordLabel.textColor = WJColorDardGray3;
    newPasswordLabel.text = @"新密码";
    [self addSubview:newPasswordLabel];
    [self addSubview:self.userNewPasswordTextField];
    
    middleLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), newPasswordLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    middleLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:middleLine];
    
    verifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), middleLine.bottom, phoneLabelWidth, ALD(44))];
    verifyLabel.font = WJFont15;
    verifyLabel.textColor = WJColorDardGray3;
    verifyLabel.text = @"验证码";
    [self addSubview:verifyLabel];
    
    [self addSubview:self.verifyTextField];
    [self addSubview:self.getVerifyCodeBtn];
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _verifyTextField.bottom, kScreenWidth, 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:bottomLine];
    
    [self addSubview:self.confirmBtn];
    
    
    timeCount = countTimeDown;
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
    
    if (textField == self.userNewPasswordTextField) {
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
        
        if (self.phoneTextField.text.length >0 && self.userNewPasswordTextField.text.length > 0 && self.verifyTextField.text.length > 0) {
            self.confirmBtn.enabled = YES;
        }
    } else {
        
        if (textField.text.length <= 1) {
            
            if (self.phoneTextField.text.length <= 11 && self.userNewPasswordTextField.text.length <= 1 && self.verifyTextField.text.length <= 1) {
                self.confirmBtn.enabled = NO;
            }
        }
    }
    
    return YES;
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


- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"请输入11位手机号码";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (UITextField *)userNewPasswordTextField
{
    if (_userNewPasswordTextField == nil) {
        _userNewPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(newPasswordLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-newPasswordLabel.width, ALD(44))];
        _userNewPasswordTextField.font = WJFont15;
        _userNewPasswordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userNewPasswordTextField.placeholder = @"请输入6位新密码字母数字组合";
        _userNewPasswordTextField.textColor = WJColorDardGray3;
        _userNewPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNewPasswordTextField.delegate = self;
    }
    return _userNewPasswordTextField;
}

- (UITextField *)verifyTextField
{
    if (_verifyTextField == nil) {
        _verifyTextField = [[UITextField alloc] initWithFrame:CGRectMake(verifyLabel.right+ALD(15), middleLine.bottom, SCREEN_WIDTH - ALD(140)-verifyLabel.width, ALD(44))];
        _verifyTextField.font = WJFont15;
        _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
        _verifyTextField.placeholder = @"请输入验证码";
        _verifyTextField.textColor = WJColorDardGray3;
        _verifyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verifyTextField.delegate = self;
    }
    return _verifyTextField;
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

- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setFrame:CGRectMake(ALD(15), ALD(50) + bottomLine.bottom, kScreenWidth - ALD(30), ALD(44))];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:WJFont15];
        [_confirmBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorViewNotEditable] forState:UIControlStateDisabled];
        [_confirmBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorMainColor] forState:UIControlStateNormal];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 4;
        _confirmBtn.enabled = NO;
        _confirmBtn.adjustsImageWhenHighlighted = NO;
    }
    return _confirmBtn;
}


@end
