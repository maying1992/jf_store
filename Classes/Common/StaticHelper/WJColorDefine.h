//
//  WJColorDefine.h
//  WanJiCard
//
//  Created by Harry Hu on 15/8/28.
//  Copyright (c) 2015年 zOne. All rights reserved.
//

#ifndef WanJiCard_WJColorDefine_h
#define WanJiCard_WJColorDefine_h

#define COLOR(R, G, B, A)           [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define WJRandomColor  [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:(arc4random() % 256)/255.0]


//主视觉黑（导航、链接等需要强调的地方，以及icon选中状态）
#define WJColorMainTitle            [WJUtilityMethod colorWithHexColorString:@"#333333"]
#define WJColorMainColor            [WJUtilityMethod colorWithHexColorString:@"#2bb8aa"]

#define WJColorPageControlTintColor [[WJUtilityMethod colorWithHexColorString:@"#31b0ef"] colorWithAlphaComponent:0.4]

#define WJColorSystemTitle        [WJUtilityMethod colorWithHexColorString:@"#157efb"]

#define WJColorNavBarTranslucent    [[WJUtilityMethod colorWithHexColorString:@"#000000"] colorWithAlphaComponent:0.3]

//辅助颜色
#define WJColorSubColor            [WJUtilityMethod colorWithHexColorString:@"#ff4200"]

//tabBar上部分割线
#define WJColorTabTopLine           [WJUtilityMethod colorWithHexColorString:@"#d1d1d1"]
#define WJColorTabBar               [WJUtilityMethod colorWithHexColorString:@"#f9f9f9"]
#define WJColorTabNoSelect          [WJUtilityMethod colorWithHexColorString:@"#4b4b4b"]


//红色，视觉强化作用（价格等需要视觉强化的地方）
#define WJColorAmount               [WJUtilityMethod colorWithHexColorString:@"#e23d46"]
#define WJColorPurchase             [WJUtilityMethod colorWithHexColorString:@"#ff6554"]

//黄色
#define WJYellowColorAmount          [WJUtilityMethod colorWithHexColorString:@"#d9a109"]
#define WJBunsYellowColorAmount      [WJUtilityMethod colorWithHexColorString:@"#fee255"]


//Btn描边
#define WJBtnBorderColor             [WJUtilityMethod colorWithHexColorString:@"#dbdfe2"]


//深灰（标题及介绍性文字）
#define WJColorDarkGray             [WJUtilityMethod colorWithHexColorString:@"#2f333b"]

//描述性文字（标题及介绍性文本）
#define WJColorLightGray            [WJUtilityMethod colorWithHexColorString:@"#bbbbbb"]

//提示性文字
#define WJColorAlert                [WJUtilityMethod colorWithHexColorString:@"#c7c7cc"]

//不可编辑灰状态
#define WJColorViewNotEditable      [WJUtilityMethod colorWithHexColorString:@"#e8e8e8"]

//忘记密码等灰色文字
#define WJColorTitleGray            [WJUtilityMethod colorWithHexColorString:@"#84878d"]
//字体颜色
#define kBlueColor                  WJColorMainTitle

//分割线
#define WJColorSeparatorLine        [WJUtilityMethod colorWithHexColorString:@"#eeeeee"]
#define WJColorSeparatorLine1       [WJUtilityMethod colorWithHexColorString:@"#dbdfe2"]

//分类下面的底线
#define WJColorDarkGrayLine         [WJUtilityMethod colorWithHexColorString:@"#e7e8e9"]

//背景色
#define WJColorViewBg               [WJUtilityMethod colorWithHexColorString:@"#f2f2f2"]
#define WJColorViewBg2              [WJUtilityMethod colorWithHexColorString:@"#f3f3f3"]

//卡片配色
#define WJColorCardRed              [WJUtilityMethod colorWithHexColorString:@"#ff635b"]
#define WJColorCardBlue             [WJUtilityMethod colorWithHexColorString:@"#50c9fb"]
#define WJColorCardOrange           [WJUtilityMethod colorWithHexColorString:@"#ffc353"]
#define WJColorCardGreen            [WJUtilityMethod colorWithHexColorString:@"#5cd8b8"]
#define WJColorCardGray             [WJUtilityMethod colorWithHexColorString:@"#dee5ea"]


#define WJColorLoginTitle           [WJUtilityMethod colorWithHexColorString:@"#2e323b"]
#define WJColorDardGray3            [WJUtilityMethod colorWithHexColorString:@"#333333"]
#define WJColorDardGray6            [WJUtilityMethod colorWithHexColorString:@"#666666"]
#define WJColorDardGray9            [WJUtilityMethod colorWithHexColorString:@"#999999"]

#define WJColorBlack                [UIColor blackColor]
#define WJColorWhite                [UIColor whiteColor]

#define WJColorDefaultBackground    [WJUtilityMethod colorWithHexColorString:@"#f2f1f1"]



#endif
