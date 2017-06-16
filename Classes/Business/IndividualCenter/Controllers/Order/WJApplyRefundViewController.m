//
//  WJApplyRefundViewController.m
//  jf_store
//
//  Created by reborn on 17/5/15.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJApplyRefundViewController.h"
#import "WJPurchaseOrderDetailCell.h"
#import "WJRefundPickerView.h"
#import "APIApplyRefundManager.h"
@interface WJApplyRefundViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,WJRefundPickerViewDelegate,UITextViewDelegate,APIManagerCallBackDelegate>
{
    UIView      *bottomView;
    UILabel     *totalAmountL;
    UILabel     *reasonL;
    UITextView  *questionTextView;

}
@property(nonatomic,strong)UITableView                  *tableView;
//@property(nonatomic,strong)WJPurchaseOrderDetailModel   *detailOrder;
@property(nonatomic,strong)WJRefundPickerView           *refundPickerView;
@property(nonatomic,strong)UIView                       *maskView;
@property(nonatomic,strong)APIApplyRefundManager        *applyRefundManager;

@end

@implementation WJApplyRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    self.isHiddenTabBar = YES;
    
    [self initBottomView];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initBottomView
{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kNavigationBarHeight - ALD(64), kScreenWidth, ALD(64))];
    
    bottomView.backgroundColor = WJColorWhite;
    bottomView.layer.borderWidth = 0.5f;
    bottomView.layer.borderColor =  WJColorSeparatorLine.CGColor;
    
    totalAmountL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), kScreenWidth - ALD(12) - ALD(160) - ALD(24), ALD(30))];
    totalAmountL.font = WJFont13;
    totalAmountL.textAlignment = NSTextAlignmentLeft;
    
    NSString *totalAmountStr = [NSString stringWithFormat:@"合计: %@积分",@"4324"];
    totalAmountL.attributedText= [self attributedText:totalAmountStr firstLength:3];
    [bottomView addSubview:totalAmountL];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(bottomView.width - ALD(10) - ALD(80), ALD(10), ALD(80), ALD(30));
    [submitButton setTitle:@"提交"
                  forState:UIControlStateNormal];
    [submitButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    submitButton.titleLabel.font = WJFont14;
    submitButton.backgroundColor = WJColorMainColor;
    submitButton.layer.cornerRadius = 4;
    [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitButton];
    
    [self.view addSubview:bottomView];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    ALERT(manager.errorMessage);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (self.orderModel.productList == nil || self.orderModel.productList.count == 0) {
            return 0;
            
        } else {
            return self.orderModel.productList.count;
        }
        
    } else {
        
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return ALD(40);
        
    } else {
        
        return 0;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        return ALD(30);
        
    } else {
        return ALD(10);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    if (section == 0) {
        
        headerView.backgroundColor = WJColorWhite;
        
        UILabel *shopNameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(10), ALD(200), ALD(20))];
        shopNameL.textColor = WJColorDarkGray;
        shopNameL.font = WJFont12;
        shopNameL.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:shopNameL];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(ALD(12), ALD(40) - 0.5, kScreenWidth - ALD(24), 0.5)];
        line.backgroundColor = WJColorSeparatorLine;
        [headerView addSubview:line];
        
        
        shopNameL.text = self.orderModel.shopName;
        
    }
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [UIView new];
    
    if (section == 0) {
        
        footerView.backgroundColor = WJColorWhite;
        
        UILabel *totalMoneyL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - ALD(150), 0, ALD(150), ALD(30))];
        totalMoneyL.textAlignment = NSTextAlignmentRight;
        [footerView addSubview:totalMoneyL];
        
        
        NSString *totalMoneyStr = [NSString stringWithFormat:@"商品小计: %@",self.orderModel.PayAmount];
        totalMoneyL.attributedText= [self attributedText:totalMoneyStr firstLength:5];
        
        return footerView;
    }
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        return ALD(130);
        
    } else {
        return ALD(44);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    NSInteger section = indexPath.section;
    
    if (section == 0) {
        
        WJPurchaseOrderDetailCell *purchaseCell = [[WJPurchaseOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseOrderDetailCellIdentifier"];
        purchaseCell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell  = purchaseCell;
        
        [purchaseCell configDataWithProduct:self.orderModel.productList[indexPath.row]];

        
    } else if (section == 1) {
        
        
        if (indexPath.row == 0) {
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(60), ALD(44))];
            nameL.text = @"退款原因";
            nameL.textColor = WJColorDardGray3;
            nameL.font = WJFont14;
            [cell.contentView addSubview:nameL];
            
            reasonL = [[UILabel alloc] initWithFrame:CGRectMake(nameL.right, 0, ALD(100), ALD(44))];
            reasonL.textColor = WJColorDarkGray;
            reasonL.font = WJFont12;
            [cell.contentView addSubview:reasonL];
            
            
            UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
            UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - image.size.width, (ALD(44) - image.size.height)/2, image.size.width, image.size.height)];
            rightArrowImageView.image = image;
            [cell.contentView addSubview:rightArrowImageView];

            
        } else {
            
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(60), ALD(44))];
            nameL.textColor = WJColorDardGray3;
            nameL.font = WJFont14;
            nameL.text = @"退款说明";
            [cell.contentView addSubview:nameL];
            
            questionTextView = [[UITextView alloc] initWithFrame:CGRectMake(nameL.right, ALD(5), kScreenWidth - ALD(24) - ALD(60), ALD(35))];
            questionTextView.delegate = self;
            questionTextView.text = @"请输入退款说明";
            questionTextView.font = WJFont12;
            questionTextView.textColor = WJColorLightGray;
            [cell.contentView addSubview:questionTextView];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    } else {
        
        if (indexPath.row == 0) {
            
            [self.view addSubview:self.maskView];
            [self.maskView addSubview:self.refundPickerView];
        }
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([textView.text length] > 200) {
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



#pragma mark - WJRefundPickerView
-(void)refundPickerView:(WJRefundPickerView *)refundPickerView clickCancelButton:(UIButton *)cancelButton
{
    [_maskView removeFromSuperview];
}

-(void)refundPickerView:(WJRefundPickerView *)refundPickerView clickConfirmButtonWithLogisticsCompanyModel:(WJLogisticsCompanyModel *)logisticsCompanyModel
{
    [_maskView removeFromSuperview];
    reasonL.text = logisticsCompanyModel.logisticsCompanyName;
}

#pragma mark - Action
-(void)submitButtonAction
{
    if (!(reasonL.text.length > 0)) {
        ALERT(@"请选择退款原因");
        return;
    }
    
    if (!(questionTextView.text.length > 0)) {
        ALERT(@"请输入退款说明");
        return;
    }
    
    [self.applyRefundManager loadData];
}

#pragma mark- Event Response
-(void)tapMaskViewgesture:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}


- (NSAttributedString *)attributedText:(NSString *)text firstLength:(NSInteger)len{
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]
                                         initWithString:text];
    NSDictionary *attributesForFirstWord = @{
                                             NSFontAttributeName : WJFont12,
                                             NSForegroundColorAttributeName : WJColorDarkGray,
                                             };
    
    NSDictionary *attributesForSecondWord = @{
                                              NSFontAttributeName : WJFont12,
                                              NSForegroundColorAttributeName : WJColorSubColor,
                                              };
    [result setAttributes:attributesForFirstWord
                    range:NSMakeRange(0, len)];
    [result setAttributes:attributesForSecondWord
                    range:NSMakeRange(len, text.length - len)];
    
    
    return [[NSAttributedString alloc] initWithAttributedString:result];
}


