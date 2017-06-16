//
//  WJMyMessageViewController.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJMyMessageViewController.h"
#import "WJSystemMessageCell.h"
#import "WJSystemMessageModel.h"
#import "WJPushMessageCell.h"
#import "WJPushMessageViewController.h"
#import "WJActivateViewController.h"
#import "WJGivingApplyViewController.h"
#import "WJBindingApplyViewController.h"
#import "WJRemoveBindingViewController.h"
@interface WJMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)WJRefreshTableView     *tableView;
@property (nonatomic, strong)NSMutableArray         *listArray;

@end

@implementation WJMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    self.isHiddenTabBar = YES;
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.listArray == nil || self.listArray.count == 0) {
        return 0;
    } else {
        return self.listArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJSystemMessageModel *model = [self.listArray objectAtIndex:indexPath.row];
    
    if (model.messageType == 1) {
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:WJFont14,NSFontAttributeName,nil];
        CGSize sizeText = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth - ALD(24), MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:dic context:nil].size;
        return sizeText.height + ALD(325);
    } else {
        
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:WJFont14,NSFontAttributeName,nil];
        CGSize sizeText = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth - ALD(24), MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:dic context:nil].size;
        return sizeText.height + ALD(150);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJSystemMessageModel *model = self.listArray[indexPath.row];
    
    if (model.messageType == 1) {
        WJPushMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pushMessageCellIdentifier"];
        if (nil == cell) {
            cell = [[WJPushMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pushMessageCellIdentifier"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configData:self.listArray[indexPath.row]];
        return cell;
        
    } else {
        
        WJSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemMessageCellIdentifier"];
        if (nil == cell) {
            cell = [[WJSystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"systemMessageCellIdentifier"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell configData:self.listArray[indexPath.row]];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJSystemMessageModel *model = self.listArray[indexPath.row];

    if (model.messageType == 1) {
        
        WJPushMessageViewController *pushMessageVC = [[WJPushMessageViewController alloc] init];
        [self.navigationController pushViewController:pushMessageVC animated:YES];
        
    } else if (model.messageType == 2) {
        
        WJActivateViewController *activateVC = [[WJActivateViewController alloc] init];
        [self.navigationController pushViewController:activateVC animated:YES];

        
    } else if (model.messageType == 4) {
        
        WJGivingApplyViewController *givingApplyVC = [[WJGivingApplyViewController alloc] init];
        [self.navigationController pushViewController:givingApplyVC animated:YES];

    } else if (model.messageType == 5) {
        
        WJBindingApplyViewController *bindingApplyVC = [[WJBindingApplyViewController alloc] init];
        [self.navigationController pushViewController:bindingApplyVC animated:YES];

    } else if (model.messageType == 6) {
        WJRemoveBindingViewController *removeBindingVC = [[WJRemoveBindingViewController alloc] init];
        [self.navigationController pushViewController:removeBindingVC animated:YES];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight)
                                                         style:UITableViewStylePlain
                                                    refreshNow:NO
                                               refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = WJColorViewBg2;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(NSMutableArray *)listArray
{
    if (!_listArray) {
//        _listArray = [NSMutableArray array];
        
        
        WJSystemMessageModel *model1 = [[WJSystemMessageModel alloc] init];
        model1.time = @"03:12";
        model1.title = @"推送消息";
        model1.date = @"2017-3-25";
        model1.content = @"推送内容";
        model1.messageType = 1;
        
        WJSystemMessageModel *model2 = [[WJSystemMessageModel alloc] init];
        model2.time = @"03:12";
        model2.title = @"激活申请";
        model2.date = @"2017-3-25";
        model2.content = @"李成，你好：\n用户编号K283222申请激活";
        model2.messageType = 2;
        
        
        WJSystemMessageModel *model3 = [[WJSystemMessageModel alloc] init];
        model3.time = @"03:12";
        model3.title = @"续费提醒";
        model3.date = @"2017-3-25";
        model3.content = @"李成，你好：\n您的交易大厅将于2017-6-25日到期，为方便您的正常使用请及时缴费";
        model3.messageType = 3;
        
        WJSystemMessageModel *model4 = [[WJSystemMessageModel alloc] init];
        model4.time = @"03:12";
        model4.title = @"赠送申请";
        model4.date = @"2017-3-25";
        model4.content = @"李成，你好：\n用户编号K283222申请赠送";
        model4.messageType = 4;
        
        
        WJSystemMessageModel *model5 = [[WJSystemMessageModel alloc] init];
        model5.time = @"03:12";
        model5.title = @"绑定申请";
        model5.date = @"2017-3-25";
        model5.content = @"李成，你好：\n用户编号K283222申请绑定消费服务中心";
        model5.messageType = 5;
        
        
        WJSystemMessageModel *model6 = [[WJSystemMessageModel alloc] init];
        model6.time = @"03:12";
        model6.title = @"解除绑定";
        model6.date = @"2017-3-25";
        model6.content = @"李成，你好：\n用户编号K283222解除绑定消费服务中心";
        model6.messageType = 6;
        
        _listArray = [NSMutableArray arrayWithObjects:model1,model2,model3,model4, model5,model6,nil];


    }
    return _listArray;
}


@end
