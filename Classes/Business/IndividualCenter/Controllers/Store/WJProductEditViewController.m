//
//  WJProductEditViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJProductEditViewController.h"
#import "WJProductEditView.h"
#import "WJProductEditListModel.h"
#import "WJProductEditModel.h"
#import "WJProductEditView.h"

#import "WJStoreCategorySelectView.h"
@interface WJProductEditViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView    *tableView;
@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)WJProductEditListModel *productEditlistModel;
@property(nonatomic,strong)WJStoreCategorySelectView *categorySelectView;

@end

@implementation WJProductEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品编辑";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];
    
    WJProductEditModel *productEditModel1 = [[WJProductEditModel alloc] init];
    productEditModel1.category = @"外套";
    productEditModel1.integral = @"38729";
    productEditModel1.stock = @"323";
    productEditModel1.freight = @"20";
    productEditModel1.standard = @"XL";
    productEditModel1.limitCount = @"1";
    
    
    WJProductEditModel *productEditModel2 = [[WJProductEditModel alloc] init];
    productEditModel2.category = @"外套";
    productEditModel2.integral = @"100";
    productEditModel2.stock = @"323";
    productEditModel2.freight = @"20";
    productEditModel2.standard = @"XL";
    productEditModel2.limitCount = @"1";

    
    self.productEditlistModel = [[WJProductEditListModel alloc] init];
    self.productEditlistModel.productName = @"香水";
    self.productEditlistModel.productDes = @"本店售卖电子产品均来自正规厂家渠道";

    self.productEditlistModel.listArray = [NSMutableArray arrayWithObjects:productEditModel1,productEditModel2, nil];
    
    self.listArray = self.productEditlistModel.listArray;
    
    [self setUI];
    
    [self.tableView reloadData];
    
}

-(void)setUI
{
    UIButton *putOrSoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    putOrSoldButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [putOrSoldButton setTitle:@"上架或下架" forState:UIControlStateNormal];
    [putOrSoldButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    putOrSoldButton.backgroundColor = WJColorMainColor;
    [putOrSoldButton addTarget:self action:@selector(putOrSoldButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:putOrSoldButton];
    
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(300))];
    bgView.backgroundColor = WJColorDardGray9;
    

    UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.width - ALD(60))/2, (ALD(300) - ALD(60))/2, ALD(60), ALD(60))];
    addImageView.image = [UIImage imageNamed:@"productEdit_add_icon"];
    [bgView addSubview:addImageView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [bgView  addGestureRecognizer:tapGesture];
    
    self.tableView.tableHeaderView = bgView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.listArray == nil || self.listArray.count == 0) {
        return 3;
    } else {
        return self.listArray.count + 3;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    } else if (section == self.listArray.count + 1) {
        return 1;
        
    } else if (section == self.listArray.count + 2) {
        
        return 1;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return ALD(44);
        } else {
            return ALD(58);
        }
        
    } else if (indexPath.section == self.listArray.count + 1) {
        
        return ALD(44);
    } else if (indexPath.section == self.listArray.count + 2) {
        
        return ALD(44);
    } else {
        return ALD(264);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ALD(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"ProductEditViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        
        UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(60), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.tag = 1001;
        
        CGFloat contenWidth = kScreenWidth - ALD(45) - ALD(60);
        
        UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(15) - contenWidth, 0, contenWidth ,ALD(44))];
        contentTF.font = WJFont14;
        contentTF.textColor = WJColorDarkGray;
        contentTF.textAlignment = NSTextAlignmentLeft;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentTF.delegate = self;
        
        [cell.contentView addSubview:nameL];
        [cell.contentView addSubview:contentTF];
        
        
        if (indexPath.row == 0) {
            nameL.text = @"商品名称";
            contentTF.placeholder = @"请输入商品名称";
            
        } else {
            
            nameL.text = @"商品描述";
            contentTF.placeholder = @"请输入商品描述";

        }
        
    } else if (indexPath.section == self.listArray.count + 1) {
        
        UIImage *addImg = [UIImage imageNamed:@"add_icon"];
        UIImageView *addIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(10) - ALD(80) - addImg.size.width, (ALD(44) - addImg.size.height)/2, addImg.size.width, addImg.size.height)];
        addIV.image = addImg;
        [cell.contentView addSubview:addIV];
        
        UILabel *contentL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(80), 0, ALD(80), ALD(44))];
        contentL.text = @"添加商品型号";
        contentL.textColor = WJColorDarkGray;
        contentL.font = WJFont14;
        contentL.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentL];

        
    } else if (indexPath.section == self.listArray.count + 2) {
        
        UILabel  *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(11), ALD(80), ALD(22))];
        nameL.textColor = WJColorDarkGray;
        nameL.font = WJFont14;
        nameL.text = @"商品详情";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:nameL];
        
    } else {
        
        WJProductEditView *productEditView = [[WJProductEditView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(264))];
        productEditView.deleteButton.tag = indexPath.row + 1001;
        productEditView.userInteractionEnabled = YES;
        
        [productEditView configDataWithProductEditModel:self.listArray[indexPath.row]];
        [productEditView.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.contentView addSubview:productEditView];

    
        __weak typeof(self) weakSelf = self;
        
        productEditView.tapCategoryBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.view addSubview:self.categorySelectView];
            
        };

    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == self.listArray.count + 1) {
        
        WJProductEditModel *model = [[WJProductEditModel alloc] init];
        [self.listArray addObject:model];
        [self.tableView reloadData];
        
    } else if (indexPath.section == self.listArray.count + 2) {
        
        //跳转商品详情
    }
    
}

#pragma mark - Action

-(void)deleteButtonAction:(UIButton *)button
{
    [self.listArray removeObjectAtIndex:button.tag - 1001];
    [self.tableView reloadData];
}

-(void)putOrSoldButtonAction
{
    
}

-(void)handletapPressGesture
{
    NSLog(@"add");
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - setter/getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight  - kNavBarAndStatBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(WJStoreCategorySelectView *)categorySelectView
{
    if (!_categorySelectView) {
        _categorySelectView = [[WJStoreCategorySelectView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  kNavBarAndStatBarHeight - ALD(44) - ALD(300), kScreenWidth, ALD(300))];
        
        __weak typeof(self) weakSelf = self;
        _categorySelectView.cancelButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.categorySelectView removeFromSuperview];
        };
        
        _categorySelectView.confirmButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            [strongSelf.categorySelectView removeFromSuperview];
            NSLog(@"确认");
        };
        
    }
    return _categorySelectView;
}


@end
