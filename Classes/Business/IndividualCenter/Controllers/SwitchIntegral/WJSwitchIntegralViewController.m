//
//  WJSwitchIntegralViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSwitchIntegralViewController.h"
#import "WJRechargeCenterCell.h"

@interface WJSwitchIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITextField *userCodeTF;
    UITextField *switchIntegralTF;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSArray                  *listArray;
@property(nonatomic,assign)NSInteger                selectPayAwayIndex;
@end

@implementation WJSwitchIntegralViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转积分";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
    [self UISetup];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
}

-(void)UISetup
{
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirmButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    confirmButton.backgroundColor = WJColorMainColor;
    confirmButton.layer.cornerRadius = 4;
    confirmButton.layer.masksToBounds = YES;
    confirmButton.titleLabel.font = WJFont14;
    
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmButton];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
        
    }  else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return ALD(10);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchIntegralCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SwitchIntegralCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    switch (indexPath.section) {
            
        case 0:
        {
            WJRechargeCenterCell *rechargeCenterCell = [[WJRechargeCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
            rechargeCenterCell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell  = rechargeCenterCell;
            
            rechargeCenterCell.textLabel.text = @"可用积分";

            if (indexPath.row == self.selectPayAwayIndex) {
                [rechargeCenterCell conFigData:YES];
            } else {
                [rechargeCenterCell conFigData:NO];
            }
   
        }
            
            break;
            
        case 1:
        {
            UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
            nameL.textColor = WJColorDarkGray;
            nameL.font = WJFont14;
            
            
            UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
            contentTF.font = WJFont14;
            contentTF.textColor = WJColorDarkGray;
            contentTF.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:contentTF];
            
            [cell.contentView addSubview:nameL];
            [cell.contentView addSubview:contentTF];
            
            
            NSDictionary *dic = self.listArray[indexPath.row];
            nameL.text = dic[@"text"];
            
            if (indexPath.row == 0) {
                
                contentTF.placeholder = @"请输入对方用户编号";
                contentTF.userInteractionEnabled = YES;
                userCodeTF = contentTF;
                
            } else if (indexPath.row == 1) {
                
                contentTF.userInteractionEnabled = NO;
                contentTF.text = @"李明";
                
            } else if (indexPath.row == 2) {
                
                contentTF.userInteractionEnabled = NO;
                contentTF.text = @"13354284950";

                
            }  else {
                
                contentTF.placeholder = @"请输入转积分";
                contentTF.userInteractionEnabled = YES;
                switchIntegralTF = contentTF;

            }
            
        }
            break;

        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        self.selectPayAwayIndex = indexPath.row;
        [self.tableView reloadData];
    }
}

#pragma mark - Action
-(void)confirmButtonAction
{
    if (!(userCodeTF.text.length > 0)) {
        ALERT(@"请输入对方用户编号");
        return;
    }
    if (!(switchIntegralTF.text.length > 0)) {
        ALERT(@"请输入转积分");
        return;
    }
    //请求接口
}

#pragma mark - event
-(void)handletapPressGesture
{
    [userCodeTF resignFirstResponder];
    [switchIntegralTF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(44)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


-(NSArray *)listArray
{
    return @[
             @{@"text":@"对方用户编号"},
             @{@"text":@"用户名"},
             @{@"text":@"手机号"},
             @{@"text":@"转积分"}
             ];
}


@end
