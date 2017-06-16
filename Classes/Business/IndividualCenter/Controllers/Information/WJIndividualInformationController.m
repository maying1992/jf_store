//
//  WJIndividualInformationController.m
//  jf_store
//
//  Created by reborn on 17/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualInformationController.h"
#import <UIImageView+WebCache.h>
#import "WJRefundPickerView.h"
#import "WJMyQrCodeViewController.h"
#import "WJHomeViewController.h"
#import "AppDelegate.h"
#import "WJMyDeliveryAddressViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SecurityService.h"
#import "APIBaseService.h"
#import "APIServiceFactory.h"
#import "APIModifyInformationManager.h"

@interface WJIndividualInformationController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,APIManagerCallBackDelegate>
{
    
    UIImageView *avatarImageView;
    
    UITextField *userNumberTF;
    UITextField *userNameTF;
    UITextField *nickNameTF;
    UITextField *ageTF;
    UITextField *phoneTF;
    UITextField *regionTF;
    
    UIImage     *originalImage;
    UIImage     *lastImage;
    
    UIButton    *finishButton;
}
@property(nonatomic,strong)APIModifyInformationManager *modifyInformationManager;

@property(nonatomic,strong)UITableView                 *tableView;
@property(nonatomic,strong)NSArray                     *listArray;
@property(nonatomic,strong)UIView                      *maskView;
@property(nonatomic,strong)UIActionSheet               *photoSheet;

@property(nonatomic,strong)NSString                    *headPortraitStr;


@end

@implementation WJIndividualInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.isHiddenTabBar = YES;
    
    [self.view addSubview:self.tableView];
    
    if (self.informationFrom == FromBindInformation) {
        
        [self navigationSetUp];
    }
    
    finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(0, kScreenHeight - ALD(44) - kNavBarAndStatBarHeight, kScreenWidth, ALD(44));
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    finishButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [finishButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    finishButton.backgroundColor = WJColorMainColor;
    finishButton.titleLabel.font = WJFont14;
    [finishButton addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:finishButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    lastImage = originalImage;
    [self handletapPressGesture];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark - Action
-(void)skipButtonAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.tabBarController.selectedIndex != 0) {
        
        [appDelegate.tabBarController changeTabIndex:0];
    }
}

-(void)finishButtonAction
{
    if (originalImage == nil) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请上传头像"];
        
    } else if (nickNameTF.text.length <= 1) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入昵称"];
        
    } else if (ageTF.text.length <= 1) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入年龄"];

    } else {
        
        [self showLoadingView];
//        [self uploadHeadImageToServer:UIImageJPEGRepresentation(originalImage, 1.0)];
        [self upLoadHeadPortrait:[self scaleImage:originalImage toScale:0.3]];
    }
}

-(void)handletapPressGesture
{
    [userNumberTF resignFirstResponder];
    [userNameTF resignFirstResponder];
    [nickNameTF resignFirstResponder];

    [ageTF resignFirstResponder];
    [phoneTF resignFirstResponder];
    [regionTF resignFirstResponder];
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if ([manager isKindOfClass:[APIModifyInformationManager class]]) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[manager fetchDataWithReformer:nil]];
        
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:KUserInformation];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary  *userInformation = [NSDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation]];
        
        NSLog(@"新的数据%@",userInformation);
        
        if (self.modifyInformationManager.headPic && ![originalImage isEqual:lastImage]) {
            
            avatarImageView.image = originalImage;
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传成功"];
        }
        
        UIImage *headImage = originalImage ? : BitmapHeaderImg;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshHeadPortrait" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys: headImage ,@"head_portrait" ,userNameTF.text,@"nick_name",userInformation[@"login_name"],@"login_name",nil]];
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        switch (appDelegate.tabBarController.selectedIndex) {
            case 0:
                
            {
                [appDelegate.tabBarController changeTabIndex:0];
            }
                
                break;
                
                
            case 1:
            {
                [appDelegate.tabBarController changeTabIndex:1];
                
            }
                break;
                
            case 2:
            {
                [appDelegate.tabBarController changeTabIndex:2];
                
            }
                break;
                
            case 3:
            {
                [appDelegate.tabBarController changeTabIndex:3];
                
            }
                break;
                
            case 4:
            {
                [appDelegate.tabBarController changeTabIndex:4];
                
            }
                break;
                
                
            default:
                break;
        }

        
    }
    
}


- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:manager.errorMessage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == nickNameTF) {
        
        [userNumberTF resignFirstResponder];
        [userNameTF resignFirstResponder];
        [phoneTF resignFirstResponder];
        [regionTF resignFirstResponder];
        [ageTF resignFirstResponder];
        
        [nickNameTF becomeFirstResponder];
        
    } else if (textField == ageTF) {
        
        
        [userNumberTF resignFirstResponder];
        [userNameTF resignFirstResponder];
        [nickNameTF resignFirstResponder];
        [phoneTF resignFirstResponder];
        [regionTF resignFirstResponder];
        
        [ageTF becomeFirstResponder];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return ALD(84);

    } else {
        
        return ALD(44);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IndividualInformationCellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IndividualInformationCellIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WJColorWhite;
        cell.separatorInset = UIEdgeInsetsMake(0, ALD(12), 0, ALD(12));
        
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), 0, ALD(110), ALD(44))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont14;
        nameL.tag = 3001;
        [cell.contentView addSubview:nameL];
        
        UIImage *image = [UIImage imageNamed:@"icon_arrow_right"];
        UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(12) - image.size.width, (ALD(44) - image.size.height)/2, image.size.width, image.size.height)];
        rightArrowImageView.hidden = YES;
        rightArrowImageView.tag = 3002;
        rightArrowImageView.image = [UIImage imageNamed:@"icon_arrow_right"];
        [cell.contentView addSubview:rightArrowImageView];
        
        
        UITextField *contentTF = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(34) - ALD(220), 0, ALD(220), ALD(44))];
        contentTF.textColor = WJColorDardGray9;
        contentTF.font = WJFont14;
        contentTF.tag = 3003;
        contentTF.delegate = self;
        contentTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentTF.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:contentTF];
        
    }
    
    UILabel *nameL = (UILabel *)[cell.contentView viewWithTag:3001];
    UIImageView *rightArrowImg = (UIImageView *)[cell.contentView viewWithTag:3002];
    UITextField *contentTF = (UITextField *)[cell.contentView viewWithTag:3003];

    
    NSDictionary *dic = self.listArray[indexPath.row];
    nameL.text = dic[@"text"];
    
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation];
    
    
    if (indexPath.row == 0) {
        
        nameL.frame = CGRectMake(ALD(12), 0, ALD(110), ALD(84));
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(34) - ALD(44), (ALD(84) - ALD(44))/2, ALD(44), ALD(44))];
        avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        avatarImageView.layer.cornerRadius = ALD(22);
        avatarImageView.layer.masksToBounds = YES;
        [avatarImageView sd_setImageWithURL:USER_headPortrait placeholderImage:BitmapHeaderImg];
        [cell.contentView addSubview:avatarImageView];
        rightArrowImg.hidden = YES;
        contentTF.userInteractionEnabled = NO;
        
        
    } else if (indexPath.row == 1) {
        
        userNumberTF = contentTF;
        userNumberTF.userInteractionEnabled = NO;
        userNumberTF.text  =  infoDic[@"userCode"];
        rightArrowImg.hidden = YES;
        
    } else if (indexPath.row == 2) {
        
        userNameTF = contentTF;
        userNameTF.text  =  infoDic[@"name"];
        userNameTF.userInteractionEnabled = NO;
        rightArrowImg.hidden = YES;
        
        
    } else if (indexPath.row == 3) {
        
        nickNameTF = contentTF;
        rightArrowImg.hidden = YES;

        if (infoDic[@"nick_name"]) {
            
            nickNameTF.text = infoDic[@"nick_name"];

        } else {
            
            nickNameTF.text = @"未设置";
        }
        
    } else if (indexPath.row == 4) {
        
        
        rightArrowImg.hidden = NO;
        contentTF.userInteractionEnabled = NO;

    } else if (indexPath.row == 5) {
        
        ageTF = contentTF;
        rightArrowImg.hidden = YES;
        
        if (infoDic[@"age"]) {
            
            ageTF.text = infoDic[@"ageTF"];
            
        } else {
            
            ageTF.text = @"未设置";
        }
        
    } else if (indexPath.row == 6) {
        
        
        phoneTF = contentTF;
        phoneTF.userInteractionEnabled = NO;
        rightArrowImg.hidden = YES;
        phoneTF.text = infoDic[@"contact"];

    } else {
        
        regionTF = contentTF;
        rightArrowImg.hidden = NO;
        contentTF.userInteractionEnabled = NO;
        
        if (infoDic[@"province"] && infoDic[@"city"] && infoDic[@"district"]) {
            
            regionTF.text = [NSString stringWithFormat:@"%@%@%@",infoDic[@"province"],infoDic[@"city"],infoDic[@"district"]];;
            
        } else {
            regionTF.text = @"未设置";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        [self.photoSheet showInView:self.view];
        
    } else if (indexPath.row == 4) {
        
        WJMyQrCodeViewController *myQrCodeVC = [[WJMyQrCodeViewController alloc] init];
        [self.navigationController pushViewController:myQrCodeVC animated:NO];
    } else if (indexPath.row == 7) {
        
        WJMyDeliveryAddressViewController *myDeliveryAddressViewController = [[WJMyDeliveryAddressViewController alloc] init];
        myDeliveryAddressViewController.addressFromVC = fromIndividualVC;
        [self.navigationController pushViewController:myDeliveryAddressViewController animated:NO];
    
    }
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [_maskView removeFromSuperview];
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        //设置选择后的图片可被编辑
        //picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:NO completion:nil];
        
    } else if (buttonIndex == 1) {
        
        [_maskView removeFromSuperview];
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        //设置选择后的图片可被编辑
        //picker.allowsEditing = YES;
        [self presentViewController:picker animated:NO completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //照片原图
        UIImage  *orImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (orImage) {
            
            originalImage = orImage;
            avatarImageView.image = originalImage;
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片无效"];
        }
        
    }
    
}

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0,0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}

