//
//  WJCategoryView.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCategoryListModel.h"
#import "WJCategoryProductModel.h"
#import "SDCycleScrollView.h"
#import "WJRefreshCollectionView.h"

typedef void(^SelectCategoryBlock)(WJCategoryListModel *categoryModel);
typedef void (^ProductTapBlock)(WJCategoryProductModel *productModel);
typedef void(^SelectBannerBlock)(NSInteger index);

@interface WJCategoryView : UIView

@property(nonatomic,strong) UITableView                   * mainTableView;
@property(nonatomic,strong) WJRefreshCollectionView       * mainCollectionView;
@property(nonatomic,strong) SDCycleScrollView             * cycleScrollView;

@property(nonatomic,strong) NSMutableArray                * dataArray;
@property(nonatomic,strong) NSMutableArray                * collecDataArray;
@property(nonatomic,strong) NSMutableArray                * bannerDataArray;

@property(nonatomic,strong) SelectCategoryBlock           selectCategoryBlock;
@property(nonatomic,strong) SelectBannerBlock             selectBannerBlock;
@property(nonatomic,strong) ProductTapBlock               productTapBlock;

@end
