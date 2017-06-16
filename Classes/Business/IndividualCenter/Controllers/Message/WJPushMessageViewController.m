//
//  WJPushMessageViewController.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJPushMessageViewController.h"

@interface WJPushMessageViewController ()

@end

@implementation WJPushMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推送消息";
    self.isHiddenTabBar = YES;
    
    [self setUI];
}

-(void)setUI
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), ALD(16), kScreenWidth - ALD(24), ALD(30))];
    title.text = @"推送消息";
    title.textColor = WJColorDardGray3;
    title.font = WJFont16;
    title.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:title];
    
    UILabel *dateL = [[UILabel alloc] initWithFrame:CGRectMake(ALD(12), title.bottom + ALD(5), kScreenWidth - ALD(24), ALD(20))];
    dateL.text = @"2017-03-25";
    dateL.font = WJFont10;
    dateL.textColor = WJColorDardGray9;
    [self.view addSubview:dateL];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(12), dateL.bottom + ALD(10), kScreenWidth - ALD(24), (kScreenWidth - ALD(24) * 0.6))];
    imageView.backgroundColor = WJRandomColor;
    [self.view addSubview:imageView];
    
    UILabel *contentL=[[UILabel alloc]init];
    [contentL setText:@"dfhdksajfhakdskjfhjkash fdajshfkfhdskdhgd fasdkhjfjkdsahfjksafh fadskghkadsga fdaskhfaskhf fdasjhfkasdfhk dfsakfhkadshgkfa dsafsahfladsflkas fdasfhdsakhflkadsfalk fdsakhfkashfklashlashflashdfd fdshfkashfadsk fdsahfdsakhdksa fdsakjfhjask ewrjwkjhkjdfhaksjcfdf fdasjkhfdakshfkjaasd dfsakfhdask fdsakjfhaksdjhf fasdkfhdask fashkfda "];
    contentL.font = WJFont14;
    contentL.numberOfLines = 0;
    contentL.textColor = WJColorDardGray6;
    contentL.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGRect txtFrame = contentL.frame;
    txtFrame.size.height =[contentL.text boundingRectWithSize:CGSizeMake(kScreenWidth- ALD(24), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:contentL.font,NSFontAttributeName, nil] context:nil].size.height;
    contentL.frame = CGRectMake(ALD(12), imageView.bottom + ALD(15), kScreenWidth - ALD(24), txtFrame.size.height);
    
    [self.view addSubview:contentL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
