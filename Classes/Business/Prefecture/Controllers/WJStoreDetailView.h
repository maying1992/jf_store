//
//  WJStoreDetailView.h
//  jf_store
//
//  Created by reborn on 17/5/14.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJStoreModel.h"

@interface WJStoreDetailView : UIView
@property(nonatomic,strong)UIImageView               *storeImageView;
@property(nonatomic,strong)UITextField               *storeNameTextField;
@property(nonatomic,strong)UITextField               *storeNoticeTextField;
@property(nonatomic,strong)UITextField               *phoneTextField;
@property(nonatomic,strong)UITextField               *regionTextField;
@property(nonatomic,strong)UITextField               *addressTextField;

@property(nonatomic, strong)WJActionBlock            tapStoreNoticeBlock;

-(void)configDataWithModel:(WJStoreModel *)storeModel;


@end
