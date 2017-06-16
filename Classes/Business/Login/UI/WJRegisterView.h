//
//  WJRegisterView.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJRegisterView : UIView

@property(nonatomic,strong)UITextField *userNumberTextField;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *verifyTextField;
@property(nonatomic,strong)UITextField *recommendedTextField;
@property(nonatomic,strong)UIButton    *getVerifyCodeBtn;
@property(nonatomic,strong)UIButton    *changeUserNumberBtn;
@property(nonatomic,strong)UIButton    *registerBtn;
@property(nonatomic,strong)UIButton    *serviceBtn;

@property(nonatomic,strong)NSTimer     *verifyTimer;


- (void)startTimer;

@end
