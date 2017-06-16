//
//  WJForgetPasswordViewController.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJForgetPasswordViewController.h"
#import "WJForgetPasswordView.h"
#import "APIVerifyCodeManager.h"
#import "APIForgetPasswordManager.h"
#import "WJPasswordSettingViewController.h"

@interface WJForgetPasswordViewController ()<APIManagerCallBackDelegate>

@property(nonatomic,strong)WJForgetPasswordView     *forgetPasswordView;
@property(nonatomic,strong)APIVerifyCodeManager     *verifyCodeManager;
@property(nonatomic,strong)APIForgetPasswordManager *forgetPasswordManager;

@end

@implementation WJForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
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
    ALERT(@"修改成功");
    NSDictionary *userDic = [[manager fetchDataWithReformer:nil] objectForKey:@"val"];
    NSString *newToken = userDic[@"token"];

    NSDictionary  *userInformation = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    NSLog(@"old%@",userInformation);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:userInformation];
    [dic setObject:newToken forKey:@"key"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:KUserInformation];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSDictionary  *newUserInformation = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    NSLog(@"new%@",newUserInformation);
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

-(void)confirmAction
{
    //接口请求
    [_forgetPasswordView.phoneTextField resignFirstResponder];
    [_forgetPasswordView.userNewPasswordTextField resignFirstResponder];
    [_forgetPasswordView.verifyTextField resignFirstResponder];

    
    if (![WJUtilityMethod isValidatePhone:_forgetPasswordView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }
    if (!(_forgetPasswordView.userNewPasswordTextField.text.length > 0)) {
        ALERT(@"请输入密码");
        return;
    }
    
    if (!(_forgetPasswordView.verifyTextField.text.length > 0)) {
        ALERT(@"请输入验证码");
        return;
    }
    [self.forgetPasswordManager loadData];
    
}

#pragma mark -event
-(void)handletapPressGesture
{
    [self.forgetPasswordView.phoneTextField resignFirstResponder];
    [self.forgetPasswordView.userNewPasswordTextField resignFirstResponder];
    [self.forgetPasswordView.verifyTextField resignFirstResponder];
}

#pragma mark - Setter And Getter
- (WJForgetPasswordView *)forgetPasswordView
{
    if (_forgetPasswordView== nil) {
        _forgetPasswordView = [[WJForgetPasswordView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_forgetPasswordView.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
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


-(APIForgetPasswordManager *)forgetPasswordManager
{
    if (!_forgetPasswordManager) {
        _forgetPasswordManager = [[APIForgetPasswordManager alloc] init];
        _forgetPasswordManager.delegate = self;
    }
    _forgetPasswordManager.loginName = self.forgetPasswordView.phoneTextField.text;
    _forgetPasswordManager.password = self.forgetPasswordView.userNewPasswordTextField.text;
    _forgetPasswordManager.verifyCode = self.forgetPasswordView.verifyTextField.text;
    return _forgetPasswordManager;
}

@end
