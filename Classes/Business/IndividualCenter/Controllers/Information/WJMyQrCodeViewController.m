//
//  WJMyQrCodeViewController.m
//  jf_store
//
//  Created by reborn on 17/5/5.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMyQrCodeViewController.h"
#import <UIImageView+WebCache.h>
#import "APIGetGrCodeManager.h"
#import <ZXingObjC/ZXingObjC.h>
#import "CreatQRCodeAndBarCodeFromLeon.h"


@interface WJMyQrCodeViewController ()<APIManagerCallBackDelegate>
{
    UIImageView *qrCodeImageView;
}
@property(nonatomic,strong)APIGetGrCodeManager *getGrCodeManager;
@end

@implementation WJMyQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.isHiddenTabBar = YES;
    [self navigationSetUp];
    [self SetUI];
    [self.getGrCodeManager loadData];
}

#pragma mark - Cusitom Function

- (void)navigationSetUp
{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton.titleLabel setFont:WJFont14];
    [shareButton setFrame:CGRectMake(0, 0, 40, 30)];
    [shareButton setImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
    [shareButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)SetUI
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ALD(84))];
    bgView.backgroundColor = WJColorWhite;
    [self.view addSubview:bgView];
    
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(15), (ALD(84) - ALD(60))/2, ALD(60), ALD(60))];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.layer.cornerRadius = avatarImageView.width/2;
    avatarImageView.layer.masksToBounds = YES;
    [avatarImageView sd_setImageWithURL:USER_headPortrait placeholderImage:BitmapHeaderImg];
    [bgView addSubview:avatarImageView];
    
    UILabel *userNumberL = [[UILabel alloc] initWithFrame:CGRectMake(avatarImageView.right + ALD(15), ALD(20), ALD(200), ALD(20))];
    userNumberL.textColor = WJColorDardGray3;
    userNumberL.textAlignment = NSTextAlignmentLeft;
    userNumberL.text = [NSString stringWithFormat:@"用户编号：%@",@"A723233"];
    userNumberL.font = WJFont15;
    [bgView addSubview:userNumberL];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(userNumberL.frame.origin.x, userNumberL.bottom + ALD(8), ALD(100), ALD(20))];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.text = @"李明";
    nameL.textColor = WJColorDardGray3;
    nameL.font = WJFont15;
    [bgView addSubview:nameL];
    
    
    UIView *qrCodeBgView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - ALD(262))/2, bgView.bottom + ALD(68), ALD(262), ALD(262))];
    qrCodeBgView.backgroundColor = [UIColor whiteColor];
    qrCodeBgView.layer.cornerRadius = 15;
    qrCodeBgView.layer.masksToBounds = YES;
    qrCodeBgView.layer.borderColor = [WJColorSeparatorLine CGColor];
    qrCodeBgView.layer.borderWidth = 0.5;
    [self.view addSubview:qrCodeBgView];

    qrCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(11), ALD(11), ALD(240), ALD(240))];
    qrCodeImageView.backgroundColor = [UIColor whiteColor];
    [qrCodeBgView addSubview:qrCodeImageView];
    
    UILabel *desL = [[UILabel alloc] initWithFrame:CGRectMake(0, qrCodeBgView.bottom + ALD(10), kScreenWidth, ALD(20))];
    desL.textColor = WJColorDardGray3;
    desL.text = @"扫码添加好友";
    desL.font = WJFont14;
    desL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:desL];
    
}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    NSDictionary *dic = [[manager fetchDataWithReformer:nil] objectForKey:@"val"];
    [self generatedQR:dic[@"key"]];
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    ALERT(manager.errorMessage);

}

#pragma mark - Logic

- (void)generatedQR:(NSString *)qrCode{
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:qrCode
                                  format:kBarcodeFormatCode128
                                   width:300
                                  height:70
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        qrCodeImageView.image = [UIImage imageWithCGImage:image];
    }
    
    qrCodeImageView.image = [CreatQRCodeAndBarCodeFromLeon qrImageWithString:qrCode size:qrCodeImageView.size color:WJColorBlack backGroundColor:WJColorWhite correctionLevel:ErrorCorrectionLevelMedium];
}

#pragma mark - Action
-(void)shareButtonAction
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(APIGetGrCodeManager *)getGrCodeManager
{
    if (!_getGrCodeManager) {
        _getGrCodeManager = [[APIGetGrCodeManager alloc] init];
        _getGrCodeManager.delegate = self;
    }
    return _getGrCodeManager;
}


@end
