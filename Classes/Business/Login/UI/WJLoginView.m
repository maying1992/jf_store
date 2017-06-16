//
//  WJLoginView.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLoginView.h"

@interface WJLoginView ()<UITextFieldDelegate>
{
    UIView      *backgroundView;
    UILabel     *phoneLabel;
    UILabel     *passwordLabel;
    UIView      *line;
    UIView      *bottomLine;
}
@end

@implementation WJLoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLoginUI];
    }
    return self;
}

-(void)setLoginUI
{
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(88)+1)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundView];
    
    CGFloat phoneLabelWidth = [UILabel getWidthWithTitle:@"用户名" font:WJFont15];
    phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, phoneLabelWidth, ALD(44))];
    phoneLabel.font = WJFont15;
    phoneLabel.textColor = WJColorDardGray3;
    phoneLabel.text = @"用户名";
    [self addSubview:phoneLabel];
    
    [self addSubview:self.phoneTextField];
    
    line = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), phoneLabel.bottom, kScreenWidth - ALD(15), 0.5)];
    line.backgroundColor = WJColorSeparatorLine;
    [self addSubview:line];
    
    passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), line.bottom, phoneLabelWidth, ALD(44))];
    passwordLabel.font = WJFont15;
    passwordLabel.textColor = WJColorDardGray3;
    passwordLabel.text = @"密码";
    [self addSubview:passwordLabel];
    
    [self addSubview:self.phoneTextField];
    [self addSubview:self.passwordTextField];
    
    bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _passwordTextField.bottom, kScreenWidth, 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [self addSubview:bottomLine];
    
    [self addSubview:self.loginBtn];
    [self addSubview:self.forgetPasswordBtn];
    
    [self.phoneTextField becomeFirstResponder];
    
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
    
    if (string.length > 0 ) {
        if (self.phoneTextField.text.length >0 && self.passwordTextField.text.length > 0) {
            self.loginBtn.enabled = YES;
        }
    }else{
        if (textField.text.length <= 1) {
            if (self.phoneTextField.text.length <= 11 && self.passwordTextField.text.length <= 1) {
                self.loginBtn.enabled = NO;
            }
        }
    }
    
    return YES;
}

#pragma mark - Setter And Getter

- (UITextField *)phoneTextField
{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-phoneLabel.width, ALD(44))];
        _phoneTextField.font = WJFont15;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.placeholder = @"请输入用户编号或手机号";
        _phoneTextField.textColor = WJColorDardGray3;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.delegate = self;
    }
    return _phoneTextField;
}

- (UITextField *)passwordTextField
{
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(passwordLabel.right+ALD(15), line.bottom, SCREEN_WIDTH - ALD(140)-passwordLabel.width, ALD(44))];
        _passwordTextField.font = WJFont15;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.textColor = WJColorDardGray3;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setFrame:CGRectMake(ALD(15), ALD(50) + bottomLine.bottom + ALD(85), kScreenWidth - ALD(30), ALD(44))];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:WJColorWhite forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:WJFont15];
        [_loginBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorViewNotEditable] forState:UIControlStateDisabled];
        [_loginBtn setBackgroundImage:[WJUtilityMethod createImageWithColor:WJColorMainColor] forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 4;
        _loginBtn.enabled = NO;
        _loginBtn.adjustsImageWhenHighlighted = NO;
    }
    return _loginBtn;
}

- (UIButton *)forgetPasswordBtn
{
    if (_forgetPasswordBtn == nil) {
        _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordBtn setFrame:CGRectMake(kScreenWidth - 100 - ALD(15), ALD(10) + bottomLine.bottom, 100, ALD(20))];
        [_forgetPasswordBtn setBackgroundColor:[UIColor clearColor]];
        [_forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswordBtn setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
        [_forgetPasswordBtn setImage:[UIImage imageNamed:@"login_close_iocn"] forState:UIControlStateNormal];
        [_forgetPasswordBtn.titleLabel setFont:WJFont12];
        [_forgetPasswordBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        _forgetPasswordBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 100 - 7, 0, 0);
        _forgetPasswordBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
        
    }
    return _forgetPasswordBtn;
}

@end
