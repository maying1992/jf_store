//
//  WJForgetIntegralPasswordViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJForgetIntegralPasswordViewController.h"
#import "WJForgetIntegralPasswordView.h"
#import "APIVerifyCodeManager.h"
#import "WJPasswordSettingViewController.h"

@interface WJForgetIntegralPasswordViewController ()
@property(nonatomic,strong)WJForgetIntegralPasswordView   *forgetPasswordView;
@property(nonatomic,strong)APIVerifyCodeManager           *verifyCodeManager;
//@property(nonatomic,strong)APIForgetPasswordManager       *forgetPasswordManager;
@end

@implementation WJForgetIntegralPasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置支付密码";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.forgetPasswordView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.forgetPasswordView  addGestureRecognizer:tapGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    WJPasswordSettingViewController *passwordSettingVC = [[WJPasswordSettingViewController alloc] init];
    passwordSettingVC.passwordType = PasswordTypeReset;
    passwordSettingVC.passwordSettingFrom = PasswordSettingFromOther;
    [self.navigationController pushViewController:passwordSettingVC animated:YES];
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}


- (void)getVerifyAction
{
    //验证手机号
    if([WJUtilityMethod isValidatePhone:self.forgetPasswordView.phoneTextField.text]) {
        //验证码请求
        [self.verifyCodeManager loadData];
        [self.forgetPasswordView startTimer];
        self.forgetPasswordView.verifyTextField.text = @"";
        [self.forgetPasswordView.verifyTextField becomeFirstResponder];
        
    } else {
        if(self.forgetPasswordView.phoneTextField.text.length <= 0){
            ALERT(@"请输入正确手机号");
        } else {
            ALERT(@"请输入正确格式的验证码");
        }
    }
    
}

-(void)nextBtnAction
{
    //接口请求
    [_forgetPasswordView.phoneTextField resignFirstResponder];
    [_forgetPasswordView.verifyTextField resignFirstResponder];
    
    
    if (![WJUtilityMethod isValidatePhone:_forgetPasswordView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }

    if (!(_forgetPasswordView.verifyTextField.text.length > 0)) {
        ALERT(@"请输入验证码");
        return;
    }
//    [self.forgetPasswordManager loadData];
    
}

#pragma mark -event
-(void)handletapPressGesture
{
    [self.forgetPasswordView.phoneTextField resignFirstResponder];
    [self.forgetPasswordView.verifyTextField resignFirstResponder];
}

#pragma mark - Setter And Getter
- (WJForgetIntegralPasswordView *)forgetPasswordView
{
    if (_forgetPasswordView== nil) {
        _forgetPasswordView = [[WJForgetIntegralPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_forgetPasswordView.nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_forgetPasswordView.getVerifyCodeBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _forgetPasswordView;
}

-(APIVerifyCodeManager *)verifyCodeManager
{
    if (!_verifyCodeManager) {
        _verifyCodeManager = [[APIVerifyCodeManager alloc] init];
        _verifyCodeManager.delegate = self;
    }
    _verifyCodeManager.loginName = self.forgetPasswordView.phoneTextField.text;
    return _verifyCodeManager;
}


//-(APIForgetPasswordManager *)forgetPasswordManager
//{
//    if (!_forgetPasswordManager) {
//        _forgetPasswordManager = [[APIForgetPasswordManager alloc] init];
//        _forgetPasswordManager.delegate = self;
//    }
//    _forgetPasswordManager.loginName = self.forgetPasswordView.phoneTextField.text;
//    _forgetPasswordManager.password = self.forgetPasswordView.userNewPasswordTextField.text;
//    _forgetPasswordManager.verifyCode = self.forgetPasswordView.verifyTextField.text;
//    return _forgetPasswordManager;
//}

@end
