//
//  WJProductEditView.h
//  jf_store
//
//  Created by reborn on 2017/5/24.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJProductEditModel.h"
@interface WJProductEditView : UIView
@property(nonatomic,strong)UITextField   *categoryTextField;
@property(nonatomic,strong)UITextField   *integralTextField;
@property(nonatomic,strong)UITextField   *stockTextField;
@property(nonatomic,strong)UITextField   *freightTextField;
@property(nonatomic,strong)UITextField   *freightSelectTextField;
@property(nonatomic,strong)UITextField   *standardTextField;
@property(nonatomic,strong)UITextField   *limitTextField;
@property(nonatomic,strong)UIButton      *deleteButton;

@property(nonatomic,strong)WJActionBlock tapCategoryBlock;
-(void)configDataWithProductEditModel:(WJProductEditModel *)model;

@end
