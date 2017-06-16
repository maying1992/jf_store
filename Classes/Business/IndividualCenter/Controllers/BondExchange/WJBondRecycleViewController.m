//
//  WJBondRecycleViewController.m
//  jf_store
//
//  Created by reborn on 17/5/18.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBondRecycleViewController.h"
#import "WJSystemAlertView.h"

@interface WJBondRecycleViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,WJSystemAlertViewDelegate>
{
    UITextField *userCodeTF;
    UITextField *bondTF;
}
@property(nonatomic,strong)UITableView              *tableView;
@property(nonatomic,strong)NSMutableArray           *listArray;
@end

@implementation WJBondRecycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"债券回收";
    self.isHiddenTabBar = YES;
    [self UISetup];
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UISetup
{
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirmButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    confirmButton.backgroundColor = WJColorMainColor;
    confirmButton.titleLabel.font = WJFont14;
    
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmButton];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bondRecycleCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bondRecycleCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        
        
        UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 1001;
        
        
        UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(200), 0, ALD(200), ALD(44))];
        contentTF.font = WJFont14;
        contentTF.textColor = WJColorDarkGray;
        contentTF.keyboardType = UIKeyboardTypeNumberPad;
        contentTF.textAlignment = NSTextAlignmentRight;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentTF.delegate = self;
        contentTF.tag = 1002;
        [cell.contentView addSubview:contentTF];
        
        [cell.contentView addSubview:nameL];
        [cell.contentView addSubview:contentTF];
        
        
    }
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:1001];
    UITextField *contentTF = (UITextField *)[cell.contentView viewWithTag:1002];
    
    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    if (indexPath.row == 0) {
        
        contentTF.userInteractionEnabled = NO;
        contentTF.text = @"A888888";
        userCodeTF = contentTF;
        
    } else {
        
        contentTF.userInteractionEnabled = YES;
        contentTF.placeholder = @"请输入债券";
        bondTF = contentTF;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        
    }
}

#pragma mark - event
-(void)handletapPressGesture
{
    [userCodeTF resignFirstResponder];
    [bondTF resignFirstResponder];
}

#pragma mark - Action
-(void)confirmButtonAction
{
    if (!(bondTF.text.length > 0)) {
        ALERT(@"请输入债券");
        return;
    }
    
    WJSystemAlertView *alertView = [[WJSystemAlertView alloc] initWithTitle:@"债券兑换" message:@"债券是否确认回收?" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消" textAlignment:NSTextAlignmentCenter];
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
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

-(NSArray *)listArray
{
    return @[
             @{@"text":@"用户编号"},
             @{@"text":@"债券"}
             ];
}


@end
