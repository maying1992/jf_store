//
//  WJCategoryCollectionViewCell.h
//  HuPlus
//
//  Created by reborn on 16/12/19.
//  Copyright © 2016年 IHUJIA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJChannelModel.h"

@interface WJCategoryCollectionViewCell : UICollectionViewCell

//- (void)conFigData:(WJCategoryListModel *)model;

- (void)conFigData:(UIImage *)image title:(NSString *)titleStr;

-(void)configDataWithModel:(WJChannelModel *)channelModel;


@end
