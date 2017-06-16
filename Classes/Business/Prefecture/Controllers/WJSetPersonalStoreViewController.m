//
//  WJSetPersonalStoreViewController.m
//  jf_store
//
//  Created by reborn on 17/5/12.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJSetPersonalStoreViewController.h"
#import "WJSetPersonalStoreView.h"
#import "SecurityService.h"
#import "APIBaseService.h"
#import "APIServiceFactory.h"
#import <AFNetworking/AFNetworking.h>

@interface WJSetPersonalStoreViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger   currentTapButtonIndex;

}
@property(nonatomic,strong)WJSetPersonalStoreView *setPersonalStoreView;
@property(nonatomic,strong)UIImage                *frontImage;
@property(nonatomic,strong)UIImage                *backImage;
@end

@implementation WJSetPersonalStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人店铺";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.setPersonalStoreView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
-(void)frontIdCardButtonAction
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

-(void)backIdCardButtonAction
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

-(void)submitApplyButtonAction
{
    [_setPersonalStoreView.storeNameTextField resignFirstResponder];
    [_setPersonalStoreView.phoneTextField resignFirstResponder];
    [_setPersonalStoreView.regionTextField resignFirstResponder];
    [_setPersonalStoreView.detailAddressTextField resignFirstResponder];

    
    if (!(_setPersonalStoreView.storeNameTextField.text.length > 0)) {
        ALERT(@"请输入店铺名称");
        return;
    }
    
    if (![WJUtilityMethod isValidatePhone:_setPersonalStoreView.phoneTextField.text] ) {
        ALERT(@"请输入正确手机号");
        return;
    }
    
    if (!(_setPersonalStoreView.storeTypeTextField.text.length > 0)) {
        
        ALERT(@"请选择店铺分类");
        return;
    }
    
    if (!(_setPersonalStoreView.regionTextField.text.length > 0)) {
        
        ALERT(@"请输入所在地");
        return;
    }
    
    if (!(_setPersonalStoreView.detailAddressTextField.text.length > 0)) {
        
        ALERT(@"请输入详细地址");
        return;
    }
    
    
    if (self.frontImage == nil && self.backImage == nil) {
        ALERT(@"请上传身份证正反面照片");
        return;
    }
    
    [self uploadToServer:UIImageJPEGRepresentation(self.frontImage, 0.1) backImageData:UIImageJPEGRepresentation(self.backImage, 0.1)];
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
                
                [self.setPersonalStoreView.frontIdCardButton setImage:orImage forState:UIControlStateNormal];
                self.frontImage = orImage;
                
            } else if (currentTapButtonIndex == 2) {
                
                [self.setPersonalStoreView.backIdCardButton setImage:orImage forState:UIControlStateNormal];
                self.backImage = orImage;
            }
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
        
    }
    
}

-(void)uploadToServer:(NSData *)frontImageData backImageData:(NSData *)backImageData
{
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    
    NSDictionary *params= @{
                            @"appVersion":kSystemVersion,
                            @"token":infoDic[@"token"],
                            @"name":self.setPersonalStoreView.storeNameTextField.text,
                            @"loginName":self.setPersonalStoreView.storeTypeTextField.text,
                            @"phone":self.setPersonalStoreView.phoneTextField.text,
                            @"region":self.setPersonalStoreView.regionTextField.text,
                            @"detailAddress":self.setPersonalStoreView.detailAddressTextField.text
                            };
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:kAPIServiceWanJiKa];
    NSString *url = [NSString stringWithFormat:@"%@/user/binding",service.apiBaseUrl];
    
    [mgr POST:url
   parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    [formData appendPartWithFileData:frontImageData name:@"front" fileName:@"front.jpg" mimeType:@"image/jpeg"];
    [formData appendPartWithFileData:backImageData name:@"rear" fileName:@"back.jpg" mimeType:@"image/jpeg"];
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

-(WJSetPersonalStoreView *)setPersonalStoreView
{
    if (!_setPersonalStoreView) {
        _setPersonalStoreView = [[WJSetPersonalStoreView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_setPersonalStoreView.frontIdCardButton addTarget:self action:@selector(frontIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_setPersonalStoreView.backIdCardButton addTarget:self action:@selector(backIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_setPersonalStoreView.submitApplyButton addTarget:self action:@selector(submitApplyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        __weak typeof(self) weakSelf = self;
        
        _setPersonalStoreView.confirmButtonBlock = ^ {
            __strong typeof(self) strongSelf = weakSelf;
            
            NSLog(@"确认");

        };
        
    }
    return _setPersonalStoreView;
}



@end
