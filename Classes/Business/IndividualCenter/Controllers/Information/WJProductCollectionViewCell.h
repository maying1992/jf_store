//
//  WJProductCollectionViewCell.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCategoryProductModel.h"
@interface WJProductCollectionViewCell : UICollectionViewCell

-(void)configDataWithModel:(WJCategoryProductModel *)productModel;

@end
