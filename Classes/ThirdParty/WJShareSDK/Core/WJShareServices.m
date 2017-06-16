//
//  WJShareServices.m
//  WanJiCard
//
//  Created by XT Xiong on 16/8/26.
//  Copyright © 2016年 WJIKA. All rights reserved.
//

#import "WJShareServices.h"

#import "WJShareRequestHander.h"
#import "WJAppIsInstalled.h"
#import "WJSystemAlertView.h"
#import<MessageUI/MessageUI.h>

@interface WJShareServices()<MFMessageComposeViewControllerDelegate>


@property (nonatomic, strong) WJShareUI                 * shareUI;
@property (nonatomic, strong) UIViewController          * controller;
@property (nonatomic, strong) NSString                  * shareUrl;
@property (nonatomic, strong) NSString                  * shareTagName;
@property (nonatomic, strong) NSString                  * shareTitle;
@property (nonatomic, strong) NSString                  * shareDescription;
@property (nonatomic, strong) UIImage                   * shareThumbImage;
@property (nonatomic, strong) NSData                    * shareThumbImageData;
@property (nonatomic, strong) NSString                  * shareThumbImageString;
@property (nonatomic, strong) UIViewController          * VC;

@end

@implementation WJShareServices

+ (instancetype)sharedServices
{
    static dispatch_once_t onceToken;
    static WJShareServices *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WJShareServices alloc]init];
    });
    return instance;
}

- (void)choiceShareTpye:(ShareType)shareType
{
    NSLog(@"%d",shareType);
    switch (shareType) {
        case shareTpyeOfQQ:
            [WJShareRequestHander QQSendLinkURL:self.shareUrl Title:self.shareTitle Description:self.shareDescription ThumbImage:self.shareThumbImageString];
            break;
        case shareTpyeOfWX:
            [WJShareRequestHander WXSendLinkURL:self.shareUrl TagName:self.shareTagName Title:self.shareTitle Description:self.shareDescription ThumbImage:self.shareThumbImage InScene:WXSceneSession];
            break;
        case shareTpyeOfWB:
            [WJShareRequestHander WBSendLinkURL:self.shareUrl ObjectID:self.shareTagName Title:self.shareTitle Description:self.shareDescription ThumbImage:self.shareThumbImageData ShareMessageFrom:@"fasfasfdas"];
            break;
        case shareTpyeOfSMS:
        {
            [self.VC dismissViewControllerAnimated:YES completion:nil];
            MFMessageComposeViewController * vc=     [[MFMessageComposeViewController alloc] init];
            vc.body= @"吃饭了没？";
//            vc.recipients= @[@"10010"];
            vc.messageComposeDelegate = self;
            [self.VC presentViewController:vc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController*)controller didFinishWithResult:(MessageComposeResult)result
{
    //关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if(result == MessageComposeResultCancelled) {
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil message:@"取消发送" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil textAlignment:NSTextAlignmentCenter];
        [alert showIn];
    } else if(result == MessageComposeResultSent) {
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil message:@"已经发出" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil textAlignment:NSTextAlignmentCenter];
        [alert showIn];
    } else{
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil message:@"发送失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil textAlignment:NSTextAlignmentCenter];
        [alert showIn];
    }
}


- (void)ShareSendController:(UIViewController *)controller
                    LinkURL:(NSString *)urlString
                    TagName:(NSString *)tagName
                      Title:(NSString *)title
                Description:(NSString *)description
                 ThumbImage:(NSString *)thumbImage
{
    self.VC = controller;
    NSArray *shareOrderArray = [WJAppIsInstalled isAppInstalled];
    if (shareOrderArray.count == 0) {
        WJSystemAlertView *alert = [[WJSystemAlertView alloc] initWithTitle:nil message:@"没有可分享的应用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil textAlignment:NSTextAlignmentCenter];
        [alert showIn];
    }else{
        
        self.shareUI = [[WJShareUI alloc]init];
        self.shareUI.delegate = self;
        [self.shareUI presentViewController:controller ShareOrderArray:shareOrderArray];
        
    }
    self.shareUrl         = urlString;
    self.shareTagName     = tagName;
    self.shareTitle       = title;
    self.shareDescription = description;
    self.shareThumbImageString = thumbImage;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:thumbImage]];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.shareThumbImageData = [self imageWithImage:image?:PlaceholderImage scaledToSize:CGSizeMake(150, 150)];
                self.shareThumbImage = [[UIImage alloc]initWithData:_shareThumbImageData];
            });
        }
    });
}

- (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.5);
}


@end
