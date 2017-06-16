//
//  WJForgetPasswordView.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJForgetPasswordView : UIView
@property(nonatomic,strong)UITextField          *phoneTextField;
@property(nonatomic,strong)UITextField          *userNewPasswordTextField;
@property(nonatomic,strong)UITextField          *verifyTextField;
@property(nonatomic,strong)UIButton             *getVerifyCodeBtn;
@property(nonatomic,strong)UIButton             *confirmBtn;
@property(nonatomic,strong)NSTimer              *verifyTimer;

- (void)startTimer;

@end
