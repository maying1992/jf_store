//
//  WJMemberView.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMemberView.h"

@interface WJMemberView ()
{
    UIImageView *avatarImageView;
    UILabel     *nameL;
    
    UILabel     *typeL;
    UILabel     *countL;

    UILabel     *friendsL;
    UILabel     *friendsCountL;
}

@end

@implementation WJMemberView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - ALD(75))/2, ALD(66), ALD(75), ALD(75))];
        avatarImageView.backgroundColor = WJRandomColor;
        avatarImageView.layer.cornerRadius = avatarImageView.width/2;
        
        
        nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, avatarImageView.bottom + ALD(16), frame.size.width, ALD(20))];
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont14;
        nameL.text = @"李明";
        nameL.textAlignment = NSTextAlignmentCenter;
        
        
        typeL = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - ALD(55) - ALD(30) - ALD(8) - ALD(20), frame.size.width/2, ALD(20))];
        typeL.textColor = WJColorDardGray3;
        typeL.font = WJFont14;
        typeL.text = @"隔代取筹";
        typeL.textAlignment = NSTextAlignmentCenter;
        
        countL = [[UILabel alloc] initWithFrame:CGRectMake(0, typeL.bottom + ALD(8), frame.size.width/2, ALD(30))];
        countL.textColor = WJColorDardGray3;
        countL.font = WJFont24;
        countL.text = @"73422342";
        countL.textAlignment = NSTextAlignmentCenter;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.size.height - ALD(41) - ALD(64), 0.5, ALD(64))];
        line.backgroundColor = [WJUtilityMethod colorWithHexColorString:@"#cccccc"];
        
        friendsL = [[UILabel alloc] initWithFrame:CGRectMake(line.right, frame.size.height - ALD(55) - ALD(30) - ALD(8) - ALD(20), frame.size.width/2, ALD(20))];
        friendsL.textColor = WJColorDardGray3;
        friendsL.font = WJFont14;
        friendsL.text = @"好友";
        friendsL.textAlignment = NSTextAlignmentCenter;
        
        
        friendsCountL = [[UILabel alloc] initWithFrame:CGRectMake(friendsL.origin.x, friendsL.bottom + ALD(8), frame.size.width/2, ALD(30))];
        friendsCountL.textColor = WJColorDardGray3;
        friendsCountL.font = WJFont24;
        friendsCountL.text = @"45";
        friendsCountL.textAlignment = NSTextAlignmentCenter;
        
        
        [self addSubview:avatarImageView];
        [self addSubview:nameL];
        [self addSubview:typeL];
        [self addSubview:countL];
        [self addSubview:line];
        [self addSubview:friendsL];
        [self addSubview:friendsCountL];

        
    }
    return self;
}


@end
