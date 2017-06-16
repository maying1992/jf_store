//
//  WJSysContactsManager.h
//  jf_store
//
//  Created by reborn on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

/** model 类 */
@interface WJContactModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

@end


typedef NS_ENUM(NSInteger, WJMessageComposeResult)
{
    WJMessageComposeResultCancelled = 0,
    WJMessageComposeResultSent,
    WJMessageComposeResultFailed
};


typedef void(^WJContactsBlock)(WJContactModel *contact);
typedef void(^WJMessageBlock)(WJMessageComposeResult result);

@interface WJSysContactsManager : NSObject

/**
 *  调用系统通讯录 选择并获取联系人信息
 *
 *  @param handler 选取联系人后的回调
 */
- (void)callContactsHandler:(WJContactsBlock)handler;

/**
 *  调用系统短信功能 单发/群发信息，并返回发送结果
 *
 *  @param phoneNumbers 电话号码数组
 *  @param message      短信内容
 *  @param handler      发送后的回调
 */
- (void)sendContacts:(NSArray<NSString *> *)phoneNumbers message:(NSString *)message completion:(WJMessageBlock)handler;
@end
