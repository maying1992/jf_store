//
//  WJProductEditView.m
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJProductEditView.h"
@interface WJProductEditView ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    UILabel     *categoryLabel;
    UILabel     *integralLabel;
    UILabel     *stockLabel;
    UILabel     *freightLabel;
    UILabel     *standardLabel;
    UILabel     *limitLabel;
    UIView      *verticalLabel;
    
    UIView      *firstLine;
    UIView      *secondLine;
    UIView      *thirdLine;
    UIView      *fourLine;
    UIView      *bottomLine;
}
@property(nonatomic,strong)UIActionSheet  *freightSheet;
@end

@implementation WJProductEditView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        CGFloat categoryLabelWidth = [UILabel getWidthWithTitle:@"分类" font:WJFont15];
        categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), 0, categoryLabelWidth, ALD(44))];
        categoryLabel.font = WJFont15;
        categoryLabel.textColor = WJColorDardGray3;
        categoryLabel.text = @"分类";
        [self addSubview:categoryLabel];
        [self addSubview:self.categoryTextField];
        
        
        firstLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), categoryLabel.bottom, kScreenWidth - ALD(52), 0.5)];
        firstLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:firstLine];
        
        
        integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), firstLine.bottom, categoryLabelWidth, ALD(44))];
        integralLabel.font = WJFont15;
        integralLabel.textColor = WJColorDardGray3;
        integralLabel.text = @"积分";
        [self addSubview:integralLabel];
        [self addSubview:self.integralTextField];
        
        secondLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), integralLabel.bottom, kScreenWidth - ALD(52), 0.5)];
        secondLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:secondLine];
        
        

        stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), secondLine.bottom, categoryLabelWidth, ALD(44))];
        stockLabel.font = WJFont15;
        stockLabel.textColor = WJColorDardGray3;
        stockLabel.text = @"库存";
        [self addSubview:stockLabel];
        [self addSubview:self.stockTextField];
        
        
        thirdLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), stockLabel.bottom, kScreenWidth - ALD(52), 0.5)];
        thirdLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:thirdLine];
        
        
        freightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), thirdLine.bottom, categoryLabelWidth, ALD(44))];
        freightLabel.font = WJFont15;
        freightLabel.textColor = WJColorDardGray3;
        freightLabel.text = @"邮费";
        [self addSubview:freightLabel];
        [self addSubview:self.freightTextField];
        
        
        [self addSubview:self.freightSelectTextField];
        
        verticalLabel = [[UIView alloc] initWithFrame:CGRectMake(self.freightTextField.right + ALD(10), thirdLine.bottom + ALD(9) ,1, ALD(26))];
        verticalLabel.backgroundColor = WJColorSeparatorLine;
        [self addSubview:verticalLabel];
        
        
        fourLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), freightLabel.bottom, kScreenWidth - ALD(52), 0.5)];
        fourLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:fourLine];
        
        
        standardLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), fourLine.bottom, categoryLabelWidth, ALD(44))];
        standardLabel.font = WJFont15;
        standardLabel.textColor = WJColorDardGray3;
        standardLabel.text = @"规格";
        [self addSubview:standardLabel];
        [self addSubview:self.standardTextField];
        
        bottomLine = [[UIView alloc] initWithFrame:CGRectMake(ALD(15), standardLabel.bottom, kScreenWidth - ALD(52), 0.5)];
        bottomLine.backgroundColor = WJColorSeparatorLine;
        [self addSubview:bottomLine];
        
        
        limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(15), bottomLine.bottom, categoryLabelWidth, ALD(44))];
        limitLabel.font = WJFont15;
        limitLabel.textColor = WJColorDardGray3;
        limitLabel.text = @"限购";
        [self addSubview:limitLabel];
        [self addSubview:self.limitTextField];
        
        
        UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
        UIImageView *rigtArrowIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-image.size.width-ALD(12) - ALD(37), (ALD(44) - image.size.height)/2, image.size.width, image.size.height)];
        rigtArrowIV1.image = image;
        [self addSubview:rigtArrowIV1];
        
        UIImageView *rigtArrowIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-image.size.width-ALD(12) - ALD(37), thirdLine.bottom + ALD(12), image.size.width, image.size.height)];
        rigtArrowIV2.image = image;
        [self addSubview:rigtArrowIV2];
        
        
        UIImageView *rigtArrowIV3 = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-image.size.width-ALD(12) - ALD(37), fourLine.bottom + ALD(12), image.size.width, image.size.height)];
        rigtArrowIV3.image = image;
        [self addSubview:rigtArrowIV3];
        
        
        [self addSubview:self.deleteButton];
        
    }
    return self;
}

-(void)configDataWithProductEditModel:(WJProductEditModel *)model
{
    self.categoryTextField.text = model.category;
    self.integralTextField.text = model.integral;
    self.stockTextField.text = model.stock;
    self.freightTextField.text = model.freight;
    self.standardTextField.text = model.standard;
    self.limitTextField.text = model.limitCount;
}


