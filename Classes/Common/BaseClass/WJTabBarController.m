//
//  WJTabBarController.m
//  HuPlus
//
//  Created by XT Xiong on 2016/12/15.
//  Copyright © 2016年 WJIKA. All rights reserved.
//

#import "WJTabBarController.h"
#import "WJHomeViewController.h"
#import "WJCategoryViewController.h"
#import "WJIndividualCenterViewController.h"
#import "WJPrefectureViewController.h"
#import "WJTradingHallViewController.h"
#import "WJLoginController.h"

#define IMAGE_W 22
#define IMAGE_H 22
#define LABEL_W 60
#define LABEL_H 20

@interface WJTabBarController ()
{
    NSArray       *titlesArray;
    NSArray       *normalImageArray;
    NSArray       *lightImageArray;
}
@end

@implementation WJTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titlesArray = @[@"首页",@"分类",@"交易大厅",@"易购专区",@"个人中心"];
    
    normalImageArray = @[@"home_icon_n",@"classification_icon_n",@"trading-hall_icon_n",@"yigou_zone_icon_n",@"personal-center_icon_n"];
    lightImageArray = @[@"home_icon_s",@"classification_icon_s",@"trading-hall_icon_s",@"yigou_zone_icon_s",@"personal-center_icon_s"];

    //自定义tabBar
    [self createCustomTabBarView];
    
    //关联viewController
    [self createViewControllerToTabBarView];

}

//自定义tab
- (void)createCustomTabBarView
{
    //背景
    self.backGroundIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kTabbarHeight, SCREEN_WIDTH, kTabbarHeight)];
//    backGroundIV.image = [UIImage imageNamed:@"tab_backImage"];
    _backGroundIV.backgroundColor = WJColorTabBar;
    _backGroundIV.userInteractionEnabled = YES;
    [self.view addSubview:_backGroundIV];
    
// 标签
    for (int i=0; i<titlesArray.count; i++) {
        
        CGFloat itemButWidth = SCREEN_WIDTH/titlesArray.count;
        
        UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.tag = 10000+i;
        [itemButton addTarget:self action:@selector(clickTabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundIV addSubview:itemButton];
        
        UIImageView *tabImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[normalImageArray objectAtIndex:i]] highlightedImage:[UIImage imageNamed:[lightImageArray objectAtIndex:i]]];
        [itemButton addSubview:tabImageView];
        
        
        itemButton.frame = CGRectMake(i * itemButWidth, 0, itemButWidth, kTabbarHeight);
        tabImageView.frame = CGRectMake((itemButWidth-IMAGE_W)/2, 7, IMAGE_W, IMAGE_H);
        
        UILabel * itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tabImageView.bottom, itemButWidth, LABEL_H)];
        itemLabel.text = [titlesArray objectAtIndex:i];
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.font = WJFont10;
        [itemButton addSubview:itemLabel];
        
        if (i == 0) {
            tabImageView.highlighted = YES;
            itemLabel.textColor = WJColorMainColor;
        }else{
            tabImageView.highlighted = NO;
            itemLabel.textColor = WJColorTabNoSelect;
        }
 
    }
    
}

- (void)changeTabIndex:(NSInteger)index{
    
    UIButton * indexButton = (UIButton *)[_backGroundIV viewWithTag:10000+index];
    [self clickTabBarAction:indexButton];
    self.backGroundIV.hidden = NO;
}

- (void)clickTabBarAction:(id)sender
{
    UIButton * button = (UIButton *)sender;
    
    for (int j = 0; j<titlesArray.count; j++) {
        
        if (button.tag - 10000 == 1) {
            //记录定制前控制器
            [WJGlobalVariable sharedInstance].tabBarIndex = self.selectedIndex;
        }
        //点击的tab变选中
        if (button.tag-10000 == j) {
            ((UIImageView *)button.subviews[0]).highlighted = YES;
            ((UILabel *)button.subviews[1]).textColor = WJColorMainColor;
            
        }else{
            
            UIButton *normalBtn = [_backGroundIV viewWithTag:j+10000];
            ((UIImageView *)normalBtn.subviews[0]).highlighted = NO;
            ((UILabel *)normalBtn.subviews[1]).textColor = WJColorTabNoSelect;
        }
    }
    
    self.selectedIndex = button.tag - 10000;
    [self postControllerWithIndex:self.selectedIndex];
}

//需要通知的控制器
- (void)postControllerWithIndex:(NSInteger)index
{
//    WJNavigationController *nav = (WJNavigationController *)self.selectedViewController;
//    [nav dismissViewControllerAnimated:NO completion:nil];
    
    if (index == 1) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTabCategoryRefresh object:nil];
        
    }else if (index == 2){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTraingHallVCResponse object:nil];

    }else if (index == 4) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTabIndividualCenterRefresh object:nil];
    }
}



//关联viewController
- (void)createViewControllerToTabBarView
{
    //首页
    WJHomeViewController *homeVC = [[WJHomeViewController alloc] init];
    [homeVC hiddenBackBarButtonItem];
    WJNavigationController *homeNav = [[WJNavigationController alloc] initWithRootViewController:homeVC];
    
    //分类
    
    WJCategoryViewController *categoryVC = [[WJCategoryViewController alloc]init];
    WJNavigationController *categoryNav = [[WJNavigationController alloc] initWithRootViewController:categoryVC];
    
    //交易大厅
    WJTradingHallViewController *tradingHallVC = [[WJTradingHallViewController alloc] init];
    WJNavigationController *tradingHallNav = [[WJNavigationController alloc] initWithRootViewController:tradingHallVC];
    
    
    //易购专区
    WJPrefectureViewController *prefectureVC = [[WJPrefectureViewController alloc] init];
    WJNavigationController *prefectureNav = [[WJNavigationController alloc] initWithRootViewController:prefectureVC];
    
    
    //个人中心
    WJIndividualCenterViewController *individualCenterVC = [[WJIndividualCenterViewController alloc] init];
    WJNavigationController *individualCenterNav = [[WJNavigationController alloc] initWithRootViewController:individualCenterVC];
    
    self.viewControllers = @[homeNav,categoryNav,tradingHallNav,prefectureNav,individualCenterNav];


    [self changeTabIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
