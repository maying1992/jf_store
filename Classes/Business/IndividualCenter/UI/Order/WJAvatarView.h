//
//  WJAvatarView.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJAvatarViewDelegate <NSObject>

-(void)tapAvatar;
-(void)tapCredits;
-(void)tapFriends;

@end

@interface WJAvatarView : UIView
@property(nonatomic,weak)id <WJAvatarViewDelegate>delegate;

-(void)configDataWithCanUseCredits:(NSUInteger)creditsCount friendsCount:(NSInteger)friendsCount;

@end
