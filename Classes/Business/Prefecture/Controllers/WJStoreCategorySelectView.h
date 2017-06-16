//
//  WJStoreCategorySelectView.h
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJStoreCategorySelectView : UIView
@property(nonatomic, strong)WJActionBlock cancelButtonBlock;
@property(nonatomic, strong)WJActionBlock confirmButtonBlock;

@property(nonatomic,strong)NSMutableArray *categoryArray;
@end