#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        self.freightSelectTextField.text = @"积分";;
        
    } else if (buttonIndex == 1) {
        
        self.freightSelectTextField.text = @"元";;
    }
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.categoryTextField) {
        [_categoryTextField resignFirstResponder];
        self.tapCategoryBlock();
        
    } else if (textField == self.freightSelectTextField) {
        
        [_freightSelectTextField resignFirstResponder];
        [self.freightSheet showInView:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Setter/getter

- (UITextField *)categoryTextField
{
    if (_categoryTextField == nil) {
        _categoryTextField = [[UITextField alloc] initWithFrame:CGRectMake(categoryLabel.right+ALD(15), firstLine.bottom, SCREEN_WIDTH - ALD(100) - categoryLabel.width, ALD(44))];
        _categoryTextField.font = WJFont15;
        _categoryTextField.keyboardType = UIKeyboardTypeDefault;
        _categoryTextField.placeholder = @"";
        _categoryTextField.textColor = WJColorDardGray3;
        _categoryTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _categoryTextField.textAlignment = NSTextAlignmentRight;
        _categoryTextField.delegate = self;
    }
    return _categoryTextField;
}

- (UITextField *)integralTextField
{
    if (_integralTextField == nil) {
        _integralTextField = [[UITextField alloc] initWithFrame:CGRectMake(integralLabel.right+ALD(15), firstLine.bottom, SCREEN_WIDTH - ALD(100) - integralLabel.width, ALD(44))];
        _integralTextField.font = WJFont15;
        _integralTextField.keyboardType = UIKeyboardTypeDefault;
        _integralTextField.placeholder = @"";
        _integralTextField.textColor = WJColorDardGray3;
        _integralTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _integralTextField.textAlignment = NSTextAlignmentRight;
        _integralTextField.delegate = self;
    }
    return _integralTextField;
}


- (UITextField *)stockTextField
{
    if (_stockTextField == nil) {
        _stockTextField = [[UITextField alloc] initWithFrame:CGRectMake(stockLabel.right+ALD(15), secondLine.bottom, SCREEN_WIDTH - ALD(100) - stockLabel.width, ALD(44))];
        _stockTextField.font = WJFont15;
        _stockTextField.keyboardType = UIKeyboardTypeDefault;
        _stockTextField.placeholder = @"";
        _stockTextField.textColor = WJColorDardGray3;
        _stockTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _stockTextField.textAlignment = NSTextAlignmentRight;
        _stockTextField.delegate = self;
    }
    return _stockTextField;
}


- (UITextField *)freightSelectTextField
{
    if (_freightSelectTextField == nil) {
        _freightSelectTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width - ALD(37) - ALD(20) - ALD(30), thirdLine.bottom, ALD(30), ALD(44))];
        _freightSelectTextField.font = WJFont15;
        _freightSelectTextField.keyboardType = UIKeyboardTypeDefault;
        _freightSelectTextField.placeholder = @"";
        _freightSelectTextField.textColor = WJColorDardGray3;
        _freightSelectTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _freightSelectTextField.textAlignment = NSTextAlignmentRight;
        _freightSelectTextField.delegate = self;
    }
    return _freightSelectTextField;
}



- (UITextField *)freightTextField
{
    if (_freightTextField == nil) {
        _freightTextField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(37) - ALD(48) - ALD(48) - ALD(150), thirdLine.bottom, ALD(150), ALD(44))];
        _freightTextField.font = WJFont15;
        _freightTextField.keyboardType = UIKeyboardTypeNumberPad;
        _freightTextField.placeholder = @"";
        _freightTextField.textColor = WJColorDardGray3;
        _freightTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _freightTextField.textAlignment = NSTextAlignmentRight;
        _freightTextField.delegate = self;
    }
    return _freightTextField;
}


- (UITextField *)standardTextField
{
    if (_standardTextField == nil) {
        _standardTextField = [[UITextField alloc] initWithFrame:CGRectMake(standardLabel.right+ALD(15), fourLine.bottom, SCREEN_WIDTH - ALD(100) - standardLabel.width, ALD(44))];
        _standardTextField.font = WJFont15;
        _standardTextField.keyboardType = UIKeyboardTypeDefault;
        _standardTextField.placeholder = @"";
        _standardTextField.textColor = WJColorDardGray3;
        _standardTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _standardTextField.textAlignment = NSTextAlignmentRight;
        _standardTextField.delegate = self;
    }
    return _standardTextField;
}

- (UITextField *)limitTextField
{
    if (_limitTextField == nil) {
        _limitTextField = [[UITextField alloc] initWithFrame:CGRectMake(limitLabel.right+ALD(15), bottomLine.bottom, SCREEN_WIDTH - ALD(100) - limitLabel.width, ALD(44))];
        _limitTextField.font = WJFont15;
        _limitTextField.keyboardType = UIKeyboardTypeDefault;
        _limitTextField.placeholder = @"";
        _limitTextField.textColor = WJColorDardGray3;
        _limitTextField.textAlignment = NSTextAlignmentRight;
        _limitTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _limitTextField.delegate = self;
    }
    return _limitTextField;
}


- (UIButton *)deleteButton
{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setFrame:CGRectMake(self.frame.size.width - ALD(12) - ALD(12), (self.frame.size.height - ALD(12))/2, ALD(12), ALD(12))];
        [_deleteButton setImage:[UIImage imageNamed:@"delete_icon_sel"] forState:UIControlStateNormal];
//        [_deleteButton setImage:[UIImage imageNamed:@"delete_icon_nor"] forState:UIControlStateNormal];

    }
    return _deleteButton;
}

-(UIActionSheet *)freightSheet
{
    if (!_freightSheet) {
        _freightSheet = [[UIActionSheet alloc] initWithTitle:@"请选择邮费类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"积分",@"元", nil];
        _freightSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        _freightSheet.destructiveButtonIndex = 2;
        _freightSheet.delegate = self;
    }
    return _freightSheet;
}



@end
