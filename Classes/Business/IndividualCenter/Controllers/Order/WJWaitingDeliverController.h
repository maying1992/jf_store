//
//  WJWaitingDeliverController.h
//  jf_store
//
//  Created by reborn on 17/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJViewController.h"
#import "WJOrderManagerControllerDelegate.h"
@interface WJWaitingDeliverController : WJViewController
@property(nonatomic,strong)WJRefreshTableView *tableView;
@property(nonatomic,weak) id<WJOrderManagerControllerDelegate> delegate;
@end
