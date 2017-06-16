//
//  WJSetEnterpriseStoreViewController.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSetEnterpriseStoreViewController.h"
#import "WJSetEnterpriseStoreView.h"
#import "SecurityService.h"
#import "APIBaseService.h"
#import "APIServiceFactory.h"
#import <AFNetworking/AFNetworking.h>

@interface WJSetEnterpriseStoreViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    NSInteger   currentTapButtonIndex;

}
@property(nonatomic,strong)WJSetEnterpriseStoreView *setEnterpriseStoreView;
@property(nonatomic,strong)UIImage                *businessLicenseImage;
@property(nonatomic,strong)UIImage                *organizationCodeImage;
@property(nonatomic,strong)UIImage                *accountPermissionImage;
@property(nonatomic,strong)UIImage                *taxRegisterImage;
@property(nonatomic,strong)UIImage                *frontIDCardImage;
@property(nonatomic,strong)UIImage                *backIDcardImage;
@end

@implementation WJSetEnterpriseStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业店铺";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.setEnterpriseStoreView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
-(void)businessLicenseButtonAction
{
    currentTapButtonIndex = 1;
    //    [_actionSheet showInView:self.view];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)organizationCodeButtonAction
{
    currentTapButtonIndex = 2;
    //    [_actionSheet showInView:self.view];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)accountPermissionButtonAction
{
    
    currentTapButtonIndex = 3;
    //    [_actionSheet showInView:self.view];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)taxRegisterButtonAction
{
    currentTapButtonIndex = 4;
    //    [_actionSheet showInView:self.view];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}


-(void)frontIdCardButtonAction
{
    currentTapButtonIndex = 5;
    //    [_actionSheet showInView:self.view];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)backIdCardButtonAction
{
    currentTapButtonIndex = 6;
    //    [_actionSheet showInView:self.view];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为Camera
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)submitApplyButtonAction
{
    [_setEnterpriseStoreView.storeNameTextField resignFirstResponder];
    [_setEnterpriseStoreView.phoneTextField resignFirstResponder];
    [_setEnterpriseStoreView.regionTextField resignFirstResponder];
    [_setEnterpriseStoreView.detailAddressTextField resignFirstResponder];
    
    
    if (!(_setEnterpriseStoreView.storeNameTextField.text.length > 0)) {
        ALERT(@"请输入店铺名称");
        return;
    }
    
    if (![WJUtilityMethod isValidatePhone:_setEnterpriseStoreView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }
    
    if (!(_setEnterpriseStoreView.storeTypeTextField.text.length > 0)) {
        
        ALERT(@"请选择店铺分类");
        return;
    }
    
    if (!(_setEnterpriseStoreView.regionTextField.text.length > 0)) {
        
        ALERT(@"请输入所在地");
        return;
    }
    
    if (!(_setEnterpriseStoreView.detailAddressTextField.text.length > 0)) {
        
        ALERT(@"请输入详细地址");
        return;
    }
    
    if (self.businessLicenseImage == nil) {
        ALERT(@"请上传营业执照照片");
        return;
    }
    
    if (self.organizationCodeImage == nil) {
        ALERT(@"请上传组织代码证照片");
        return;
    }
    
    if (self.accountPermissionImage == nil) {
        ALERT(@"请上传开户许可照片");
        return;
    }
    
    if (self.taxRegisterImage == nil) {
        ALERT(@"请上传税务登记照片");
        return;
    }
    
    
    if (self.frontIDCardImage == nil && self.backIDcardImage == nil) {
        ALERT(@"请上传身份证正反面照片");
        return;
    }
    
    [self uploadToServerWithBusinessLicenseData:UIImageJPEGRepresentation(self.businessLicenseImage, 0.1) organizationCodeData:UIImageJPEGRepresentation(self.organizationCodeImage, 0.1)  accountPermissionCode:UIImageJPEGRepresentation(self.accountPermissionImage, 0.1)  taxRegisterData:UIImageJPEGRepresentation(self.taxRegisterImage, 0.1)  frontIdCardData:UIImageJPEGRepresentation(self.frontIDCardImage, 0.1)  backIdCardData:UIImageJPEGRepresentation(self.backIDcardImage, 0.1)];
}

#pragma mark - UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //照片原图
        UIImage* orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        if (orImage) {
            
            if (currentTapButtonIndex == 1) {
                
                [self.setEnterpriseStoreView.businessLicenseButton setImage:orImage forState:UIControlStateNormal];
                self.businessLicenseImage = orImage;
                
            } else if (currentTapButtonIndex == 2) {
                
                [self.setEnterpriseStoreView.organizationCodeButton setImage:orImage forState:UIControlStateNormal];
                self.organizationCodeImage = orImage;
                
            } else if (currentTapButtonIndex == 3) {
                
                [self.setEnterpriseStoreView.accountPermissionButton setImage:orImage forState:UIControlStateNormal];
                self.accountPermissionImage = orImage;
            } else if (currentTapButtonIndex == 4) {
                
                [self.setEnterpriseStoreView.taxRegisterButton setImage:orImage forState:UIControlStateNormal];
                self.taxRegisterImage = orImage;
            } else if (currentTapButtonIndex == 5) {
                
                [self.setEnterpriseStoreView.frontIdCardButton setImage:orImage forState:UIControlStateNormal];
                self.frontIDCardImage = orImage;
                
            } else if (currentTapButtonIndex == 6) {
                
                [self.setEnterpriseStoreView.backIdCardButton setImage:orImage forState:UIControlStateNormal];
                self.backIDcardImage = orImage;
            }
            
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
        
    }
    
}

-(void)uploadToServerWithBusinessLicenseData:(NSData *)businessLicenseData organizationCodeData:(NSData *)organizationCodeData accountPermissionCode:(NSData *)accountPermissionCode taxRegisterData:(NSData *)taxRegisterData  frontIdCardData:(NSData *)frontIdCardData backIdCardData:(NSData *)backIdCardData
{
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    
    NSDictionary *params= @{
                            @"appVersion":kSystemVersion,
                            @"token":infoDic[@"token"],
                            @"name":self.setEnterpriseStoreView.storeNameTextField.text,
                            @"loginName":self.setEnterpriseStoreView.storeTypeTextField.text,
                            @"phone":self.setEnterpriseStoreView.phoneTextField.text,
                            @"region":self.setEnterpriseStoreView.regionTextField.text,
                            @"detailAddress":self.setEnterpriseStoreView.detailAddressTextField.text
                            };
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:kAPIServiceWanJiKa];
    NSString *url = [NSString stringWithFormat:@"%@/user/binding",service.apiBaseUrl];
    
    [mgr POST:url
   parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFileData:frontIdCardData name:@"front" fileName:@"front.jpg" mimeType:@"image/jpeg"];
    [formData appendPartWithFileData:backIdCardData name:@"rear" fileName:@"back.jpg" mimeType:@"image/jpeg"];
    [self showLoadingView];
}
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          NSInteger result=[responseObject[@"rspCode"]integerValue];
          
          if (result ==000 )
          {
              [self hiddenLoadingView];
              [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传成功"];
              
              
          }
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          
          NSLog(@"fail");
          [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
          
      }];
}


-(WJSetEnterpriseStoreView *)setEnterpriseStoreView
{
    if (!_setEnterpriseStoreView) {
        _setEnterpriseStoreView = [[WJSetEnterpriseStoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        [_setEnterpriseStoreView.businessLicenseButton addTarget:self action:@selector(businessLicenseButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_setEnterpriseStoreView.organizationCodeButton addTarget:self action:@selector(organizationCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_setEnterpriseStoreView.accountPermissionButton addTarget:self action:@selector(accountPermissionButtonAction) forControlEvents:UIControlEventTouchUpInside];

        [_setEnterpriseStoreView.taxRegisterButton addTarget:self action:@selector(taxRegisterButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_setEnterpriseStoreView.frontIdCardButton addTarget:self action:@selector(frontIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_setEnterpriseStoreView.backIdCardButton addTarget:self action:@selector(backIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_setEnterpriseStoreView.submitApplyButton addTarget:self action:@selector(submitApplyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        __weak typeof(self) weakSelf = self;
        
        _setEnterpriseStoreView.confirmButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            NSLog(@"确认");
            
        };

    
    }
    return _setEnterpriseStoreView;
}
@end
