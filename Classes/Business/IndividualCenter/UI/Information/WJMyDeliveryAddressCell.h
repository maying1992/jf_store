//
//  WJMyDeliveryAddressCell.h
//  jf_store
//
//  Created by reborn on 17/5/6.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJDeliveryAddressModel;

@interface WJMyDeliveryAddressCell : UITableViewCell

@property (nonatomic, strong) WJActionBlock settingDefaultAddressBlock;
@property (nonatomic, strong) WJActionBlock editAddressBlock;

-(void)configAddressdDataWithModel:(WJDeliveryAddressModel *)model;
@end
