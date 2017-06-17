//
//  WJPassView.m
//  jf_store
//
//  Created by reborn on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPassView.h"
#import "WJSystemAlertView.h"

#define IVTag  200

@interface WJPassView ()<UITextFieldDelegate, APIManagerCallBackDelegate, WJSystemAlertViewDelegate>
{
    UIView      * bgView;
    UIView      * blackView;
    UIButton    * closeButton;
    UILabel     * titleLabel;
    UIView      * topLine;
    UIView      * bottomLine;
    UILabel     * tipLabel;
    
    UIButton    * setPasswordButton;
    UIButton    * submitButton;
    UIButton    * bottomButton;
    
    UITextField *tf;
    UIView * enterBg;
    NSMutableArray *enterPsdViews;
    NSInteger selectedIvTag;
    NSString *enterPassword;
    NSMutableArray *psdArray;
    
}

@property (nonatomic, assign) BOOL canInputPassword;
@end

@implementation WJPassView


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    
    if (self = [super initWithFrame:frame]) {
        self.alertTag = kPsdAlertViewTag;
        UIColor * lineColor = [WJUtilityMethod colorWithHexColorString:@"d9d9d9"];
        blackView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = .4;
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(ALD(52), ALD(100), kScreenWidth -  ALD(104), kScreenWidth -  ALD(74))];
        bgView.backgroundColor = [UIColor whiteColor];
        CGFloat width = CGRectGetWidth(bgView.frame);
        
        bgView.layer.cornerRadius = 10;
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:CGRectMake(ALD(16), ALD(18), ALD(14), ALD(14))];
        [closeButton setImage:[UIImage imageNamed:@"passView_close_icon"] forState:UIControlStateNormal];
        [closeButton setImage:[UIImage imageNamed:@"passView_close_icon"] forState:UIControlStateHighlighted];
        [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(30), 0, width - ALD(60), ALD(50))];
        titleLabel.font = WJFont17;
        titleLabel.textColor = WJColorDarkGray;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        topLine = [[UIView alloc] initWithFrame:CGRectMake(0, ALD(50), width, 1)];
        topLine.backgroundColor = lineColor;

        
        
        psdArray = [NSMutableArray arrayWithCapacity:0];
        
        enterBg = [[UIView alloc] initWithFrame:CGRectMake(ALD(16), bottomLine.bottom + ALD(12), width - ALD(32), ALD(40))];
        [enterBg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showKeyBoard)]];
        enterBg.backgroundColor = WJColorWhite;
        enterBg.layer.borderColor = WJColorDarkGrayLine.CGColor;
        enterBg.layer.borderWidth = 1;
        
        enterPsdViews = [NSMutableArray array];
        CGFloat gap = 1;
        CGFloat ivWidth = (enterBg.width-7*gap)/6;
        for (int i = 0; i < 6; i++) {
            
            if (i>0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake((gap+ivWidth)*i, 0, 1, enterBg.height)];
                line.backgroundColor = WJColorDarkGrayLine;
                [enterBg addSubview:line];
            }
            
            UIImage *normal = [WJUtilityMethod imageFromColor:[UIColor whiteColor] Width:16 Height:16];
            UIImage *hight = [WJUtilityMethod imageFromColor:WJColorMainColor Width:16 Height:16];
            
            UIImageView *iv = [[UIImageView alloc] initWithImage:normal highlightedImage:hight];
            iv.frame = CGRectMake(gap + (ivWidth-16)/2 + (gap + ivWidth)*i, (enterBg.height - 16)/2, 16, 16);
            iv.layer.cornerRadius = 8;
            iv.layer.masksToBounds = YES;
            iv.tag = IVTag+i;
            [enterBg addSubview:iv];
            [enterPsdViews addObject:iv];
        }
        
        selectedIvTag = IVTag;
        
        submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        submitButton.layer.cornerRadius = 5;
        submitButton.backgroundColor = WJColorMainColor;
        [submitButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
        
        bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottomButton addTarget:self action:@selector(bottonAction) forControlEvents:UIControlEventTouchUpInside];
        bottomButton.backgroundColor = WJColorWhite;
        [bottomButton setTitleColor:[WJUtilityMethod colorWithHexColorString:@"007aff"] forState:UIControlStateNormal];
        [bottomButton setTitleColor:[WJUtilityMethod colorWithHexColorString:@"2c9ed7"] forState:UIControlStateNormal];
        bottomButton.titleLabel.font = WJFont12;
        
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), enterBg.bottom + ALD(10), ALD(100), ALD(20))];
        tipLabel.text = @"请输入交易密码";
        tipLabel.font = WJFont12;
        tipLabel.textColor = WJColorDardGray6;
        
        
        setPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [setPasswordButton addTarget:self action:@selector(setPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [setPasswordButton setTitle:@"设置交易密码" forState:UIControlStateNormal];
        setPasswordButton.backgroundColor = WJColorWhite;
        [setPasswordButton setTitleColor:[WJUtilityMethod colorWithHexColorString:@"007aff"] forState:UIControlStateNormal];
        [setPasswordButton setTitleColor:[WJUtilityMethod colorWithHexColorString:@"2c9ed7"] forState:UIControlStateNormal];
        setPasswordButton.titleLabel.font = WJFont12;
        
        
        tf = [[UITextField alloc] initWithFrame:CGRectMake(-100, 0, 103, 20)];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.delegate = self;
        tf.alpha = 0;
        [self addSubview:tf];
        
        
        [bgView addSubview:closeButton];
        [bgView addSubview:titleLabel];
        [bgView addSubview:topLine];
        [bgView addSubview:enterBg];
        [bgView addSubview:tipLabel];
        [bgView addSubview:setPasswordButton];
        [bgView addSubview:submitButton];
        [bgView addSubview:bottomButton];
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:blackView];
        [self addSubview:bgView];
        [self addSubview:tf];
        
        [self refreshViewWithtitle:title];
    }
    return self;
    
}


