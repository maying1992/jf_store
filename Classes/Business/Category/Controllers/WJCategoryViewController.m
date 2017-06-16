//
//  WJCategoryViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJCategoryViewController.h"
#import "WJCategoryView.h"
#import "APICategoryListManager.h"
#import "WJCategoryReformer.h"
#import "WJCategoryModel.h"
#import "APIGoodsListManager.h"
@interface WJCategoryViewController ()<APIManagerCallBackDelegate>
{
    BOOL   isHeaderRefresh;
    BOOL   isFooterRefresh;
}
@property(nonatomic,strong)WJCategoryView         *categoryView;
@property(nonatomic,strong)APICategoryListManager *categoryListManager;
@property(nonatomic,strong)APIGoodsListManager    *goodsListManager;
@property(nonatomic,strong)WJCategoryModel        *categoryModel;

@property(nonatomic,strong)WJCategoryListModel    *selectdCategory;
@end

@implementation WJCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    [self hiddenBackBarButtonItem];
    
    [self.view addSubview:self.categoryView];
    
    [self showLoadingView];
    [self refreshCategory];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCategory) name:kTabCategoryRefresh object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshCategory
{
    [self showLoadingView];
    self.categoryListManager.categoryId = @"";
    [self.categoryListManager loadData];
}

-(void)requestData
{
    [self showLoadingView];
    self.goodsListManager.categoryID = self.selectdCategory.categoryId;
    [self.goodsListManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WJRefreshCollectionView Delegate

- (void)startHeadRefreshToDo:(WJRefreshCollectionView *)collectionView
{
    if (!isHeaderRefresh && !isFooterRefresh) {
        isHeaderRefresh = YES;
        
        if (self.categoryView.collecDataArray.count > 0) {
            [self.categoryView.collecDataArray removeAllObjects];
        }
        [self requestData];
    }
    
}

- (void)startFootRefreshToDo:(WJRefreshCollectionView *)collectionView
{
    if (!isFooterRefresh && !isHeaderRefresh) {
        isFooterRefresh = YES;
        [self requestData];
    }
}

- (void)endGetData:(BOOL)needReloadData{
    
    if (isHeaderRefresh) {
        isHeaderRefresh = NO;
        [self.categoryView.mainCollectionView endHeadRefresh];
    }
    
    if (isFooterRefresh){
        isFooterRefresh = NO;
        [self.categoryView.mainCollectionView endFootFefresh];
    }
    
    if (needReloadData) {
        [self.categoryView.mainCollectionView reloadData];
    }
}

- (void)refreshFooterStatus:(BOOL)status{
    
    if (status) {
        
        [self.categoryView.mainCollectionView hiddenFooter];
        
    } else {
        
        [self.categoryView.mainCollectionView showFooter];
    }
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    [self hiddenLoadingView];

    if ([manager isKindOfClass:[APICategoryListManager class]]) {
        
        self.categoryModel = [manager fetchDataWithReformer:[[WJCategoryReformer alloc] init]];
        
        if (self.categoryView.dataArray.count > 0) {
            [self.categoryView.dataArray removeAllObjects];
        }
        self.categoryView.dataArray = self.categoryModel.categoryList;
        
        [self.categoryView.mainTableView reloadData];
        [self endGetData:YES];
        [self refreshFooterStatus:manager.hadGotAllData];
        
        //请求第一个分类的商品列表接口
        self.selectdCategory = [self.categoryView.dataArray firstObject];
        self.goodsListManager.categoryID = self.selectdCategory.categoryId;
        [self.goodsListManager loadData];
        
    } else {
        
//        self.categoryView.collecDataArray = ;
//        [self.categoryView.mainCollectionView reloadData];
    }
    
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [self hiddenLoadingView];

    ALERT(manager.errorMessage);
}

#pragma mark - Setter And Getter
- (WJCategoryView *)categoryView
{
    if (_categoryView == nil) {
        _categoryView = [[WJCategoryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight)];
        _categoryView.backgroundColor = WJColorViewBg;
        __block typeof(self) blockSelf = self;

        
        _categoryView.selectCategoryBlock = ^(WJCategoryListModel *categoryModel) {
            
            blockSelf.selectdCategory = categoryModel;
            [blockSelf.categoryView.mainTableView reloadData];

            //请求商品列表接口
            self.goodsListManager.categoryID = categoryModel.categoryId;
            [self.goodsListManager loadData];
            
        };
        
        _categoryView.productTapBlock = ^(WJCategoryProductModel *productModel) {

            //跳转商品详情
        };
        
        _categoryView.selectBannerBlock = ^(NSInteger index) {
            
            NSLog(@"点击第%ld个轮播",index);
        };
    }
    return _categoryView;
}

-(APICategoryListManager *)categoryListManager
{
    if (!_categoryListManager) {
        _categoryListManager = [[APICategoryListManager alloc] init];
        _categoryListManager.delegate = self;
    }
    return _categoryListManager;
}

-(APIGoodsListManager *)goodsListManager
{
    if (!_goodsListManager) {
        _goodsListManager = [[APIGoodsListManager alloc] init];
        _goodsListManager.delegate = self;
    }
    return _goodsListManager;
}

@end
