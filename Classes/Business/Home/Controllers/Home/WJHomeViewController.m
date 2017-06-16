//
//  WJHomeViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/2.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJRefreshCollectionView.h"
#import "SDCycleScrollView.h"
#import "WJCategoryCollectionViewCell.h"
#import "WJHomeLoveCollectionViewCell.h"
#import "WJGoodsCollectionViewCell.h"
#import "WJAddressButton.h"
#import "AppDelegate.h"
#import "WJFloatWindowView.h"
#import "APIHomeManager.h"
#import "WJHomeReformer.h"
#import "WJBannerModel.h"

#import "WJScanCodeViewController.h"
#import "WJAddressViewController.h"
#import "WJSearchViewController.h"
#import "WJGoodsListViewController.h"
#import "WJGoodsPlateViewController.h"
#import "WJLotteryDrawViewController.h"
#import "WJGoodsDetailViewController.h"

#import "WJShare.h"

#define kDefaultIdentifier              @"kDefaultIdentifier"
#define kCategoryIdentifier             @"kCategoryIdentifier"
#define kHomeLoveIdentifier             @"kHomeLoveIdentifier"
#define kGoodsIdentifier                @"kGoodsIdentifier"

@interface WJHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate,UISearchBarDelegate,APIManagerCallBackDelegate>

@property(nonatomic, strong) WJRefreshCollectionView   * collectionView;
@property(nonatomic, strong) SDCycleScrollView         * cycleScrollView;
@property(nonatomic, strong) UISearchBar               * searchBar;
@property(nonatomic, strong) APIHomeManager            * homeManager;
@property(nonatomic, strong) NSMutableArray            * goodsListArray;
@property(nonatomic, strong) NSMutableArray            * channelListArray;
@property(nonatomic, strong) NSMutableArray            * picListArray;



@end

@implementation WJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self navigationSetup];
    [self.view addSubview:self.collectionView];
    [self.homeManager loadData];
//    [self addAdvertisementView];
}

- (void)addAdvertisementView
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    WJFloatWindowView *floatWindowView = [[WJFloatWindowView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [floatWindowView.cancelButton addTarget:self action:@selector(cancelButton) forControlEvents:UIControlEventTouchUpInside];
    floatWindowView.advertisementIV.userInteractionEnabled = YES;
    UITapGestureRecognizer * advertisemenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(advertisementAction)];
    [floatWindowView.advertisementIV addGestureRecognizer:advertisemenTap];
    [appDelegate.window addSubview:floatWindowView];
}


- (void)cancelButton
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    for (UIView * subView in appDelegate.window.subviews) {
        if ([subView isKindOfClass:[WJFloatWindowView class]]) {
            [subView removeFromSuperview];
        }
    }
}

- (void)advertisementAction
{
    
}


- (void)navigationSetup
{
    WJAddressButton * addressButton = [[WJAddressButton alloc]init];
    [addressButton setTitle:@"北京" forState:UIControlStateNormal];
    [addressButton addTarget:self action:@selector(addressButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addressButton];
    
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.frame = CGRectMake(0, 0, 21, 21);
    [scanButton setImage:[UIImage imageNamed:@"Home_saoyisao_white"] forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanButton];
    
    self.navigationItem.titleView = self.searchBar;
}
  
#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary  * dic = [manager fetchDataWithReformer:[WJHomeReformer new]];
    self.goodsListArray = dic[@"goods_list"];
    self.channelListArray = dic[@"channel_list"];
    self.picListArray = dic[@"pic_list"];
    [self.collectionView reloadData];
    
    NSMutableArray * picUrlArray = [NSMutableArray array];
    for (int i = 0; i< self.picListArray.count; i++) {
        WJBannerModel * model = self.picListArray[i];
        [picUrlArray addObject:model.picUrl];
    }
    _cycleScrollView.imageURLStringsGroup = picUrlArray;;

}



  
- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
}



#pragma mark = Button Action
- (void)addressButton
{
    WJAddressViewController *addressVC = [[WJAddressViewController alloc]init];
    WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:addressVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)scanAction
{
//    WJScanCodeViewController *sacanVC = [[WJScanCodeViewController alloc]init];
//    [self.navigationController pushViewController:sacanVC animated:YES];
    
//    // 显示控制器
//    [self presentViewController:vc animated:YES completion:nil];
    
//    [WJShare sendShareController:self
//                         LinkURL:@"www.baidu.com"
//                         TagName:@"TAG_ProductDetail"
//                           Title:@"测试"
//                     Description:@"百度百度百百度"
//                      ThumbImage:@"http://a.hiphotos.baidu.com/baike/w%3D268%3Bg%3D0/sign=783d11acbf315c6043956ce9b58aac2e/1c950a7b02087bf49212ea50f1d3572c10dfcf89.jpg"];
}


