//
//  WJForgetIntegralPasswordView.h
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJForgetIntegralPasswordView : UIView
@property(nonatomic,strong)UITextField          *phoneTextField;
@property(nonatomic,strong)UITextField          *verifyTextField;
@property(nonatomic,strong)UIButton             *getVerifyCodeBtn;
@property(nonatomic,strong)UIButton             *nextBtn;
@property(nonatomic,strong)NSTimer              *verifyTimer;

- (void)startTimer;
@end
