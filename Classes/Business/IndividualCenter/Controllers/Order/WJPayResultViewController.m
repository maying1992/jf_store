//
//  WJPayResultViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/26.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPayResultViewController.h"
#import "AppDelegate.h"
@interface WJPayResultViewController ()

@end

@implementation WJPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WJColorViewBg;
    self.title  = @"支付结果";
    self.isHiddenTabBar = YES;
    [self setUI];
}

-(void)setUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(150))];
    bgView.backgroundColor = WJColorWhite;
    [self.view addSubview:bgView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.width - ALD(30))/2, ALD(20), ALD(30), ALD(30))];
    imageView.backgroundColor = [UIColor clearColor];
    [bgView addSubview:imageView];
    
    UILabel *describeL = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - ALD(80))/2, imageView.bottom + ALD(10), ALD(80), ALD(20))];
    describeL.text = @"支付成功";
    describeL.textAlignment = NSTextAlignmentCenter;
    describeL.font = WJFont15;
    describeL.backgroundColor = [UIColor clearColor];
    [bgView addSubview:describeL];
    
    UILabel *integralL = [[UILabel alloc] initWithFrame:CGRectMake(0, describeL.bottom + ALD(12), kScreenWidth, ALD(20))];
    integralL.text = @"2345积分";
    integralL.textAlignment = NSTextAlignmentCenter;
    integralL.font = WJFont20;
    integralL.textColor = WJColorDardGray3;
    integralL.backgroundColor = [UIColor clearColor];
    [bgView addSubview:integralL];
    
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0,bgView.bottom + ALD(10), kScreenWidth, ALD(140))];
    middleView.backgroundColor = WJColorWhite;
    [self.view addSubview:middleView];
    
    
    UILabel *orderL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(14), ALD(100), ALD(20))];
    orderL.text = @"订单编号";
    orderL.textColor = WJColorDardGray3;
    orderL.font = WJFont15;
    [middleView addSubview:orderL];
    
    UILabel *orderNoL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), orderL.origin.y, ALD(150), ALD(20))];
    orderNoL.textColor = WJColorDardGray3;
    orderNoL.font = WJFont15;
    orderNoL.text = @"728992827762668";
    orderNoL.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:orderNoL];
    
    
    UILabel *productL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), orderL.bottom + ALD(14), ALD(100), ALD(20))];
    productL.text = @"商品名称";
    productL.textColor = WJColorDardGray3;
    productL.font = WJFont15;
    [middleView addSubview:productL];
    
    UILabel *productNameL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), productL.origin.y, ALD(150), ALD(20))];
    productNameL.textColor = WJColorDardGray3;
    productNameL.font = WJFont15;
    productNameL.text = @"热水壶";
    productNameL.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:productNameL];
    
    UILabel *paymentL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), productL.bottom + ALD(14), ALD(100), ALD(20))];
    paymentL.text = @"支付方式";
    paymentL.textColor = WJColorDardGray3;
    paymentL.font = WJFont15;
    [middleView addSubview:paymentL];
    
    UILabel *payTypeL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), paymentL.origin.y, ALD(150), ALD(20))];
    payTypeL.textColor = WJColorDardGray3;
    payTypeL.font = WJFont15;
    payTypeL.text = @"支付宝";
    payTypeL.textAlignment = NSTextAlignmentRight;
    [middleView addSubview:payTypeL];
    
    UIButton *orderDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderDetailButton.frame = CGRectMake(kScreenWidth/2 - ALD(15) - ALD(100), middleView.bottom+ALD(45), ALD(100), ALD(30));
    [orderDetailButton setTitle:@"订单详情" forState:UIControlStateNormal];
    [orderDetailButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    orderDetailButton.layer.cornerRadius = 4;
    orderDetailButton.layer.borderColor = WJColorDardGray9.CGColor;
    orderDetailButton.layer.borderWidth = 0.5;
    orderDetailButton.titleLabel.font = WJFont14;
    [orderDetailButton addTarget:self action:@selector(orderDetailButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderDetailButton];
    
    UIButton *backHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backHomeButton.frame = CGRectMake(orderDetailButton.right + ALD(30), middleView.bottom+ALD(45), ALD(100), ALD(30));
    [backHomeButton setTitle:@"主页" forState:UIControlStateNormal];
    [backHomeButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    backHomeButton.layer.cornerRadius = 4;
    backHomeButton.layer.borderColor = WJColorDardGray9.CGColor;
    backHomeButton.layer.borderWidth = 0.5;
    backHomeButton.hidden = YES;
    backHomeButton.titleLabel.font = WJFont14;
    [backHomeButton addTarget:self action:@selector(backHomeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backHomeButton];
    
    UIButton *restartPayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    restartPayButton.frame = CGRectMake(orderDetailButton.right + ALD(30), middleView.bottom+ALD(45), ALD(100), ALD(30));
    [restartPayButton setTitle:@"重新支付" forState:UIControlStateNormal];
    [restartPayButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    restartPayButton.layer.cornerRadius = 4;
    restartPayButton.layer.borderColor = WJColorDardGray9.CGColor;
    restartPayButton.layer.borderWidth = 0.5;
    restartPayButton.titleLabel.font = WJFont14;
    restartPayButton.hidden = YES;
    [restartPayButton addTarget:self action:@selector(restartPayButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restartPayButton];
    
    if (self.isPaySuccess) {
        backHomeButton.hidden = NO;
        imageView.image = [UIImage imageNamed:@"payment_success_icon"];
    } else {
        restartPayButton.hidden = NO;
        imageView.image = [UIImage imageNamed:@"payment_failure_icon"];
    }
}

#pragma mark - Action
-(void)orderDetailButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)backHomeButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.tabBarController.selectedIndex != 0) {
        
        [appDelegate.tabBarController changeTabIndex:0];
    }
}


-(void)restartPayButtonAction
{
    NSLog(@"重新支付");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