#pragma mark - CollectionViewDelegate/CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        //轮播
        return 1;
    }else if(section == 1){
        //分类
        return self.channelListArray.count;
    }else if(section == 2){
        //猜你喜欢
        return 1;
    }else{
        //商品
        return self.goodsListArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //轮播
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultIdentifier forIndexPath:indexPath];
        [cell.contentView addSubview:self.cycleScrollView];
        cell.backgroundColor = WJColorViewBg;
        return cell;
    }else if(indexPath.section == 1){
        //分类
//        NSArray *imageArray = @[@"home_newborn-zone_icon",@"home_lucky-draw_icon",@"home_fmcg_icon",@"home_slow-food_icon",@"home_worldcom_icon",@"home_benefit-the-people_icon"];
//        NSArray *titleArray = @[@"新人专区",@"抽奖专区",@"快消品板块",@"慢消品板块",@"世通专区",@"惠民专区"];

        WJCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryIdentifier forIndexPath:indexPath];
        [cell configDataWithModel:self.channelListArray[indexPath.row]];
//        [cell conFigData:[UIImage imageNamed:imageArray[indexPath.row]] title:titleArray[indexPath.row]];
        
        return cell;
    }else if(indexPath.section == 2){
        WJHomeLoveCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeLoveIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        WJGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsIdentifier forIndexPath:indexPath];
        [cell configDataWithModel:self.goodsListArray[indexPath.row]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //轮播
        return CGSizeMake(kScreenWidth,kScreenWidth * 0.6);
    }else if(indexPath.section == 1){
        //分类
        return CGSizeMake(kScreenWidth/3, 90);
    }else if(indexPath.section == 2){
        //猜你喜欢的
        return CGSizeMake(kScreenWidth, 44);
    }else{
        return CGSizeMake((kScreenWidth-6)/2, (kScreenWidth-6)/2+76);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 3) {
        //商品
        return ALD(5);
    }else{
        return 0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row <=1) {
            WJGoodsListViewController * goodsListVC = [[WJGoodsListViewController alloc]init];
            [self.navigationController pushViewController:goodsListVC animated:YES];
        }else if (indexPath.row <= 3){
            WJGoodsPlateViewController * goodsPlateVC = [[WJGoodsPlateViewController alloc]init];
            [self.navigationController pushViewController:goodsPlateVC animated:YES];
        }else if (indexPath.row <= 5){
            WJLotteryDrawViewController * lotteryDrawVC = [[WJLotteryDrawViewController alloc]init];
            [self.navigationController pushViewController:lotteryDrawVC animated:YES];
        }
    }else if (indexPath.section == 3){
        WJGoodsDetailViewController * goodsDetailVC = [[WJGoodsDetailViewController alloc]init];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
    
}

#pragma mark -  UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [_searchBar becomeFirstResponder];
    WJSearchViewController *searchVC = [[WJSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

#pragma mark - SDCycleScrollViewDelegate
//轮播选中代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

#pragma mark - getter && setter
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _collectionView = [[WJRefreshCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabbarHeight - kStatusBarHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = WJColorViewBg;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
//        [_collectionView refreshNow:NO refreshViewType:WJRefreshViewTypeHeader];
        
        //轮播
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultIdentifier];
        //分类
        [_collectionView registerClass:[WJCategoryCollectionViewCell class] forCellWithReuseIdentifier:kCategoryIdentifier];
        //猜你喜欢
        [_collectionView registerClass:[WJHomeLoveCollectionViewCell class] forCellWithReuseIdentifier:kHomeLoveIdentifier];
        //商品
        [_collectionView registerClass:[WJGoodsCollectionViewCell class] forCellWithReuseIdentifier:kGoodsIdentifier];
    }
    return _collectionView;
}


- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
//        NSArray *imageNames = @[[UIImage imageNamed:@"new_x1_19201200_01"],[UIImage imageNamed:@"new_x1_19201200_02"],[UIImage imageNamed:@"new_x1_19201200_03"],[UIImage imageNamed:@"new_x1_19201200_04"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 0.6) delegate:self placeholderImage:nil];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _cycleScrollView.autoScrollTimeInterval = 2;
    }
    return _cycleScrollView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.translucent = NO;
        _searchBar.placeholder = NSLocalizedString(@"Home_Search", comment);
//        @"搜索";
        UIImage* clearImg = [UIImage imageNamed:@"home_search"];
        clearImg= [clearImg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0,10) resizingMode:UIImageResizingModeStretch];
        [_searchBar setSearchFieldBackgroundImage:clearImg forState:UIControlStateNormal];        
    }
    return _searchBar;
}

- (APIHomeManager *)homeManager
{
  if (_homeManager == nil) {
    _homeManager = [[APIHomeManager alloc]init];
    _homeManager.delegate = self;
  }
  return _homeManager;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
