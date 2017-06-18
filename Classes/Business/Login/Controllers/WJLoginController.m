//
//  WJLoginController.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLoginController.h"
#import "WJLoginView.h"
#import "WJForgetPasswordViewController.h"
#import "WJRegisterController.h"
#import "APILoginManager.h"
#import "AppDelegate.h"
#import "WJBindInformationViewController.h"
@interface WJLoginController ()<APIManagerCallBackDelegate>

@property(nonatomic,strong) WJLoginView                  *loginView;
@property(nonatomic,strong) APILoginManager              *loginManager;

@end

@implementation WJLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.isPresentVC = YES;
    [self hiddenBackBarButtonItem];
    [self removeScreenEdgePanGesture];
    
    [self navigationSetUp];
    [self.view addSubview:self.loginView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.loginView  addGestureRecognizer:tapGesture];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary *userDic = [manager fetchDataWithReformer:nil];

    if (userDic) {
        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:KUserInformation];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary  *userInformation = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation]; 
        NSLog(@"%@",userInformation);
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self successGoOut];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginRefresh" object:nil];
    }

}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

- (void)successGoOut
{
    switch (self.loginFrom) {
        case LoginFromTradingHallView:
            [[NSNotificationCenter defaultCenter] postNotificationName:kTraingHallVCResponse object:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark - Cusitom Function

- (void)navigationSetUp
{
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.titleLabel setFont:WJFont14];
    [cancelButton setFrame:CGRectMake(0, 0, 40, 30)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton.titleLabel setFont:WJFont14];
    [registerButton setFrame:CGRectMake(0, 0, 40, 30)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:registerButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Button Action
-(void)cancelAction
{
    [_loginView.phoneTextField resignFirstResponder];
    [_loginView.passwordTextField resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if (self.loginFrom == LoginFromTradingHallView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTraingHallVCGoOutVC object:nil];
    }

}
-(void)registerAction
{
    WJRegisterController *registerVC = [[WJRegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:NO];
}

- (void)loginAction
{
    [_loginView.phoneTextField resignFirstResponder];
    [_loginView.passwordTextField resignFirstResponder];
    
    if (![WJUtilityMethod isValidatePhone:_loginView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }
    if (!(_loginView.passwordTextField.text.length > 0)) {
        ALERT(@"请输入密码");
        return;
    }
    
    [self.loginManager loadData];
}

#pragma mark -event
-(void)handletapPressGesture
{
    [self.loginView.phoneTextField resignFirstResponder];
    [self.loginView.passwordTextField resignFirstResponder];
}

-(void)forgetPasswordAction
{
    WJForgetPasswordViewController *forgetPasswordVC = [[WJForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:NO];
}


#pragma mark - Setter And Getter
- (WJLoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[WJLoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_loginView.forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        [_loginView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginView;
}

- (APILoginManager *)loginManager
{
    if (nil == _loginManager) {
        _loginManager = [[APILoginManager alloc] init];
        _loginManager.delegate = self;
    }
    _loginManager.loginName = self.loginView.phoneTextField.text;
    _loginManager.password = self.loginView.passwordTextField.text;
    return _loginManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
