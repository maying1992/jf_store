//
//  WJScanCodeViewController.m
//  jf_store
//
//  Created by XT Xiong on 2017/5/4.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WJSystemAlertView.h"
#import "WJScanView.h"

#define kCameraWidth        ALD(300)
#define kCameraHeight       kCameraWidth
#define kCameraLeft         (kScreenWidth-ALD(300))/2
#define kCameraTop          ALD(90) + ALD(19)

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface WJScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,WJSystemAlertViewDelegate>
{
    int     num;
    BOOL    upOrdown;
    NSTimer *timer;
    
    BOOL    isPushLogin;
}

@property(nonatomic, strong)AVCaptureSession           *captureSession;
@property(nonatomic, strong)AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property(nonatomic, strong)WJScanView                 *scanView;


@end

@implementation WJScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHiddenTabBar = YES;

    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 32, 19, 19);
    [leftBtn setImage:[UIImage imageNamed:@"common_nav_btn_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBarButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    upOrdown = NO;
    num =0;
    
    [self.view addSubview:self.scanView];
    [self beginingScanCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneInForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appHasGoneBcakground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.captureSession startRunning];
    isPushLogin = NO;
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
    
    [timer invalidate];
    timer = nil;
    self.navigationController.navigationBarHidden = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
}

-(NSString *)createCpatureSetting
{
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        
        return [error localizedDescription];
    }
    
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [captureMetadataOutput setRectOfInterest:[self getReaderViewBoundsWithSize:CGSizeMake(kCameraWidth, kCameraWidth)]];
    
    [_captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,
                                                    AVMetadataObjectTypeEAN13Code,
                                                    AVMetadataObjectTypeEAN8Code,
                                                    AVMetadataObjectTypeCode128Code]];
    
    //创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.view.bounds];
    
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    [self addAlphaViewWithAlpha:0.5];
    
    [self.captureSession startRunning];
    
    return nil;
}

#pragma mark - 开启扫描二维码
- (void)beginingScanCode
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil
                                                                    message:@"提示\n您当前未开启相机权限，请前去设置中开启"
                                                                   delegate:self
                                                          cancelButtonTitle:@"知道了"
                                                          otherButtonTitles:IOS8_LATER?@"去设置":nil
                                                              textAlignment:NSTextAlignmentCenter];
        
        [alert showIn];
        
    }
    
    NSString *errorString = [self createCpatureSetting];
    if (!errorString) {
        ALERT(errorString);
    };
    
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self
                                           selector:@selector(animation)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 二维码动画
-(void)animation
{
    if (upOrdown == NO) {
        num ++;
        self.scanView.line.frame = CGRectMake(ALD(6), ALD(0) + 2*num,kScreenWidth - ALD(100), 2);
        if (2*num > kCameraWidth-ALD(5)) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        self.scanView.line.frame = CGRectMake(ALD(6), ALD(0) + 2*num, kScreenWidth - ALD(100), 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

#pragma mark - app成为活跃状态
- (void)appHasGoneInForeground
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil
                                                                    message:@"提示\n您当前未开启相机权限，请前去设置中开启"
                                                                   delegate:self
                                                          cancelButtonTitle:@"知道了"
                                                          otherButtonTitles:IOS8_LATER?@"去设置":nil
                                                              textAlignment:NSTextAlignmentCenter];
        [alert showIn];
        
    }
    
}

#pragma mark - app进入后台
- (void)appHasGoneBcakground
{
    [self.captureSession stopRunning];
    self.captureSession = nil;
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        [self performSelectorOnMainThread:@selector(reportScanResult:)
                               withObject:[[metadataObjects firstObject] stringValue]
                            waitUntilDone:NO];
        
    }
}

- (void)reportScanResult:(NSString *)code{
    NSLog(@"======扫描结果====%@",code);
}

#pragma mark - WJSystemAlertViewDelegate
-(void)wjAlertView:(WJSystemAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
            break;
            
        default:
            break;
    }
}

- (void)addAlphaViewWithAlpha:(float) alpha
{
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, 0, kScreenWidth, kCameraTop) alpha:alpha]];
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, kCameraTop, kCameraLeft, kCameraHeight) alpha:alpha]];
    [self.view addSubview:[self createViewWithFrame:CGRectMake(kCameraLeft + kCameraWidth, kCameraTop, kScreenWidth - (kCameraWidth + kCameraLeft), kCameraHeight) alpha:alpha]];
    [self.view addSubview:[self createViewWithFrame:CGRectMake(0, kCameraHeight + kCameraTop, kScreenWidth, kScreenHeight - (kCameraTop + kCameraHeight)) alpha:alpha]];
}

- (CGRect)getReaderViewBoundsWithSize:(CGSize)asize
{
    return CGRectMake((kCameraTop) / kScreenHeight, ((kScreenWidth - asize.width) / 2.0) / kScreenWidth, asize.height / kScreenHeight, asize.width / kScreenWidth);
}

- (UIView *)createViewWithFrame:(CGRect)frame  alpha:(float)alpha
{
    UIView * aView = [[UIView alloc] initWithFrame:frame];
    aView.userInteractionEnabled = NO;
    aView.backgroundColor = [UIColor blackColor];
    aView.alpha = alpha;
    
    return aView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(WJScanView *)scanView
{
    if (!_scanView) {
        _scanView = [[WJScanView alloc] initWithFrame:CGRectMake(ALD(15), ALD(64), kScreenWidth - ALD(15) *2, ALD(395))];
    }
    return _scanView;
    
}

@end
