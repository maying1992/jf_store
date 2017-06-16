//
//  WJApplyStoreViewController.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJApplyStoreViewController.h"
#import "WJStoreProtocolViewController.h"
@interface WJApplyStoreViewController ()

@end

@implementation WJApplyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请店铺";
    self.isHiddenTabBar = YES;
    [self setUI];
}

-(void)setUI
{
    UIImage *iconImg = [UIImage imageNamed:@"store_icon"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - iconImg.size.width)/2, ALD(75), iconImg.size.width, iconImg.size.height)];
    iconImageView.image = iconImg;
    
    UIButton *enterpriseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enterpriseButton.frame = CGRectMake((kScreenWidth - ALD(320))/2, kScreenHeight - kNavBarAndStatBarHeight - ALD(205), ALD(150), ALD(44));
    [enterpriseButton setTitle:@"企业店铺"
                      forState:UIControlStateNormal];
    [enterpriseButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    enterpriseButton.titleLabel.font = WJFont15;
    enterpriseButton.layer.cornerRadius = ALD(22);
    enterpriseButton.layer.borderColor = WJColorMainColor.CGColor;
    enterpriseButton.layer.borderWidth = 1;
    [enterpriseButton addTarget:self action:@selector(enterpriseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *merchantButton = [UIButton buttonWithType:UIButtonTypeCustom];
    merchantButton.frame = CGRectMake(enterpriseButton.right + ALD(20), enterpriseButton.frame.origin.y, ALD(150), ALD(44));
    [merchantButton setTitle:@"商家店铺"
                    forState:UIControlStateNormal];
    [merchantButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    merchantButton.titleLabel.font = WJFont15;
    merchantButton.layer.cornerRadius = ALD(22);
    merchantButton.layer.borderColor = WJColorMainColor.CGColor;
    merchantButton.layer.borderWidth = 1;
    [merchantButton addTarget:self action:@selector(merchantButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *personalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    personalButton.frame = CGRectMake(enterpriseButton.frame.origin.x, enterpriseButton.bottom + ALD(15), ALD(150), ALD(44));
    [personalButton setTitle:@"个人店铺"
                    forState:UIControlStateNormal];
    [personalButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    personalButton.titleLabel.font = WJFont15;
    personalButton.layer.cornerRadius = ALD(22);
    personalButton.layer.borderColor = WJColorMainColor.CGColor;
    personalButton.layer.borderWidth = 1;
    [personalButton addTarget:self action:@selector(personalButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *entityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    entityButton.frame = CGRectMake(merchantButton.frame.origin.x, merchantButton.bottom + ALD(15), ALD(150), ALD(44));
    [entityButton setTitle:@"实体店铺"
                  forState:UIControlStateNormal];
    [entityButton setTitleColor:WJColorDardGray3 forState:UIControlStateNormal];
    entityButton.titleLabel.font = WJFont15;
    entityButton.layer.cornerRadius = ALD(22);
    entityButton.layer.borderColor = WJColorMainColor.CGColor;
    entityButton.layer.borderWidth = 1;
    [entityButton addTarget:self action:@selector(entityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:iconImageView];
    [self.view addSubview:enterpriseButton];
    [self.view addSubview:merchantButton];
    [self.view addSubview:personalButton];
    [self.view addSubview:entityButton];
}

#pragma mark - Action

-(void)enterpriseButtonAction
{
    WJStoreProtocolViewController *storeProtocolVC = [[WJStoreProtocolViewController alloc] init];
    storeProtocolVC.applyFrom = ApplyFromEnterpriseStore;
    [self.navigationController pushViewController:storeProtocolVC animated:YES];
}

-(void)merchantButtonAction
{
    WJStoreProtocolViewController *storeProtocolVC = [[WJStoreProtocolViewController alloc] init];
    storeProtocolVC.applyFrom = ApplyFromMerchantStore;
    [self.navigationController pushViewController:storeProtocolVC animated:YES];
}


-(void)personalButtonAction
{
    WJStoreProtocolViewController *storeProtocolVC = [[WJStoreProtocolViewController alloc] init];
    storeProtocolVC.applyFrom = ApplyFromPersonalStore;
    [self.navigationController pushViewController:storeProtocolVC animated:YES];
}

-(void)entityButtonAction
{
    WJStoreProtocolViewController *storeProtocolVC = [[WJStoreProtocolViewController alloc] init];
    storeProtocolVC.applyFrom = ApplyFromEntityStore;
    [self.navigationController pushViewController:storeProtocolVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
