//
//  WJPasswordSettingViewController.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef NS_ENUM(NSInteger, PasswordType){
    
    PasswordTypeNew = 0,         // 新密码
    PasswordTypeConfirm = 1,     // 确认
    PasswordTypeReset = 2        // 重置
};

typedef NS_ENUM(NSInteger, PasswordSettingFrom){
    
    PasswordSettingFromBinding = 0,      // 绑定
    PasswordSettingFromOther = 1,       // 其他

};

@interface WJPasswordSettingViewController : WJViewController

@property(nonatomic, assign) BOOL         canInputPassword;
@property(nonatomic, assign) PasswordType passwordType;
@property(nonatomic, strong) NSString     *lastPassword;
@property(nonatomic, assign) PasswordSettingFrom passwordSettingFrom;

@end
