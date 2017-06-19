//
//  WJChooseGoodsPropertyController.m
//  HuPlus
//
//  Created by XT Xiong on 2017/1/6.
//  Copyright © 2017年 IHUJIA. All rights reserved.
//

#import "WJChooseGoodsPropertyController.h"
#import "WJChooseGoodsSizeCell.h"
#import "WJDigitalSelectorView.h"
#import "APIPayNowManager.h"
#import "WJAtrrValueModel.h"
#import "WJConfirmOrderReformer.h"
#import "WJOrderConfirmModel.h"

#import "WJOrderConfirmController.h"

@interface WJChooseGoodsPropertyController ()<UITableViewDataSource, UITableViewDelegate,APIManagerCallBackDelegate>
{
    WJDigitalSelectorView *digitalSelectorView;
    NSInteger currentCount;
    NSInteger sizeTag;
    NSInteger colorTag;

    BOOL      isFirstChoose;    //是否第一次选择
    BOOL      isFirstChooseSize;//第一次选择类型
    
}
@property(nonatomic,strong)UITableView                 *mainTableView;
@property(nonatomic,strong)UIButton                    *sureButton;
@property(nonatomic,strong)UIButton                    *backButton;
@property(nonatomic,strong)WJChooseGoodsSizeCell       *sizeCell;
@property(nonatomic,strong)WJChooseGoodsSizeCell       *colorCell;
@property(nonatomic,strong)APIPayNowManager            *payNowManager;

@end

@implementation WJChooseGoodsPropertyController

#pragma mark - Life Ciryle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isFromProductDetail) {
        self.isHiddenTabBar = YES;        
    }
    
    self.view.backgroundColor = COLOR(1, 1, 1, 0.5);

    [self.view addSubview:self.sureButton];
    [self.view addSubview:self.mainTableView];
    
}

- (void)sureButtonAction
{
    if (colorTag == 0) {
        ALERT(@"请选择颜色");
        return;
    }
    if (sizeTag == 0) {
        ALERT(@"请选择尺码");
        return;
    }
    if (currentCount == 0) {
        ALERT(@"请选择数量");
        return;
    }
    WJAtrrValueModel *sizeModel = self.sizeArray[sizeTag - 1001];
    WJAtrrValueModel *colorModel = self.colorArray[colorTag - 1001];

    
    self.payNowManager.attrRelationids = [NSString stringWithFormat:@"%@,%@",colorModel.valueId,sizeModel.valueId];
    self.payNowManager.storeId = self.storeId;
    self.payNowManager.goodsNum = NumberToString(currentCount);
    self.payNowManager.goodsID = self.goodsID;
    [self.payNowManager loadData];
    
}

-(void)backButtonAction
{
    [self.view removeFromSuperview];
    [super removeFromParentViewController];
}


#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    WJOrderConfirmModel * orderConfirmModel = [manager fetchDataWithReformer:[WJConfirmOrderReformer new]];
    WJOrderConfirmController * orderVC = [[WJOrderConfirmController alloc]init];
    orderVC.orderConfirmFromController = FromPayRightNow;
    orderVC.orderConfirmModel = orderConfirmModel;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    NSLog(@"%@",manager.errorMessage);
    ALERT(manager.errorMessage);
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }else if (indexPath.row == 1){
        return 25;
    }else if(indexPath.row == 2){
        return self.colorCell.height;
    }else if(indexPath.row == 3){
        return 25;
    }else if (indexPath.row == 4){
        return self.sizeCell.height;
    }else if(indexPath.row == 5){
        return 25;
    }else{
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self creativeTopCellWithTitleString:@"产品规格"];
    }else if (indexPath.row == 1){
        return [self creativeDefaultCellWithTitleString:@"颜色"];
    }else if(indexPath.row == 2){
        return self.colorCell;
    }else if (indexPath.row == 3){
        return [self creativeDefaultCellWithTitleString:@"尺码"];
    }else if (indexPath.row == 4){
        return self.sizeCell;
    }else if (indexPath.row == 5){
        return [self creativeDefaultCellWithTitleString:@"数量"];
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = WJColorCardRed;
        digitalSelectorView = [[WJDigitalSelectorView alloc] initWithFrame:CGRectMake(15, 10, [WJDigitalSelectorView width], [WJDigitalSelectorView height])];
        [digitalSelectorView refeshDigitalSelectorViewWithCount:currentCount];
        
        __weak typeof(self) weakSelf = self;
        [digitalSelectorView setCountChangeBlock:^(BOOL isIncrease) {
            [weakSelf selectViewCountChanged:isIncrease];
        }];
        
        [cell.contentView addSubview:digitalSelectorView];
        return cell;
    }
}