#pragma mark - setter& getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - ALD(64)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorInset = UIEdgeInsetsZero;
        
    }
    return _tableView;
}

-(WJRefundPickerView *)refundPickerView
{
    if (nil == _refundPickerView) {
        _refundPickerView = [[WJRefundPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - ALD(300), kScreenWidth, ALD(300))];
        _refundPickerView.delegate = self;
        
        WJLogisticsCompanyModel *model1 = [[WJLogisticsCompanyModel alloc] init];
        model1.logisticsCompanyName = @"我不想买了";
        
        WJLogisticsCompanyModel *model2 = [[WJLogisticsCompanyModel alloc] init];
        model2.logisticsCompanyName = @"信息填写错误，重新拍";
        
        WJLogisticsCompanyModel *model3 = [[WJLogisticsCompanyModel alloc] init];
        model3.logisticsCompanyName = @"卖家缺货";
        
        WJLogisticsCompanyModel *model4 = [[WJLogisticsCompanyModel alloc] init];
        model4.logisticsCompanyName = @"其他原因";
        
        _refundPickerView.expressListArray = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,nil];
    }
    return _refundPickerView;
}

-(UIView *)maskView
{
    if (nil == _maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = WJColorBlack;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        UITapGestureRecognizer *tapGestureAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewgesture:)];
        [_maskView addGestureRecognizer:tapGestureAddress];
        
    }
    return _maskView;
}


//-(WJPurchaseOrderDetailModel *)detailOrder
//{
//    if (!_detailOrder) {
//        _detailOrder = [[WJPurchaseOrderDetailModel alloc] init];
//        
//        WJProductModel *product1 = [[WJProductModel alloc] init];
//        product1.name = @"茶水壶";
//        product1.standardDes = @"43mmx56mm";
//        product1.count = 1;
//        
//        WJProductModel *product2 = [[WJProductModel alloc] init];
//        product2.name = @"电暖壶";
//        product2.standardDes = @"30mmx40mm";
//        product2.count = 1;
//        
//        _detailOrder.productList = [NSMutableArray arrayWithObjects:product1, product2,nil];
//        _detailOrder.createTime = @"2017-05-12 13:30";
//        _detailOrder.orderNo = @"11111111111111111111";
//        _detailOrder.PayAmount = @"53124";
//        _detailOrder.orderStatus = OrderStatusAlreadyRefund;
//        _detailOrder.shopName = @"阿迪王店";
//    }
//    return _detailOrder;
//}

-(APIApplyRefundManager *)applyRefundManager
{
    if (!_applyRefundManager) {
        _applyRefundManager = [[APIApplyRefundManager alloc] init];
        _applyRefundManager.delegate = self;
    }
    _applyRefundManager.orderId = self.orderModel.orderNo;
    _applyRefundManager.refundReason = reasonL.text;
    _applyRefundManager.refundDescribe = questionTextView.text;
    return _applyRefundManager;
}


@end
