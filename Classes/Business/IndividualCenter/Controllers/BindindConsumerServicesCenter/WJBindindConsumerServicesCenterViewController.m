//
//  WJBindindConsumerServicesCenterViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBindindConsumerServicesCenterViewController.h"
#import "APIUserBindingInfoManager.h"
#import "APIBindingServiceCenterManager.h"
#import "APIRecommenderInfoManager.h"
#define spaceMargin                         (iPhone6OrThan?(ALD(0)):(ALD(15)))

@interface WJBindindConsumerServicesCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,APIManagerCallBackDelegate>

{
    UITextField *bindingServiceCodeTF;
    UITextField *nameTF;
    UITextField *phoneTF;
    UIButton    *bindingOrRemoveBindingButton;
}
@property(nonatomic,strong)UITableView                     *mTb;
@property(nonatomic,strong)NSArray                         *listArray;
@property(nonatomic,strong)APIUserBindingInfoManager       *userBindingInfoManager;
@property(nonatomic,strong)APIBindingServiceCenterManager  *bindingServiceCenterManager;
@property(nonatomic,strong)APIRecommenderInfoManager       *recommenderInfoManager;
@property(nonatomic,strong)NSString                     *name;
@property(nonatomic,strong)NSString                     *contact;
@property(nonatomic,strong)NSString                     *serviecStatus;

@end

@implementation WJBindindConsumerServicesCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费服务中心绑定";
    self.isHiddenTabBar = YES;
    [self UISetup];
    
    self.view.backgroundColor = WJColorViewBg;
    [self.view addSubview:self.mTb];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.view  addGestureRecognizer:tapGesture];
    
    [self.userBindingInfoManager loadData];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self handletapPressGesture];
}

-(void)UISetup
{
    bindingOrRemoveBindingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bindingOrRemoveBindingButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [bindingOrRemoveBindingButton setTitle:@"绑定/解除绑定" forState:UIControlStateNormal];
    bindingOrRemoveBindingButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [bindingOrRemoveBindingButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    bindingOrRemoveBindingButton.backgroundColor = WJColorMainColor;
    bindingOrRemoveBindingButton.titleLabel.font = WJFont14;
    
    [bindingOrRemoveBindingButton addTarget:self action:@selector(bindingOrRemoveBindingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindingOrRemoveBindingButton];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIUserBindingInfoManager class]]) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        self.name = dic[@"service_name"];
        self.contact = dic[@"contact"];
        self.serviceCode = dic[@"service_code"];
        self.serviecStatus = dic[@"service_status"];
        
        [self.mTb reloadData];
        
    } else if ([manager isKindOfClass:[APIBindingServiceCenterManager class]]) {
        
        if ([self.bindingServiceCenterManager.operation isEqualToString:@"1"]) {
            
            ALERT(@"绑定成功");
        } else {
            ALERT(@"解除绑定");
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        nameTF.text = dic[@"name"];
        phoneTF.text = dic[@"phone"];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter]  postAlertWithMessage:manager.errorMessage];
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//
//    return YES;
//}
//
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == bindingServiceCodeTF) {
        [self.recommenderInfoManager loadData];

    }

}