-(void)selectViewCountChanged:(BOOL)isIncrease
{
    if (isIncrease) {
        currentCount += 1;
    } else {
        if (currentCount > 1) {
            currentCount -= 1;
        } else {
            currentCount = 1;
        }
    }
    [digitalSelectorView refeshDigitalSelectorViewWithCount:currentCount];
}

- (UITableViewCell *)creativeTopCellWithTitleString:(NSString *)titleString
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = titleString;
    cell.textLabel.font = WJFont15;
    cell.textLabel.textColor = WJColorMainTitle;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_backButton setImage:[UIImage imageNamed:@"Popup_btn_close"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:_backButton];
    [cell.contentView addConstraints:[_backButton constraintsSize:CGSizeMake(20, 20)]];
    [cell.contentView addConstraints:[_backButton constraintsTopInContainer:10]];
    [cell.contentView addConstraints:[_backButton constraintsRightInContainer:15]];
    
    UIView *line = [[UIView alloc]initForAutoLayout];
    line.backgroundColor = WJColorSeparatorLine;
    [cell.contentView addSubview:line];
    [cell.contentView addConstraints:[line constraintsSize:CGSizeMake(kScreenWidth - 30, 0.5)]];
    [cell.contentView addConstraints:[line constraintsLeftInContainer:15]];
    [cell.contentView addConstraints:[line constraintsBottomInContainer:5]];

    return cell;
}



- (UITableViewCell *)creativeDefaultCellWithTitleString:(NSString *)titleString
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = titleString;
    cell.textLabel.font = WJFont15;
    cell.textLabel.textColor = WJColorMainTitle;
//    cell.backgroundColor = WJRandomColor;
    return cell;
}

- (UITableView *)mainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2 - kTabbarHeight, kScreenWidth, kScreenHeight/2) style:UITableViewStylePlain];
        _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.bounces = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

- (UIButton *)sureButton
{
    if (_sureButton == nil) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(0, kScreenHeight - kTabbarHeight, kScreenWidth, kTabbarHeight);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = WJFont16;
        [_sureButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        _sureButton.backgroundColor = WJColorMainColor;
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (WJChooseGoodsSizeCell *)colorCell
{
    if (_colorCell == nil) {
        _colorCell = [[WJChooseGoodsSizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ColorCell"];
        _colorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_colorCell addButtonNameList:self.colorArray];
        
        for (UIButton *button in _colorCell.buttonList) {
            [button addTarget:self action:@selector(colorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _colorCell;
}

- (WJChooseGoodsSizeCell *)sizeCell
{
    if (_sizeCell == nil) {
        _sizeCell = [[WJChooseGoodsSizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SizeCell"];
        _sizeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_sizeCell addButtonNameList:self.sizeArray];
        
        for (UIButton *button in _sizeCell.buttonList) {
            [button addTarget:self action:@selector(sizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _sizeCell;
}

- (void)sizeBtnAction:(UIButton *)button
{
    for (UIButton *btn in _sizeCell.buttonList) {
        if (btn != button) {
            btn.selected = NO;
        }
        btn.backgroundColor = WJColorWhite;
    }
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = WJColorMainColor;
        sizeTag = button.tag;
    }else{
        button.backgroundColor = WJColorWhite;
        sizeTag = 0;
    }
}

- (void)colorBtnAction:(UIButton *)button
{
    for (UIButton *btn in _colorCell.buttonList) {
        if (btn != button) {
            btn.selected = NO;
        }
        btn.backgroundColor = WJColorWhite;
    }
    button.selected = !button.selected;
    if (button.selected) {
        button.backgroundColor = WJColorMainColor;
        colorTag = button.tag;
    }else{
        button.backgroundColor = WJColorWhite;
        colorTag = 0;
    }
}

- (APIPayNowManager *)payNowManager{
    if (_payNowManager == nil) {
        _payNowManager = [[APIPayNowManager alloc]init];
        _payNowManager.delegate = self;
    }
    return _payNowManager;
}


@end
