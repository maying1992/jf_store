//
//  WJGlobalVariable.h
//  WanJiCard
//
//  Created by Angie on 15/9/24.
//  Copyright © 2015年 zOne. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

//typedef enum
//{
//    ResetPsyTypeUnKnow,
//    ResetPsyTypeInit,
//    ResetPsyTypeReset,
//    ResetPsyTypeVerify
//} ResetPsyType;

typedef NS_ENUM(NSInteger,ComeFrom){
    ComeFromPayCode = -1,    //付款页
    ComeFromNone = 0,
    ComeFromLogin = 1,       //登录页
    ComeFromModifyPsd,       //修改支付密码
    ComeFromRetrievePsd,     //找回支付密码
    ComeFromSafetyQuestion,  //设置安全问题
    ComeFromChangePhone,     //修改手机号
    ComeFromOpenNoPsd,       //开启无密
    ComeFromTouchID

};


typedef enum
{
    LoginFromCashAccount = 0,    //账户进入
    
} CashLoginFrom;


@class WJModelPerson;

@interface WJGlobalVariable : NSObject

@property (nonatomic, strong) WJViewController *fromController;  //验证的前一个controller
@property (nonatomic, strong) WJViewController *payfromController;  //支付前前一个controller
@property (nonatomic, assign) CLLocationCoordinate2D appLocation;
@property (nonatomic, strong) NSString *currentID;
@property (nonatomic, assign) NSInteger tabBarIndex;
@property (nonatomic, strong) WJModelPerson *defaultPerson;
@property (nonatomic, assign) NSInteger homeCardClickCount;
+ (instancetype)sharedInstance;

+ (UIImage *)cardBgImageByType:(NSInteger)type;

+ (UIImage *)cardBgImageWithBgByType:(NSInteger)type;

+ (UIColor *)cardBackgroundColorByType:(NSInteger)type;

//+ (NSString *)generateSM3TOTPTokenSeed;

//+ (ResetPsyType)getResetPayPasswordType;

+ (BOOL)touchIDIsAvailable;

+ (NSString *)recordRequestUrlFilePath;

+ (BOOL)serverBaseUrlIsTest;

//处理金额字符串
+ (NSString *)changeMoneyString:(NSString *)money;

@end

