//
//  WJPasswordSettingViewController.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPasswordSettingViewController.h"
#import "WJIndividualInformationController.h"
#import "WJHomeViewController.h"
#import "AppDelegate.h"
#import "APISetIntegralPasswordManager.h"
#import "WJForgetPasswordViewController.h"
#define IVTag  200

@interface WJPasswordSettingViewController ()<UITextFieldDelegate,APIManagerCallBackDelegate>
{
    UIView         *enterBg;
    
    NSInteger      selectedIvTag;
    NSString       *enterPassword;
    
    NSMutableArray *enterPsdViews;
    
    UITextField    *tf;

    NSMutableArray *psdArray;
}
@property(nonatomic,strong)APISetIntegralPasswordManager *setIntegralPasswordManager;
@end

@implementation WJPasswordSettingViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self removeScreenEdgePanGesture];
    
    psdArray = [NSMutableArray arrayWithCapacity:0];
    
    UILabel *infoL = [[UILabel alloc] initWithFrame:CGRectMake(10, ALD(55), kScreenWidth-20, ALD(36))];
    infoL.textColor = WJColorDardGray3;
    infoL.font = WJFont15;
    infoL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:infoL];
    
    
    enterBg = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), ALD(95), kScreenWidth - ALD(30), ALD(45))];
    [enterBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKeyBoard)]];
    enterBg.layer.cornerRadius = 3;
    enterBg.clipsToBounds = YES;
    [self.view addSubview:enterBg];
    
    
    enterPsdViews = [NSMutableArray array];
    int ivWidth = enterBg.width/6;
    for (int i = 0; i < 6; i++) {
        UIView *iconBg = [[UIView alloc] initWithFrame:CGRectMake(ivWidth*i, 0, ivWidth-1, enterBg.height)];
        iconBg.backgroundColor = WJColorWhite;
        iconBg.layer.shadowColor = WJColorViewBg.CGColor;
        iconBg.layer.shadowOffset = CGSizeMake(1, 0);
        iconBg.layer.shadowOpacity = 0;
        iconBg.layer.shadowRadius = 0.5;
        [enterBg addSubview:iconBg];
        
        UIImage *normal = [WJUtilityMethod imageFromColor:[UIColor whiteColor] Width:20 Height:20];
        
        UIImage *hight = [WJUtilityMethod imageFromColor:WJColorMainColor Width:20 Height:20];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:normal highlightedImage:hight];
        iv.frame = CGRectMake(0, 0, 20, 20);
        iv.center = CGPointMake(iconBg.width/2, iconBg.height/2);
        iv.layer.cornerRadius = 10;
        iv.layer.masksToBounds = YES;
        iv.tag = IVTag+i;
        [iconBg addSubview:iv];
        [enterPsdViews addObject:iv];
    }
    selectedIvTag = IVTag;
    CGRect frame = enterBg.frame;
    frame.size.width = ivWidth*6-1;
    enterBg.frame = frame;
    
    enterBg.centerX = self.view.centerX;
    
    NSString *title = nil;
    switch (self.passwordType) {
        case PasswordTypeNew:{
            title = @"设置新交易密码";
            infoL.text = @"设置积分交易密码";
        }
            break;
        case PasswordTypeConfirm:{
            title = @"积分交易密码";
            infoL.text = @"确认积分交易密码";
        }
            break;
        case PasswordTypeReset:{
            
            title = @"重置交易密码";
            infoL.text = @"输入积分交易密码";
        }
            break;
            
        default:
            break;
    }
    self.title = title;
    
    
    if (self.passwordType == PasswordTypeReset) {
        
        UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forgetPasswordBtn.frame = CGRectMake(kScreenWidth - ALD(12) - ALD(60), enterBg.bottom + ALD(20), ALD(60), ALD(20));
        [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetPasswordBtn .titleLabel setFont:WJFont12];
        [forgetPasswordBtn setTitleColor:WJColorDardGray9 forState:UIControlStateNormal];
        [forgetPasswordBtn addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgetPasswordBtn];
    }
    
    tf = [[UITextField alloc] initWithFrame:CGRectMake(-100, 0, 103, 20)];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.delegate = self;
    tf.alpha = 0;
    [self.view addSubview:tf];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showKeyBoard];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [tf resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    //输入框重置
    [super viewWillAppear:animated];
    
    if (self.passwordSettingFrom == PasswordSettingFromBinding) {
        
        [self navigationSetUp];
        
    } else {
        
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self changeInputState];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    ALERT(@"支付密码设置成功");
    WJIndividualInformationController *individualInformationVC = [[WJIndividualInformationController alloc] init];
    individualInformationVC.informationFrom = FromBindInformation;
    [self.navigationController pushViewController:individualInformationVC animated:YES];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

- (void)changeInputState
{
    for (UIImageView *iv in enterPsdViews) {
        iv.highlighted = NO;
    }
    [psdArray removeAllObjects];
    self.canInputPassword = YES;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.canInputPassword) {
        if (string.length == 0) {
            if (selectedIvTag > IVTag) {
                selectedIvTag -= 1;
                UIImageView *iv = (UIImageView *)[self.view viewWithTag:selectedIvTag];
                iv.highlighted = NO;
                [psdArray removeLastObject];
            }
        }else{
            if (selectedIvTag < 206) {
                UIImageView *iv = (UIImageView *)[self.view viewWithTag:selectedIvTag];
                iv.highlighted = YES;
                selectedIvTag += 1;
                [psdArray addObject:string];
                
                if (selectedIvTag == 206) {
                    [self performSelector:@selector(startSureBtnAction) withObject:nil afterDelay:0.3];
                }
            }
        }
    }
    
    return self.canInputPassword;
}

