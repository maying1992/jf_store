//
//  WJSettingTradePasswordViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSettingTradePasswordViewController.h"
#import "WJIntegralTradePasswordViewController.h"
@interface WJSettingTradePasswordViewController ()
{
    UITextField *passwordTF;
}
@end

@implementation WJSettingTradePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置交易密码";
    self.isHiddenTabBar = YES;
    [self setUI];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
}

-(void)setUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(44))];
    bgView.backgroundColor = WJColorWhite;
    [self.view addSubview:bgView];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(50), ALD(44))];
    nameL.text = @"密码";
    nameL.textColor = WJColorDardGray3;
    nameL.font = WJFont15;
    [bgView addSubview:nameL];
    
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(nameL.right + ALD(12), 0, kScreenWidth - ALD(50) - ALD(36), ALD(44))];
    passwordTF.textColor = WJColorDardGray3;
    passwordTF.textAlignment = NSTextAlignmentLeft;
    passwordTF.font = WJFont15;
    passwordTF.placeholder = @"请输入登录密码";
    [bgView addSubview:passwordTF];
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    nextButton.backgroundColor = WJColorMainColor;
    nextButton.layer.cornerRadius = 4;
    nextButton.layer.masksToBounds = YES;
    nextButton.titleLabel.font = WJFont14;
    
    [nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];

}

#pragma mark - Action
-(void)nextButtonAction
{
    if (!(passwordTF.text.length > 0)) {
        ALERT(@"请输入登录密码");
        return;
    }
    WJIntegralTradePasswordViewController *integralTradePasswordVC = [[WJIntegralTradePasswordViewController alloc] init];
    [self.navigationController pushViewController:integralTradePasswordVC animated:YES];
}

#pragma mark - event
-(void)handletapPressGesture
{
    [passwordTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