- (void)refreshViewWithtitle:(NSString *)title
{
    CGFloat width = CGRectGetWidth(bgView.frame);
    
    titleLabel.text = title;

    enterBg.frame = CGRectMake(ALD(16), titleLabel.bottom + ALD(10), width - ALD(32), ALD(40));
    
    tipLabel.frame = CGRectMake(ALD(12), enterBg.bottom + ALD(10), ALD(100), ALD(20));
    
    setPasswordButton.frame = CGRectMake (width - ALD(10) - ALD(100), tipLabel.origin.y, ALD(100), ALD(30));
    
    submitButton.frame = CGRectMake (ALD(16), tipLabel.bottom + ALD(29), width - ALD(32), ALD(40));
    
    bottomButton.frame = CGRectMake (ALD(16), submitButton.bottom + ALD(12), width - ALD(32), ALD(30));
    
    bgView.frame = CGRectMake(ALD(52), ALD(100), kScreenWidth -  ALD(104), bottomButton.bottom + ALD(16));
    
    
    enterBg.hidden = NO;
    submitButton.hidden = NO;
    [submitButton setTitle:@"确认" forState:UIControlStateNormal];
    [bottomButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    
    [self showKeyBoard];
    [self changeInputState];

    
    bgView.frame = CGRectMake(ALD(52), ALD(100), kScreenWidth -  ALD(104), bottomButton.bottom + ALD(6));
}

- (void)showIn
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.alpha = 0;
    self.frame = window.bounds;
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
    }];
    self.tag = self.alertTag;
    [window addSubview:self];
}


- (void)dismiss
{
    [UIView animateWithDuration:0.16f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)closeAction
{
    [self dismiss];
}

-(void)setPasswordButtonAction
{
    if ([self.delegate respondsToSelector:@selector(setTradePasswordActionWith:)]) {
        [self.delegate setTradePasswordActionWith:self];
    }
}

- (void)submitAction
{
    [self startSureBtnAction];
    [self dismiss];
}

- (void)bottonAction
{
    [self forgetPassword];

    [self dismiss];
}

- (void)forgetPassword
{
    if ([self.delegate respondsToSelector:@selector(forgetPasswordActionWith:)]) {
        [self.delegate forgetPasswordActionWith:self];
    }
}


- (void)showKeyBoard{
    [tf becomeFirstResponder];
}

- (void)cleanPsdView{
    for (UIImageView *iv in enterPsdViews) {
        iv.highlighted = NO;
    }
    selectedIvTag = IVTag;
}


- (void)changeInputState
{
    for (UIImageView *iv in enterPsdViews) {
        iv.highlighted = NO;
    }
    [psdArray removeAllObjects];
    self.canInputPassword = YES;
    
}

- (void)startSureBtnAction{
    self.canInputPassword = NO;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sureBtnAction];
    });
}

- (void)sureBtnAction{
    
    enterPassword = [psdArray componentsJoinedByString:@""];
    if (psdArray.count == 0){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码位数不能为空"];
        self.canInputPassword = YES;
        return;
    }
    if (psdArray.count < 6) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码位数为6位"];
        self.canInputPassword = YES;
        return;
    }
    
    [self cleanPsdView];
    
    
    //请求接口
    
}

#pragma mark - APIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager {
    
    NSLog(@"验证成功");
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(successWithVerifyPsdAlert:)]){
        
        [self dismiss];
        [self.delegate successWithVerifyPsdAlert:self];
    }
}


- (void)managerCallAPIDidFailed:(APIBaseManager *)manager{
    
    NSLog(@"验证失败");
    [psdArray removeAllObjects];
    [tf resignFirstResponder];
    
    //验证失败
    if (manager.errorCode == 50008052 || manager.errorCode == 50008053) {
        
        NSDictionary *dic = [manager fetchDataWithReformer:nil];
        
        NSString *errMsg = manager.errorMessage;
        if (errMsg) {
            if (errMsg.length > 0) {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(failedWithVerifyPsdAlert:errerMessage:)]) {
                    [self.delegate failedWithVerifyPsdAlert:self errerMessage:manager.errorMessage];
                }
            }
        }else{
            //text变可编辑
            self.canInputPassword = YES;
            [self showKeyBoard];
        }
        
    }else{
        
        if (manager.errorMessage) {
            if ([manager.errorMessage length] > 0) {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:manager.errorMessage];
            }
        }
        //text变可编辑
        self.canInputPassword = YES;
        [self showKeyBoard];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.canInputPassword) {
        if (string.length == 0) {
            if (selectedIvTag > IVTag) {
                selectedIvTag -= 1;
                UIImageView *iv = (UIImageView *)[self viewWithTag:selectedIvTag];
                iv.highlighted = NO;
                [psdArray removeLastObject];
            }
        } else {
            if (selectedIvTag < 206) {
                UIImageView *iv = (UIImageView *)[self viewWithTag:selectedIvTag];
                iv.highlighted = YES;
                selectedIvTag += 1;
                [psdArray addObject:string];
                
//                if (selectedIvTag == 206) {
//                    [self performSelector:@selector(startSureBtnAction) withObject:nil afterDelay:0.3];
//                }
                if (selectedIvTag == 206) {
                    
                    [tf resignFirstResponder];
                }
            }
        }
    }
    
    return self.canInputPassword;
}

#pragma mark - 属性访问方法
- (void)setAlertTag:(NSInteger)alertTag
{
    if (_alertTag != alertTag) {
        _alertTag = alertTag;
        self.tag = alertTag;
    }
}


@end
