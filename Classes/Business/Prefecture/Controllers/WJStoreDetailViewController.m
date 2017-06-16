//
//  WJStoreDetailViewController.m
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreDetailViewController.h"
#import "WJStoreDetailView.h"
#import "WJStoreModel.h"
@interface WJStoreDetailViewController ()
@property(nonatomic,strong)WJStoreDetailView *storeDetailView;
@end

@implementation WJStoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺详情";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.storeDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action
-(void)tapGesture
{
    NSLog(@"添加图片");
}

-(WJStoreDetailView *)storeDetailView
{
    if (!_storeDetailView) {
        _storeDetailView = [[WJStoreDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        WJStoreModel *model = [[WJStoreModel alloc] init];
        model.storeName = @"数码电子产品专营店";
        model.storeNotice = @"本店售卖电子产品来自正规厂家";
        model.phone = @"13354285319";
        model.region = @"上海";
        model.address = @"吉林省吉林市和平大街21号3单元301";
        
        __weak typeof(self) weakSelf = self;
        
        _storeDetailView.tapStoreNoticeBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            NSLog(@"跳转");
        };
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [_storeDetailView  addGestureRecognizer:tapGesture];
        
        [_storeDetailView configDataWithModel:model];
        
    }
    return _storeDetailView;
}

@end
