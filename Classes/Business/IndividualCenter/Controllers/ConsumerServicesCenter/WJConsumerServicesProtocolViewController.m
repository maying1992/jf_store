//
//  WJConsumerServicesProtocolViewController.m
//  jf_store
//
//  Created by reborn on 17/5/17.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJConsumerServicesProtocolViewController.h"
#import "WJConsumerServicesPayViewController.h"
@interface WJConsumerServicesProtocolViewController ()

@end

@implementation WJConsumerServicesProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费服务中心";
    self.isHiddenTabBar = YES;
    [self setUI];
}

-(void)setUI
{
    UILabel *protocolL=[[UILabel alloc]init];
    [protocolL setText:@"根据国家监管部门最新规定，我们需要您配合完成实名认证。完成认证后您的资金将由平安银行担保，以保障您的账户资金安全。此信息只用于实名认证使用我们将严格保密请放心填写99戴假发或多卡说发说发所绿绿绿绿绿所所所所所所所所所所所所所所付黑群无一u东方时空发卡量司法局可拉伸机拉萨积分扣篮大赛就发大水立即付款拉萨积分拉丝机范德萨垃圾分类萨科技斐林试剂发送到绿军付绿卡所所所所所所所所所所所所军二无若群二无若热案发地奇偶程序集手动阀是登录范德萨绿发所绿扩扩扩绿绿或群二偶i反倒是所所所所所所所所所所所所所所撒付多扫奥多所付都放假萨拉丁军付付付付付付付付付付付付付付付覅所军寻次走军错女扩付多女扩所付军寻偶子的说法是打飞机了会计师对伐啦的飞洒拉近距离范德萨来激发大神来范德萨绿付军绿卡军多啦扩所军付扩扩扩扩扩扩扩扩扩扩扩扩扩绿。"];
    protocolL.font = WJFont14;
    protocolL.numberOfLines = 0;
    protocolL.textColor = WJColorDardGray6;
    protocolL.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGRect txtFrame = protocolL.frame;
    txtFrame.size.height =[protocolL.text boundingRectWithSize:CGSizeMake(kScreenWidth- ALD(24), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:protocolL.font,NSFontAttributeName, nil] context:nil].size.height;
    protocolL.frame = CGRectMake(ALD(12), ALD(10), kScreenWidth - ALD(24), txtFrame.size.height);
    
    [self.view addSubview:protocolL];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, kScreenHeight - kNavBarAndStatBarHeight - ALD(44), kScreenWidth, ALD(44));
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:WJColorWhite forState:UIControlStateNormal];
    confirmButton.backgroundColor = WJColorMainColor;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    
    
}

#pragma mark - Action
-(void)confirmButtonAction
{
    WJConsumerServicesPayViewController *consumerServicesPayVC = [[WJConsumerServicesPayViewController alloc] init];
    [self.navigationController pushViewController:consumerServicesPayVC animated:YES];
}

@end