- (void)cleanPsdView{
    for (UIImageView *iv in enterPsdViews) {
        iv.highlighted = NO;
    }
    
    selectedIvTag = IVTag;
}

- (void)startSureBtnAction{
    self.canInputPassword = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sureBtnAction];
    });
}

- (void)sureBtnAction{
    
    enterPassword = [psdArray componentsJoinedByString:@""];
    
    if (psdArray.count == 0){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码位数不能为空"];
        self.canInputPassword = YES;
        return;
    }
    if (psdArray.count < 6) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码位数为6位"];
        self.canInputPassword = YES;
        return;
    }
    
    
    if (self.passwordType == PasswordTypeConfirm && ![enterPassword isEqualToString:self.lastPassword]) {
        
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"两次密码输入不正确！"];
        [psdArray removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
    }
    
    WJPasswordSettingViewController *passwordSettingVC = nil;
    
    if  (self.passwordType == PasswordTypeNew) {
        
        passwordSettingVC = [[WJPasswordSettingViewController alloc] init];
        passwordSettingVC.passwordType = PasswordTypeConfirm;
        passwordSettingVC.lastPassword = enterPassword;
        passwordSettingVC.passwordSettingFrom = self.passwordSettingFrom;
        
        [self.navigationController pushViewController:passwordSettingVC animated:YES];

        [self cleanPsdView];
        
    } else if (self.passwordType == PasswordTypeConfirm) {
        
        self.setIntegralPasswordManager.password = enterPassword;
        self.setIntegralPasswordManager.useId = USER_ID;
        [self.setIntegralPasswordManager loadData];
        [self cleanPsdView];
        
    } else if (self.passwordType == PasswordTypeReset) {
        
    
        //请求接口
        
    }

    
}

-(void)forgetPasswordAction
{
    WJForgetPasswordViewController *forgetPasswordVC = [[WJForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}

#pragma mark - Cusitom Function

- (void)navigationSetUp
{
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton.titleLabel setFont:WJFont14];
    [skipButton setFrame:CGRectMake(0, 0, 40, 30)];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:skipButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Action
-(void)skipButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.tabBarController.selectedIndex != 0) {
        
        [appDelegate.tabBarController changeTabIndex:0];
    }
}

- (void)showKeyBoard{
    [tf becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(APISetIntegralPasswordManager *)setIntegralPasswordManager
{
    if (!_setIntegralPasswordManager) {
        _setIntegralPasswordManager = [[APISetIntegralPasswordManager alloc] init];
        _setIntegralPasswordManager.delegate = self;
    }
    return _setIntegralPasswordManager;
}

@end
