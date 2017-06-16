//
//  WJLotteryDrawDetailViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/31.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJLotteryDrawDetailViewController.h"
#import "SDCycleScrollView.h"

@interface WJLotteryDrawDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic ,strong) UITableView                     * mainTableView;
@property(nonatomic, strong) SDCycleScrollView               * cycleScrollView;

@end

@implementation WJLotteryDrawDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.mainTableView];
    [self UISetUp];
}

- (void)backBarButton:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //轮播
        return kScreenWidth * 0.6;
    }else{
        return 120;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            [cell.contentView addSubview:self.cycleScrollView];
        }
        return cell;
//    }
//    else{
//        WJGoodsDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WJGoodsDetailTableViewCell"];
//        if (cell == nil) {
//            cell = [[WJGoodsDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WJGoodsDetailTableViewCell"];
//        }
//        return cell;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Setter && Getter

- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        NSArray *imageNames = @[[UIImage imageNamed:@"new_x1_19201200_01"],[UIImage imageNamed:@"new_x1_19201200_02"],[UIImage imageNamed:@"new_x1_19201200_03"],[UIImage imageNamed:@"new_x1_19201200_04"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.6) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        _cycleScrollView.autoScrollTimeInterval = 2;
    }
    return _cycleScrollView;
}

- (void)UISetUp
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 26, 32, 32);
    [leftBtn setImage:[UIImage imageNamed:@"details-page_nav_btn_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    
    UIButton * outputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    outputButton.translatesAutoresizingMaskIntoConstraints = NO;
    [outputButton setTitle:@"立即抽奖" forState:UIControlStateNormal];
    outputButton.titleLabel.font = WJFont16;
    [outputButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [outputButton setBackgroundColor:WJColorMainColor];
    [outputButton addTarget:self action:@selector(outputButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outputButton];
    [self.view addConstraints:[outputButton constraintsSize:CGSizeMake(kScreenWidth, kTabbarHeight)]];
    [self.view addConstraints:[outputButton constraintsBottomInContainer:0]];

}

- (UITableView *)mainTableView{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake( 0, - kStatusBarHeight, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - kTabbarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}


@end
