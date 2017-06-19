//
//  WJConsumerActivateViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerActivateViewController.h"
#import "WJConsumerActivateCell.h"
#import "WJMemberModel.h"
#import "WJSystemAlertView.h"
@interface WJConsumerActivateViewController ()<UITableViewDelegate,UITableViewDataSource,WJSystemAlertViewDelegate,APIManagerCallBackDelegate>
@property(nonatomic,strong)UITableView                  *tableView;
@property(nonatomic,strong)NSMutableArray               *listArray;
@end

@implementation WJConsumerActivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"激活";
    self.isHiddenTabBar = YES;
    [self UISetup];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

-(void)UISetup
{
    UIButton *activateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activateButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [activateButton setTitle:@"激活" forState:UIControlStateNormal];
    activateButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [activateButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    activateButton.backgroundColor = WJColorMainColor;
    activateButton.layer.cornerRadius = 4;
    activateButton.layer.masksToBounds = YES;
    activateButton.titleLabel.font = WJFont14;
    
    [activateButton addTarget:self action:@selector(activateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activateButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.listArray.count == 0 || self.listArray == nil) {
        return 0;
    } else {
        return self.listArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJConsumerActivateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPaymentIdentifier"];
    
    if (cell == nil) {
        cell = [[WJConsumerActivateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectPaymentIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    [cell conFigDataWithMemberModel:self.listArray[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WJMemberModel *model = self.listArray[indexPath.row];
    
    if (model.isSelect) {
        model.isSelect = NO;
        
    } else {
        
        model.isSelect = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        //请求接口
    }
}


#pragma mark - Action
-(void)activateButtonAction
{
    NSString *message = [NSString stringWithFormat:@"当前激活需红积分%@，可用积分%@是否确认激活?",@"4000",@"6000"];
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"激活信息" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
    [alertView showIn];
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}


-(NSMutableArray *)listArray
{
    if (!_listArray) {
//        _listArray = [NSMutableArray array];
        WJMemberModel *model1 = [[WJMemberModel alloc] init];
        model1.name = @"李明";
        
        WJMemberModel *model2 = [[WJMemberModel alloc] init];
        model2.name = @"白贝尔";

        _listArray = [NSMutableArray arrayWithObjects:model1,model2, nil];
    }
    return _listArray;
}



@end
