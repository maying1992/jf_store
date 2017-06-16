//
//  WJIndividualInformationController.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"

typedef enum
{
    FromBindInformation,     //绑定个人信息
    FromIndividualCenter,    //个人中心
} InformationFrom;

@interface WJIndividualInformationController : WJViewController

@property(nonatomic , assign)InformationFrom   informationFrom;

@end
