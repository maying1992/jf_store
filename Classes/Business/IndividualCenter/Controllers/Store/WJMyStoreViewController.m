//
//  WJMyStoreViewController.m
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMyStoreViewController.h"
#import <UIImageView+WebCache.h>
#import "WJStoreDetailViewController.h"
#import "WJOrderManagerController.h"
#import "WJProductEditViewController.h"
@interface WJMyStoreViewController ()

@end

@implementation WJMyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的店铺";
    self.isHiddenTabBar = YES;
    
    [self setUI];
}

-(void)setUI
{
    
    self.view.backgroundColor = WJColorWhite;
    
    UIImageView *storeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(15), (ALD(84) - ALD(60))/2, ALD(60), ALD(60))];
    storeImageView.contentMode = UIViewContentModeScaleAspectFill;
    storeImageView.layer.cornerRadius = storeImageView.width/2;
    storeImageView.layer.masksToBounds = YES;
    storeImageView.backgroundColor = [UIColor orangeColor];
//    [storeImageView sd_setImageWithURL:nil placeholderImage:nil];
    [self.view addSubview:storeImageView];
    
    UILabel *storeNameL = [[UILabel alloc] initWithFrame:CGRectMake(storeImageView.right + ALD(15), ALD(20), ALD(200), ALD(20))];
    storeNameL.textColor = WJColorDardGray3;
    storeNameL.textAlignment = NSTextAlignmentLeft;
    storeNameL.text = @"数码电子产品专营店";
    storeNameL.font = WJFont15;
    [self.view addSubview:storeNameL];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, storeImageView.bottom + ALD(5), kScreenWidth, 0.5)];
    bottomLine.backgroundColor = WJColorSeparatorLine;
    [self.view addSubview:bottomLine];
    
    
    UIButton *shopInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopInfoButton.frame = CGRectMake((kScreenWidth - ALD(238))/2, bottomLine.bottom + ALD(33), ALD(100), ALD(100));
    shopInfoButton.backgroundColor = WJRandomColor;
    shopInfoButton.layer.masksToBounds = YES;
    shopInfoButton.layer.cornerRadius = shopInfoButton.width/2;
    [shopInfoButton addTarget:self action:@selector(shopInfoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopInfoButton];
    
    
    UIButton *orderManagerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderManagerButton setFrame:CGRectMake(shopInfoButton.right + ALD(38), shopInfoButton.frame.origin.y, ALD(100), ALD(100))];
    orderManagerButton.backgroundColor = WJRandomColor;
    orderManagerButton.layer.masksToBounds = YES;
    orderManagerButton.layer.cornerRadius = shopInfoButton.width/2;
    [orderManagerButton addTarget:self action:@selector(orderManagerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderManagerButton];
    
    UILabel *shopL = [[UILabel alloc] initWithFrame:CGRectMake(shopInfoButton.frame.origin.x + ALD(19), shopInfoButton.bottom + ALD(17), ALD(80), ALD(20))];
    shopL.text = @"店铺信息";
    shopL.textColor = WJColorDardGray3;
    shopL.font = WJFont15;
    [self.view addSubview:shopL];
    
    
    UILabel *orderL = [[UILabel alloc] initWithFrame:CGRectMake(orderManagerButton.frame.origin.x + ALD(19), shopInfoButton.bottom + ALD(17), ALD(80), ALD(20))];
    orderL.text = @"订单管理";
    orderL.textColor = WJColorDardGray3;
    orderL.font = WJFont15;
    [self.view addSubview:orderL];
    
    UIButton *productManagerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [productManagerButton setFrame:CGRectMake(shopInfoButton.frame.origin.x, orderL.bottom + ALD(33), ALD(100), ALD(100))];
    productManagerButton.backgroundColor = WJRandomColor;
    productManagerButton.layer.masksToBounds = YES;
    productManagerButton.layer.cornerRadius = productManagerButton.width/2;
    [productManagerButton addTarget:self action:@selector(productManagerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:productManagerButton];
    
    
    UIButton *addProductButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addProductButton setFrame:CGRectMake(productManagerButton.right + ALD(38), productManagerButton.frame.origin.y, ALD(100), ALD(100))];
    addProductButton.backgroundColor = WJRandomColor;
    addProductButton.layer.masksToBounds = YES;
    addProductButton.layer.cornerRadius = addProductButton.width/2;
    [addProductButton addTarget:self action:@selector(addProductButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addProductButton];
    
    
    
    UILabel *productL = [[UILabel alloc] initWithFrame:CGRectMake(productManagerButton.frame.origin.x + ALD(19), productManagerButton.bottom + ALD(17), ALD(80), ALD(20))];
    productL.text = @"商品管理";
    productL.textColor = WJColorDardGray3;
    productL.font = WJFont15;
    [self.view addSubview:productL];
    
    
    UILabel *addProductL = [[UILabel alloc] initWithFrame:CGRectMake(addProductButton.frame.origin.x + ALD(19), productL.frame.origin.y, ALD(80), ALD(20))];
    addProductL.text = @"添加新商品";
    addProductL.textColor = WJColorDardGray3;
    addProductL.font = WJFont15;
    [self.view addSubview:addProductL];
}

#pragma mark - Action
-(void)shopInfoButtonAction
{
    WJStoreDetailViewController *storeDetailVC = [[WJStoreDetailViewController alloc] init];
    [self.navigationController pushViewController:storeDetailVC animated:YES];
}

-(void)orderManagerButtonAction
{
    WJOrderManagerController *orderManagerVC = [[WJOrderManagerController alloc] init];
    [self.navigationController pushViewController:orderManagerVC animated:YES];
}

-(void)productManagerButtonAction
{
    WJProductEditViewController *productEditVC = [[WJProductEditViewController alloc] init];
    [self.navigationController pushViewController:productEditVC animated:YES];}


-(void)addProductButtonAction
{
    WJProductEditViewController *productEditVC = [[WJProductEditViewController alloc] init];
    [self.navigationController pushViewController:productEditVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
