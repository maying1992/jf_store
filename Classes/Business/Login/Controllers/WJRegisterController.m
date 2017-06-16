//
//  WJRegisterController.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJRegisterController.h"
#import "WJRegisterView.h"
#import "WJSystemAlertView.h"
#import "WJBindInformationViewController.h"
#import "APIGetUserCodeManager.h"
#import "APIRecommenderInfoManager.h"
#import "APIRegisterManager.h"
#import "APIVerifyCodeManager.h"

@interface WJRegisterController ()<WJSystemAlertViewDelegate,APIManagerCallBackDelegate>

@property(nonatomic,strong)WJRegisterView            *registerView;
@property(nonatomic,strong)APIGetUserCodeManager     *getUserCodeManager;
@property(nonatomic,strong)APIRecommenderInfoManager *recommenderInfoManager;
@property(nonatomic,strong)APIRegisterManager        *registerManager;
@property(nonatomic,strong)APIVerifyCodeManager      *verifyCodeManager;

@end

@implementation WJRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";

    [self.view addSubview:self.registerView];
    
    [self.getUserCodeManager loadData];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.registerView  addGestureRecognizer:tapGesture];
    
//    WJBindInformationViewController *bindInformationVC = [[WJBindInformationViewController alloc] init];
//    [self.navigationController pushViewController:bindInformationVC animated:NO whetherJump:YES];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIGetUserCodeManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];

        self.registerView.userNumberTextField.text = dic[@"userCode"];
        
    } else if ([manager isKindOfClass:[APIRecommenderInfoManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        NSString *message = [NSString stringWithFormat:@"推荐人编码  %@\n姓名  %@\n联系方式  %@",dic[@"userCode"],dic[@"userName"],dic[@"contact"]];
        
        WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"推荐人信息" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
        [alertView showIn];
        
    } else if ([manager isKindOfClass:[APIRegisterManager class]]) {
        
        WJBindInformationViewController *bindInformationVC = [[WJBindInformationViewController alloc] init];
        [self.navigationController pushViewController:bindInformationVC animated:NO whetherJump:YES];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getVerifyAction
{
    //验证手机号
    if([WJUtilityMethod isValidatePhone:self.registerView.phoneTextField.text]) {
        //验证码请求
        [self.verifyCodeManager loadData];
        [self.registerView startTimer];
        self.registerView.verifyTextField.text = @"";
        [self.registerView.verifyTextField becomeFirstResponder];
        
    } else {
        
        if(self.registerView.phoneTextField.text.length <= 0){
            ALERT(@"请输入正确手机号");
        } else {
            ALERT(@"请输入正确格式的验证码");
        }
    }
    
}

-(void)registerAction
{
    [_registerView.phoneTextField resignFirstResponder];
    [_registerView.passwordTextField resignFirstResponder];
    [_registerView.verifyTextField resignFirstResponder];
    [_registerView.recommendedTextField resignFirstResponder];
    
    if (![WJUtilityMethod isValidatePhone:_registerView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }
    if (!(_registerView.passwordTextField.text.length > 0)) {
        ALERT(@"请输入密码");
        return;
    }
    
    if (!(_registerView.verifyTextField.text.length > 0)) {
        ALERT(@"请输入验证码");
        return;
    }
    [self.recommenderInfoManager loadData];

}

-(void)changeUserNumberAction
{
    [self.getUserCodeManager loadData];
}

#pragma mark -event
-(void)handletapPressGesture
{
    [self.registerView.phoneTextField resignFirstResponder];
    [self.registerView.passwordTextField resignFirstResponder];
    [self.registerView.verifyTextField resignFirstResponder];
    [self.registerView.recommendedTextField resignFirstResponder];
}


#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self.registerManager loadData];

    }
}

#pragma mark - Setter And Getter
- (WJRegisterView *)registerView
{
    if (_registerView== nil) {
        _registerView = [[WJRegisterView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_registerView.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.getVerifyCodeBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
        [_registerView.changeUserNumberBtn addTarget:self action:@selector(changeUserNumberAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registerView;
}


-(APIGetUserCodeManager *)getUserCodeManager
{
    if (!_getUserCodeManager) {
        _getUserCodeManager = [[APIGetUserCodeManager alloc] init];
        _getUserCodeManager.delegate = self;
    }
    return _getUserCodeManager;
}

-(APIRecommenderInfoManager *)recommenderInfoManager
{
    if (!_recommenderInfoManager) {
        _recommenderInfoManager = [[APIRecommenderInfoManager alloc] init];
        _recommenderInfoManager.delegate = self;
    }
    _recommenderInfoManager.recommenderCode = self.registerView.recommendedTextField.text;
    _recommenderInfoManager.loginName = self.registerView.phoneTextField.text;
    _recommenderInfoManager.verifiationCode = self.registerView.verifyTextField.text;

    return _recommenderInfoManager;
}

-(APIRegisterManager *)registerManager
{
    if (!_registerManager) {
        _registerManager = [[APIRegisterManager alloc] init];
        _registerManager.delegate = self;
    }
    _registerManager.userCode = self.registerView.userNumberTextField.text;
    _registerManager.loginName = self.registerView.phoneTextField.text;
    _registerManager.password = self.registerView.passwordTextField.text;
    _registerManager.verifiationCode = self.registerView.verifyTextField.text;
    _registerManager.recommenderCode = self.registerView.recommendedTextField.text;
    return _registerManager;
}

-(APIVerifyCodeManager *)verifyCodeManager
{
    if (!_verifyCodeManager) {
        _verifyCodeManager = [[APIVerifyCodeManager alloc] init];
        _verifyCodeManager.delegate = self;
    }
    _verifyCodeManager.loginName = self.registerView.phoneTextField.text;
    return _verifyCodeManager;
}

@end
