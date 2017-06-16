//
//  WJAreaModel.h
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "BaseDBModel.h"

@interface WJAreaModel : BaseDBModel

@property (nonatomic, assign) NSInteger areaId;         //id
@property (nonatomic, strong) NSString *areaNo;         //编号
@property (nonatomic, strong) NSString *areaName;       //地区名字
@property (nonatomic, strong) NSString *areaParentNo;   //父节点编号
@property (nonatomic, assign) NSInteger areaRank;       //层级


//@property (nonatomic, strong) NSString *areaShortname;  //简称
//@property (nonatomic, strong) NSString *areaFullSpell;  //全拼
//@property (nonatomic, strong) NSString *areaShortSpell; //简拼
//@property (nonatomic, strong) NSString *areaCode;       //区号
//@property (nonatomic, strong) NSString *areaOldNo;      //父节点含有的子节点
//@property (nonatomic, strong) NSString *areaZipCode;    //其他

@end
