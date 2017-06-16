//
//  WJBindInformationViewController.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJBindInformationViewController.h"
#import "WJBindInformationView.h"
#import "WJPasswordSettingViewController.h"
#import "WJHomeViewController.h"
#import "AppDelegate.h"
#import "SecurityService.h"
#import "APIBaseService.h"
#import "APIServiceFactory.h"
#import <AFNetworking/AFNetworking.h>
#import "APIBindPersonalInfoManager.h"

@interface WJBindInformationViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,APIManagerCallBackDelegate>
{
    NSInteger   currentTapButtonIndex;

}

@property(nonatomic,strong)WJBindInformationView                    *bindInformationView;
@property(nonatomic,strong)UIActionSheet                            *actionSheet;
@property(nonatomic,strong)UIImage                                  *frontImage;
@property(nonatomic,strong)UIImage                                  *backImage;
@property(nonatomic,strong)APIBindPersonalInfoManager               *bindPersonalInfoManager;


@end

@implementation WJBindInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定个人信息";
    
    [self.view addSubview:self.bindInformationView];
    [self navigationSetUp];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handletapPressGesture)];
    [self.bindInformationView  addGestureRecognizer:tapGesture];
}

#pragma mark - Cusitom Function

- (void)navigationSetUp
{
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton.titleLabel setFont:WJFont14];
    [skipButton setFrame:CGRectMake(0, 0, 40, 30)];
    [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [skipButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:skipButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}


#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    [self hiddenLoadingView];
    ALERT(@"上传成功");
    WJPasswordSettingViewController *passwordSettingVC = [[WJPasswordSettingViewController alloc] init];
    passwordSettingVC.passwordType = PasswordTypeNew;
    passwordSettingVC.passwordSettingFrom = PasswordSettingFromBinding;
    [self.navigationController pushViewController:passwordSettingVC animated:NO];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [self hiddenLoadingView];
    NSLog(@"%@",manager.errorMessage);
    ALERT(@"上传失败");
}

#pragma mark - Action
-(void)skipButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.tabBarController.selectedIndex != 0) {
        
        [appDelegate.tabBarController changeTabIndex:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                
                [self.bindInformationView.frontIdCardButton setImage:orImage forState:UIControlStateNormal];
                self.frontImage = orImage;
                
            } else if (currentTapButtonIndex == 2) {
                
                [self.bindInformationView.backIdCardButton setImage:orImage forState:UIControlStateNormal];
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
    NSString *token = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation][@"token"];

    NSDictionary *params= @{
                            @"appVersion":kSystemVersion,
                            @"token":token,
                            @"name":self.bindInformationView.nameTextField.text,
                            @"loginName":self.bindInformationView.phoneTextField.text,
                            @"certCode":self.bindInformationView.identityCardTextField.text
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
                            
                            WJPasswordSettingViewController *passwordSettingVC = [[WJPasswordSettingViewController alloc] init];
                            passwordSettingVC.passwordType = PasswordTypeNew;
                            passwordSettingVC.passwordSettingFrom = PasswordSettingFromBinding;
                            [self.navigationController pushViewController:passwordSettingVC animated:NO];
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        NSLog(@"fail");
                        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
                        
                    }];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //资源类型为Camera
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        
        //设置选择后的图片可被编辑
        //picker.allowsEditing = YES;
        [self presentViewController:picker animated:NO completion:nil];
        
        
    } else if (buttonIndex == 1) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //资源类型为图片库
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        
        //设置选择后的图片可被编辑
        //picker.allowsEditing = YES;
        [self presentViewController:picker animated:NO completion:nil];
        
    }
}

#pragma mark - event
-(void)handletapPressGesture
{
    [self.bindInformationView.nameTextField resignFirstResponder];
    [self.bindInformationView.phoneTextField resignFirstResponder];
    [self.bindInformationView.identityCardTextField resignFirstResponder];
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

-(void)confirmButtonAction
{
    [_bindInformationView.nameTextField resignFirstResponder];
    [_bindInformationView.phoneTextField resignFirstResponder];
    [_bindInformationView.identityCardTextField resignFirstResponder];

//    if (!(_bindInformationView.nameTextField.text.length > 0)) {
//        ALERT(@"请输入姓名");
//        return;
//    }
//    
//    if (![WJUtilityMethod isValidatePhone:_bindInformationView.phoneTextField.text] ) {
//        ALERT(@"请输入正确手机号");
//        return;
//    }
    
//    if (![_bindInformationView.identityCardTextField.text isIDCardNumber]) {
//        
//        ALERT(@"身份证号格式不正确");
//        return;
//    }
    
    if (self.frontImage == nil && self.backImage == nil) {
        ALERT(@"请上传身份证正反面照片");
        return;
    }
    
    [self.bindPersonalInfoManager loadData];
    [self showLoadingView];

//    [self uploadToServer:UIImageJPEGRepresentation(self.frontImage, 0.1) backImageData:UIImageJPEGRepresentation(self.backImage, 0.1)];
}


-(APIBindPersonalInfoManager *)bindPersonalInfoManager
{
    if (!_bindPersonalInfoManager) {
        _bindPersonalInfoManager = [[APIBindPersonalInfoManager alloc] init];
        _bindPersonalInfoManager.delegate = self;
    }
    NSString *frontStr = nil;
    NSData *data = UIImageJPEGRepresentation(self.frontImage, 0.1);
    frontStr = [data base64EncodedStringWithOptions:0];
    NSString *rearStr = nil;
    NSData *reardata = UIImageJPEGRepresentation(self.backImage, 0.1);
    rearStr = [reardata base64EncodedStringWithOptions:0];
    
    _bindPersonalInfoManager.name = @"gogo";
//    _bindInformationView.nameTextField.text;
    _bindPersonalInfoManager.userId = @"10017168";
    _bindPersonalInfoManager.certCode = @"1234567890123";
//    _bindInformationView.identityCardTextField.text;
    _bindPersonalInfoManager.front = frontStr;
    _bindPersonalInfoManager.rear = rearStr;
    return _bindPersonalInfoManager;
}

-(WJBindInformationView *)bindInformationView
{
    if (nil == _bindInformationView) {
        _bindInformationView = [[WJBindInformationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_bindInformationView.frontIdCardButton addTarget:self action:@selector(frontIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_bindInformationView.backIdCardButton addTarget:self action:@selector(backIdCardButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_bindInformationView.confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bindInformationView;
}


-(UIActionSheet *)actionSheet
{
    if (nil == _actionSheet) {
        
        _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"我的相册", nil];
    }
    return _actionSheet;
}


@end
