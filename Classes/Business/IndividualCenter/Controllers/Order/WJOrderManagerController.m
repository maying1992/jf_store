//
//  WJOrderManagerController.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJOrderManagerController.h"
#import "WJSegmentedView.h"
#import "WJWaitingDeliverController.h"
#import "WJAlreadyDeliverViewController.h"
#import "WJFinishOrderController.h"
#import "WJRefundOrderViewController.h"
#import "WJOrderManagerControllerDelegate.h"
#import "WJOrderModel.h"

@interface WJOrderManagerController ()<WJSegmentedViewDelegate,UIScrollViewDelegate,WJOrderManagerControllerDelegate>
{
    WJSegmentedView                    *segmentedView;
    UIScrollView                       *baseScrollView;
    WJWaitingDeliverController         *waitingDeliverVC;
    WJAlreadyDeliverViewController     *alreadyDeliverVC;
    WJFinishOrderController            *finishOrderVC;
    WJRefundOrderViewController        *refundOrderVC;
}
@property(nonatomic,strong)WJOrderModel  *orderModel;

@end

@implementation WJOrderManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单管理";
    self.isHiddenTabBar = YES;
    
    segmentedView  = [[WJSegmentedView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kOrderTabSegmentHeight) items:@[@"待发货",@"已发货",@"已完成",@"退款"]];
    [segmentedView setBottomLineView:YES];
    
    segmentedView.delegate = self;
    [self.view addSubview:segmentedView];
    
    baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, segmentedView.bottom, kScreenWidth, (kScreenHeight- kNavigationBarHeight - kOrderTabSegmentHeight))];
    baseScrollView.pagingEnabled = YES;
    baseScrollView.bounces = NO;
    baseScrollView.scrollsToTop = NO;
    baseScrollView.delegate = self;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:baseScrollView];
    
    waitingDeliverVC = [[WJWaitingDeliverController alloc] init];
    waitingDeliverVC.view.frame = CGRectMake(0, 0, kScreenWidth, baseScrollView.height);
    waitingDeliverVC.delegate = self;
    [self addChildViewController:waitingDeliverVC];
    [waitingDeliverVC didMoveToParentViewController:self];
    [baseScrollView addSubview:waitingDeliverVC.view];
    
    alreadyDeliverVC = [[WJAlreadyDeliverViewController alloc] init];
    alreadyDeliverVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, baseScrollView.height);
    alreadyDeliverVC.delegate = self;
    [self addChildViewController:alreadyDeliverVC];
    [alreadyDeliverVC didMoveToParentViewController:self];
    [baseScrollView addSubview:alreadyDeliverVC.view];
    
    finishOrderVC = [[WJFinishOrderController alloc] init];
    finishOrderVC.view.frame = CGRectMake(2*kScreenWidth, 0, kScreenWidth, baseScrollView.height);
    finishOrderVC.delegate = self;
    [self addChildViewController:finishOrderVC];
    [finishOrderVC didMoveToParentViewController:self];
    [baseScrollView addSubview:finishOrderVC.view];
    
    refundOrderVC = [[WJRefundOrderViewController alloc] init];
    refundOrderVC.view.frame = CGRectMake(3*kScreenWidth, 0, kScreenWidth, baseScrollView.height);
    refundOrderVC.delegate = self;
    [self addChildViewController:refundOrderVC];
    [refundOrderVC didMoveToParentViewController:self];
    [baseScrollView addSubview:refundOrderVC.view];
    
    
    baseScrollView.contentSize = CGSizeMake(4*kScreenWidth, baseScrollView.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WJSegmentedViewDelegate
-(void)segmentedView:(WJSegmentedView *)segmentedView buttonClick:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
        baseScrollView.contentOffset = CGPointMake(kScreenWidth*index, 0);
    }];
    
    switch (index) {
        case 0:
            [waitingDeliverVC.tableView startHeadRefresh];
            
            break;
        case 1:
            [alreadyDeliverVC.tableView startHeadRefresh];
            
            break;
            
        case 2:
            [finishOrderVC.tableView startHeadRefresh];
            break;
            
        case 3:
            [refundOrderVC.tableView startHeadRefresh];
            break;
            
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint endpoint = scrollView.contentOffset;
    NSInteger index = round(endpoint.x/kScreenWidth);
    segmentedView.selectedSegmentIndex = index;
    
    [self segmentedView:segmentedView buttonClick:index];
}

#pragma mark - WJOrderManagerControllerDelegate
-(void)deliverGoodsWithOrder:(WJOrderModel *)order
{
    NSLog(@"发货");
}

-(void)confirmRefundWithOrder:(WJOrderModel *)order
{
    NSLog(@"确认退款");

}

@end