-(void)upLoadHeadPortrait:(UIImage *)img
{
    NSString *dataStr = nil;
    NSData *data = UIImageJPEGRepresentation(img, 1.0);
    
    dataStr = [data base64EncodedStringWithOptions:0];
    
    self.headPortraitStr = dataStr;
    [self.modifyInformationManager loadData];
}

//-(void)uploadHeadImageToServer:(NSData *)headImageData
//{
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation][@"token"];
//
//    NSDictionary *params= @{
//                            @"appVersion":kSystemVersion,
//                            @"token":token,
//                            @"nickName":nickNameTF.text,
//                            @"age":ageTF.text,
//                            };
//    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    
//    APIBaseService *service = [[APIServiceFactory sharedInstance] serviceWithIdentifier:kAPIServiceWanJiKa];
//    NSString *url = [NSString stringWithFormat:@"%@/user/setusercenter",service.apiBaseUrl];
//    
//    [mgr POST:url
//   parameters:params
//constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//    [formData appendPartWithFileData:headImageData name:@"head" fileName:@"head.jpg" mimeType:@"image/jpeg"];
//    [self showLoadingView];
//}
//     progress:nil
//      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          
//          NSInteger result=[responseObject[@"rspCode"]integerValue];
//          
//          if (result ==000 )
//          {
//              [self hiddenLoadingView];
//              [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传成功"];
//              
//              [self.navigationController popToRootViewControllerAnimated:YES];
//              
//              AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//              
//              
//              switch (appDelegate.tabBarController.selectedIndex) {
//                  case 0:
//                      
//                  {
//                      [appDelegate.tabBarController changeTabIndex:0];
//                  }
//
//                      break;
//                      
//                      
//                  case 1:
//                  {
//                      [appDelegate.tabBarController changeTabIndex:1];
//
//                  }
//                      break;
//                      
//                  case 2:
//                  {
//                      [appDelegate.tabBarController changeTabIndex:2];
//
//                  }
//                      break;
//                      
//                  case 3:
//                  {
//                      [appDelegate.tabBarController changeTabIndex:3];
//
//                  }
//                      break;
//                      
//                  case 4:
//                  {
//                      [appDelegate.tabBarController changeTabIndex:4];
//
//                  }
//                      break;
//                      
//                      
//                  default:
//                      break;
//              }
//
//          }
//          
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          
//          [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
//          
//      }];
//    
//}
#pragma mark- Event Response
-(void)tapMaskViewgesture:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}

#pragma mark - 属性方法
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight - ALD(44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorColor = WJColorSeparatorLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(UIView *)maskView
{
    if (nil == _maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = WJColorBlack;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        UITapGestureRecognizer *tapGestureAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewgesture:)];
        [_maskView addGestureRecognizer:tapGestureAddress];
        
    }
    return _maskView;
}

-(UIActionSheet *)photoSheet
{
    if (!_photoSheet) {
        
        _photoSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        _photoSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        _photoSheet.destructiveButtonIndex = 2;
        _photoSheet.delegate = self;
    }
    return _photoSheet;
    
}

-(NSArray *)listArray
{
    return @[
             @{@"image":@"defaultImage",@"text":@"个人头像"},
             @{@"text":@"用户编号"},
             @{@"text":@"真实姓名"},
             @{@"text":@"昵称"},
             @{@"text":@"我的二维码"},
             @{@"text":@"年龄"},
             @{@"text":@"联系方式"},
             @{@"text":@"收货地址"}
             ];
}
-(APIModifyInformationManager *)modifyInformationManager
{
    if (_modifyInformationManager == nil) {
        _modifyInformationManager = [[APIModifyInformationManager alloc] init];
        _modifyInformationManager.delegate = self;
    }
    _modifyInformationManager.userId = ToString(USER_ID);
    _modifyInformationManager.headPic = self.headPortraitStr;
    _modifyInformationManager.nickName = nickNameTF.text;
    _modifyInformationManager.age = ageTF.text;
    
    return _modifyInformationManager;
}


@end
