//
//  WJAvatarView.m
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJAvatarView.h"
#import <UIImageView+WebCache.h>

@interface WJAvatarView ()
{
    UIImageView *avatarImageView;
    UILabel     *phoneL;
    
    UIView      *creditsView;
    UILabel     *canUseCreditsL;
    UILabel     *creditsCountL;
    
    UIView      *friendsView;
    UILabel     *friendsL;
    UILabel     *friendsCountL;
}
@end

@implementation WJAvatarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width- ALD(80))/2, ALD(50), ALD(80), ALD(80))];
        avatarImageView.userInteractionEnabled = YES;
        avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        [avatarImageView sd_setImageWithURL:USER_headPortrait placeholderImage:BitmapHeaderImg];
        avatarImageView.layer.cornerRadius = avatarImageView.width/2;
        avatarImageView.clipsToBounds = YES;
        [self addSubview:avatarImageView];
        
        phoneL = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - ALD(100))/2,avatarImageView.bottom + ALD(10) , ALD(100), ALD(20))];
        [self addSubview:avatarImageView];
        

        phoneL.textColor = [UIColor whiteColor];
        phoneL.textAlignment = NSTextAlignmentCenter;
        phoneL.font = WJFont12;
        [self addSubview:phoneL];
        
        
        creditsView = [[UIView alloc] initWithFrame:CGRectMake(ALD(20),phoneL.bottom + ALD(20), kScreenWidth/2 - ALD(20), ALD(50))];
        creditsView.userInteractionEnabled = YES;
        [self addSubview:creditsView];
        
        
        canUseCreditsL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, creditsView.width, ALD(20))];
        canUseCreditsL.textAlignment = NSTextAlignmentCenter;
        canUseCreditsL.text = @"可用积分";
        canUseCreditsL.textColor = WJColorWhite;
        canUseCreditsL.font = WJFont15;
        [creditsView addSubview:canUseCreditsL];
        
        creditsCountL = [[UILabel alloc] initWithFrame:CGRectMake(0, canUseCreditsL.bottom, creditsView.width, ALD(30))];
        creditsCountL.textAlignment = NSTextAlignmentCenter;
        creditsCountL.textColor = WJColorWhite;
        creditsCountL.font = WJFont15;
        [creditsView addSubview:creditsCountL];
        
        UIView  *line = [[UIView alloc] initWithFrame:CGRectMake(creditsView.right,phoneL.bottom + ALD(20), 0.5, ALD(30))];
        line.backgroundColor = WJColorSeparatorLine;
        [self addSubview:line];
        

        friendsView = [[UIView alloc] initWithFrame:CGRectMake(creditsView.right,phoneL.bottom + ALD(20), creditsView.width, ALD(50))];
        friendsView.userInteractionEnabled = YES;
        [self addSubview:friendsView];
        
        
        friendsL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, friendsView.width, ALD(20))];
        friendsL.textAlignment = NSTextAlignmentCenter;
        friendsL.text = @"好友";
        friendsL.textColor = WJColorWhite;
        friendsL.font = WJFont15;
        [friendsView addSubview:friendsL];
        
        
        friendsCountL = [[UILabel alloc] initWithFrame:CGRectMake(0, canUseCreditsL.bottom, creditsView.width, ALD(30))];
        friendsCountL.textAlignment = NSTextAlignmentCenter;
        friendsCountL.textColor = WJColorWhite;
        friendsCountL.font = WJFont15;
        [friendsView addSubview:friendsCountL];
        
        
        UITapGestureRecognizer *tapHeaderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderAction)];
        [avatarImageView  addGestureRecognizer:tapHeaderGesture];
        
        
        UITapGestureRecognizer *tapCreditsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCreditsAction)];
        [creditsView  addGestureRecognizer:tapCreditsGesture];
        
        
        UITapGestureRecognizer *tapFriendsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFriendsAction)];
        [friendsView  addGestureRecognizer:tapFriendsGesture];
        
    }
    return self;
}


-(void)configDataWithCanUseCredits:(NSUInteger)creditsCount friendsCount:(NSInteger)friendsCount
{
    NSString *nickName = [[NSUserDefaults standardUserDefaults] dictionaryForKey:KUserInformation][@"nick_name"];
    
    if (USER_ID) {
        
        if ([nickName isEqualToString:@""]) {
            phoneL.text = USER_TEL;
        } else {
            phoneL.text = nickName;
        }
        
    } else {
        
        phoneL.text = @"未登录";
    }
    
    creditsCountL.text = [NSString stringWithFormat:@"%ld",creditsCount];
    friendsCountL.text = [NSString stringWithFormat:@"%ld",friendsCount];
}

-(void)tapHeaderAction
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapAvatar)]) {
            [self.delegate tapAvatar];
        }
    }
}

-(void)tapCreditsAction
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapCredits)]) {
            [self.delegate tapCredits];
        }
    }
}

-(void)tapFriendsAction
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(tapFriends)]) {
            [self.delegate tapFriends];
        }
    }
}


@end