#pragma mark - UITableViewDelegate/UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bindingCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bindingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = WJFont14;
        cell.backgroundColor = WJColorWhite;
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), 0, ALD(180), ALD(45))];
        nameL.textColor = WJColorDardGray6;
        nameL.tag = 2001;
        [cell.contentView addSubview:nameL];
        
        UITextField *contentL = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(15) - ALD(150), 0, ALD(150), ALD(45))];
        contentL.tag = 2002;
        contentL.textColor = WJColorDardGray6;
        contentL.delegate = self;
        contentL.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentL];
    }
    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:2001];
    UITextField *contentTF = (UITextField *)[cell.contentView viewWithTag:2002];
    
    NSInteger index = indexPath.row;

    NSDictionary * dic = [NSDictionary dictionary];
    
    dic = [self.listArray objectAtIndex:index];

    
    nameL.text = dic[@"key"];
    
    if (index == 0) {
        
        contentTF.keyboardType = UIKeyboardTypeDefault;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        bindingServiceCodeTF = contentTF;
        
        if (self.serviceCode) {
            
            contentTF.userInteractionEnabled = NO;
            contentTF.text = self.serviceCode;
            
        } else {
            
            contentTF.text = @"";
            contentTF.userInteractionEnabled = YES;

        }
        
    } else if (index == 1) {
        
        contentTF.keyboardType = UIKeyboardTypeDefault;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTF = contentTF;
        
        if ([self.serviecStatus isEqualToString:@"1"]) {
            
            contentTF.userInteractionEnabled = NO;
            contentTF.text = self.name;
            
        } else {
            
            contentTF.text = @"";
            contentTF.userInteractionEnabled = NO;

        }
        
    } else  {
        
        phoneTF = contentTF;
        contentTF.keyboardType = UIKeyboardTypeDefault;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        if ([self.serviecStatus isEqualToString:@"1"]) {
            
            contentTF.userInteractionEnabled = NO;
            contentTF.text = self.contact;
        } else {
            contentTF.text = @"";
            contentTF.userInteractionEnabled = NO;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - Action
-(void)bindingOrRemoveBindingButtonAction
{
    if (bindingServiceCodeTF.text == nil || [bindingServiceCodeTF.text isEqualToString:@""]) {
        ALERT(@"请输入绑定消费服务中心编码");
        
    } else {
        
        if ([self.serviecStatus isEqualToString:@"1"]) {
            
            //绑定
            self.bindingServiceCenterManager.operation = @"1";
        } else {
            
            //解绑
            self.bindingServiceCenterManager.operation = @"2";
        }
        
        [self.bindingServiceCenterManager loadData];
    }
    
}

#pragma mark -event
-(void)handletapPressGesture
{
    [bindingServiceCodeTF resignFirstResponder];
}

#pragma mark - 属性方法
- (UITableView *)mTb{
    if (_mTb == nil) {
        _mTb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain];
        
        _mTb.delegate = self;
        _mTb.dataSource = self;
        _mTb.separatorInset = UIEdgeInsetsZero;
        _mTb.backgroundColor = WJColorViewBg;
        _mTb.scrollEnabled = NO;
        _mTb.separatorColor = WJColorSeparatorLine;
        _mTb.tableFooterView = [UIView new];
    }
    return _mTb;
}


-(NSArray *)listArray
{
    if(nil==_listArray)
    {
        _listArray=@[@{@"key":@"绑定消费服务中心编码"},
                     @{@"key":@"真实姓名"},
                     @{@"key":@"联系方式"}
                     ];
    }
    return _listArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(APIRecommenderInfoManager *)recommenderInfoManager
{
    if (!_recommenderInfoManager) {
        _recommenderInfoManager = [[APIRecommenderInfoManager alloc] init];
        _recommenderInfoManager.delegate = self;
    }
    _recommenderInfoManager.recommenderCode = bindingServiceCodeTF.text;
//    _recommenderInfoManager.userID = USER_ID;
    return _recommenderInfoManager;
}

-(APIUserBindingInfoManager *)userBindingInfoManager
{
    if (!_userBindingInfoManager) {
        _userBindingInfoManager = [[APIUserBindingInfoManager alloc] init];
        _userBindingInfoManager.delegate = self;
    }
//    _userBindingInfoManager.userID = USER_ID;
    return _userBindingInfoManager;
}


-(APIBindingServiceCenterManager *)bindingServiceCenterManager
{
    if (!_bindingServiceCenterManager) {
        _bindingServiceCenterManager = [[APIBindingServiceCenterManager alloc] init];
        _bindingServiceCenterManager.delegate = self;
    }
//    _bindingServiceCenterManager.userID = USER_ID;
    return _bindingServiceCenterManager;
}




@end
