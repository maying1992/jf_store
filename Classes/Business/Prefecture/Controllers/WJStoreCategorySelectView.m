//
//  WJStoreCategorySelectView.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJStoreCategorySelectView.h"
#import "WJStoreCategorySelectCell.h"

#define KStoreCategoryCellIdentifier      @"KStoreCategoryCellIdentifier"

@interface WJStoreCategorySelectView ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIView       *topView;
    UILabel      *titleL;
    UIButton     *cancelButton;
    UIButton     *confirmButton;
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation WJStoreCategorySelectView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = WJColorWhite;
//        self.expressListArray = [NSMutableArray array];
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(40))];
        topView.backgroundColor = WJColorMainColor;
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, 0, ALD(60), ALD(40));
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        cancelButton.titleLabel.font = WJFont13;
        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmButton.frame = CGRectMake(kScreenWidth - ALD(60), 0, ALD(60), ALD(40));
        [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [confirmButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        confirmButton.titleLabel.font = WJFont13;
        [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        titleL = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - ALD(100))/2, 0, ALD(100), ALD(40))];
        titleL.text = @"选择（可多选）";
        titleL.textColor = WJColorWhite;
        titleL.font = WJFont14;
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = ALD(10);
        flowLayout.minimumInteritemSpacing = ALD(12);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topView.bottom + ALD(10), kScreenWidth,frame.size.height - ALD(50)) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = WJColorWhite;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        [self.collectionView registerClass:[WJStoreCategorySelectCell class] forCellWithReuseIdentifier:KStoreCategoryCellIdentifier];
        
    
        [self addSubview:topView];
        [topView addSubview:cancelButton];
        [topView addSubview:confirmButton];
        [topView addSubview:titleL];
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.categoryArray.count == 0 || self.categoryArray == nil) {
        return 0;
    } else {
        return self.categoryArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJStoreCategorySelectCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KStoreCategoryCellIdentifier forIndexPath:indexPath];
    
    [cell configDataWithStoreCategoryModel:self.categoryArray[indexPath.row]];
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-ALD(60))/4, ALD(25));

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, ALD(12), ALD(10), ALD(12));
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return ALD(10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return ALD(12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJStoreCategoryModel *model =  self.categoryArray[indexPath.row];
    if (model.isSelect) {
        model.isSelect = NO;
    } else {
        model.isSelect = YES;
    }
    [self.collectionView reloadData];
}

#pragma mark - Action
-(void)confirmButtonAction
{
    self.confirmButtonBlock();
}

-(void)cancelButtonAction
{
    self.cancelButtonBlock();
}

-(NSMutableArray *)categoryArray
{
    if (_categoryArray == nil) {
//        _categoryArray = [NSMutableArray array];
        WJStoreCategoryModel *model1 = [[WJStoreCategoryModel alloc] init];
        model1.categoryName = @"裤子";
        
        WJStoreCategoryModel *model2 = [[WJStoreCategoryModel alloc] init];
        model2.categoryName = @"食品";
        
        WJStoreCategoryModel *model3 = [[WJStoreCategoryModel alloc] init];
        model3.categoryName = @"装饰品";
        
        WJStoreCategoryModel *model4 = [[WJStoreCategoryModel alloc] init];
        model4.categoryName = @"衣服";
        
        WJStoreCategoryModel *model5 = [[WJStoreCategoryModel alloc] init];
        model5.categoryName = @"裙子";
        
        _categoryArray = [NSMutableArray arrayWithObjects:model1, model2,model3,model4,model5,nil];
    }
    
    return _categoryArray;
}

@end
