//
//  WJBindindConsumerServicesCenterViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBindindConsumerServicesCenterViewController.h"

#define spaceMargin                         (iPhone6OrThan?(ALD(0)):(ALD(15)))

@interface WJBindindConsumerServicesCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,APIManagerCallBackDelegate>

{
    UITextField *bindingServiceCodeTF;
    UITextField *nameTF;
    UITextField *phoneTF;

    UIButton    *bindingOrRemoveBindingButton;
}
@property(nonatomic,strong)UITableView                  *mTb;
@property(nonatomic,strong)NSArray                      *listArray;

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
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//}

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
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(10), 0, ALD(170), ALD(45))];
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
            contentTF.text = @"124";
            
        } else {
            
            contentTF.text = @"";
            contentTF.userInteractionEnabled = YES;

        }
        
    } else if (index == 1) {
        
        contentTF.keyboardType = UIKeyboardTypeDefault;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTF = contentTF;
        
        if (self.serviceCode) {
            
            contentTF.userInteractionEnabled = NO;
            contentTF.text = @"李明";
            
        } else {
            
            contentTF.text = @"";
            contentTF.userInteractionEnabled = NO;

        }
        
    } else  {
        
        phoneTF = contentTF;
        contentTF.keyboardType = UIKeyboardTypeDefault;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        if (self.serviceCode) {
            
            contentTF.userInteractionEnabled = NO;
            contentTF.text = @"13354283549";
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
        
        if (self.serviceCode) {
            
            
        } else {
            
        }
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



@end
