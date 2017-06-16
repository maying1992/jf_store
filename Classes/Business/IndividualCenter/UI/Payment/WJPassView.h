//
//  WJPassView.h
//  jf_store
//
//  Created by reborn on 2017/5/23.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPsdAlertViewTag 100005

@class WJPassView;
@protocol WJPassViewDelegate <NSObject>

- (void)successWithVerifyPsdAlert:(WJPassView *)alertView;

- (void)failedWithVerifyPsdAlert:(WJPassView *)alertView errerMessage:(NSString * )errerMessage;

- (void)forgetPasswordActionWith:(WJPassView *)alertView;

- (void)setTradePasswordActionWith:(WJPassView *)alertView;



@end

@interface WJPassView : UIView

@property (nonatomic, weak) id<WJPassViewDelegate> delegate;
@property(nonatomic,assign) NSInteger alertTag;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)showIn;

- (void)dismiss;

@end
