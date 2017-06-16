//
//  WJSetEnterpriseStoreView.h
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJSetEnterpriseStoreView : UIView
@property(nonatomic,strong)UITextField          *storeNameTextField;
@property(nonatomic,strong)UITextField          *storeTypeTextField;
@property(nonatomic,strong)UITextField          *phoneTextField;
@property(nonatomic,strong)UITextField          *regionTextField;
@property(nonatomic,strong)UITextField          *detailAddressTextField;
@property(nonatomic,strong)UITextField          *businessLicenseTextField;

@property(nonatomic,strong)UIButton             *businessLicenseButton;
@property(nonatomic,strong)UIButton             *organizationCodeButton;
@property(nonatomic,strong)UIButton             *accountPermissionButton;
@property(nonatomic,strong)UIButton             *taxRegisterButton;
@property(nonatomic,strong)UIButton             *frontIdCardButton;
@property(nonatomic,strong)UIButton             *backIdCardButton;
@property(nonatomic,strong)UIButton             *submitApplyButton;

@property(nonatomic, strong)WJActionBlock       confirmButtonBlock;
@end
