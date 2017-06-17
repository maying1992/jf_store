//
//  WJIndividualCenterViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/3.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJIndividualCenterViewController.h"
#import "WJOrderTypeCollectionViewCell.h"
#import "WJIndivdualCollectionViewCell.h"
#import "WJIndivdualMoreCollectionViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "WJMyStoreViewController.h"
#import "WJLoginController.h"
#import <UIImageView+WebCache.h>
#import "WJAvatarView.h"
#import "WJIndividualInformationController.h"
#import "WJSettingViewController.h"

#import "APIIndividualCenterManager.h"
#import "WJIndividualCenterReformer.h"
#import "WJIndividualCenterModel.h"
#import "WJChargeOrderViewController.h"
#import "WJGivingOrderViewController.h"
#import "WJCreditsSwitchViewController.h"
#import "WJTradingOrderController.h"
#import "WJIndividualAllOrderController.h"
#import "WJRechargeCenterViewController.h"
#import "WJMyMessageViewController.h"
#import "WJShareMemberViewController.h"
#import "WJConsumerServicesProtocolViewController.h"
#import "WJBindindConsumerServicesCenterViewController.h"
#import "WJSwitchIntegralViewController.h"
#import "WJSettingTradePasswordViewController.h"

#import "WJIndividualWaitingPayViewController.h"
#import "WJIndividualWaitingDeliverViewController.h"
#import "WJIndividualWaitingReceiveViewController.h"
#import "WJIndividualFinishOrderViewController.h"
#import "WJIndividualRefundOrderViewController.h"
#import "WJIndividualAllOrderViewController.h"
#import "WJBondExchangeViewController.h"
#import "WJLotteryQueryViewController.h"
#import "WJApplyStoreViewController.h"
#import "WJGoodFriendsViewController.h"
#import "WJIntegralViewController.h"

#define kHeaderViewIdentifier               @"kHeaderViewIdentifier"
#define kHeaderViewDefaultIdentifier        @"kHeaderViewDefaultIdentifier"

#define kDefaultCellIdentifier              @"kDefaultCellIdentifier"
#define kOrderTypeCellIdentifier            @"kOrderTypeCellIdentifier"
#define kCollectionViewCellIdentifier       @"kCollectionViewCellIdentifier"
#define kMoreCollectionViewcellIdentifier   @"kMoreCollectionViewcellIdentifier"
#define HeaderViewHeight                    ALD(250)
@interface WJIndividualCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,WJIndivdualMoreCollectionViewCellDelagate,WJAvatarViewDelegate,APIManagerCallBackDelegate>
{
    UIImageView     *avatarImageView;
    UILabel         *phoneL;
}
@property(nonatomic,strong)UICollectionView           *collectionView;
@property(nonatomic,strong)NSArray                    *dataArray;
@property(nonatomic,strong)NSArray                    *orderTypeArray;
@property(nonatomic,strong)APIIndividualCenterManager *individualCenterManager;
@property(nonatomic,strong)WJIndividualCenterModel    *individualCenterModel;

@end

@implementation WJIndividualCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenBackBarButtonItem];
    [self navigationSetup];
    
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshIndividualCenter) name:kTabIndividualCenterRefresh object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView) name:@"IndividualCenterRefresh" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginRefresh) name:@"loginRefresh" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeadPortrait:) name:@"refreshHeadPortrait" object:nil];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)navigationSetup
{
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(0, 0, ALD(21), ALD(21));
    [settingButton setImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
}

-(void)refreshIndividualCenter
{
    [self.individualCenterManager loadData];
}


-(void)refreshView
{
    [self.collectionView reloadData];
}

-(void)loginRefresh
{
    [self.collectionView reloadData];

}

#pragma mark - APIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    if([manager isKindOfClass:[APIIndividualCenterManager class]])
    {
        self.individualCenterModel = [manager fetchDataWithReformer:[[WJIndividualCenterReformer alloc] init]];
        
        [self.collectionView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionViewDelegate/CollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
        
    } else if (section == 1) {
        return self.orderTypeArray.count;
        
    } else {
        return self.dataArray.count;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    
    if (section == 1) {
        
        WJOrderTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOrderTypeCellIdentifier forIndexPath:indexPath];
        
        NSDictionary * orderDic = [self.orderTypeArray  objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            
            [cell configDataWithIcon:orderDic[@"icon"] orderType:orderDic[@"text"] count:[NSString stringWithFormat:@"%ld",self.individualCenterModel.waitPayOrderCount]];
            
        } else if (indexPath.row == 1) {
            [cell configDataWithIcon:orderDic[@"icon"] orderType:orderDic[@"text"] count:[NSString stringWithFormat:@"%ld",self.individualCenterModel.waitDeliverOrderCount]];
            
        } else if (indexPath.row == 2) {
            [cell configDataWithIcon:orderDic[@"icon"] orderType:orderDic[@"text"] count:[NSString stringWithFormat:@"%ld",self.individualCenterModel.waitReceiveOrderCount]];

        } else if (indexPath.row == 3) {
            [cell configDataWithIcon:orderDic[@"icon"] orderType:orderDic[@"text"] count:[NSString stringWithFormat:@"%ld",self.individualCenterModel.finishOrderCount]];

        } else {
            [cell configDataWithIcon:orderDic[@"icon"] orderType:orderDic[@"text"] count:[NSString stringWithFormat:@"%ld",self.individualCenterModel.refundOrderCount]];
        }
        
        return cell;
        
    } else if (section == 2) {
        
        WJIndivdualCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
        
        NSDictionary * dic = [self.dataArray  objectAtIndex:indexPath.row];
        
        if (indexPath.row == 2) {
            cell.countL.hidden = NO;
        
            [cell configDataWithIcon:dic[@"icon"] Title:dic[@"text"] countString:[NSString stringWithFormat:@"%ld",self.individualCenterModel.messageCount]];
            
        }  else {
            cell.countL.hidden = YES;
            [cell configDataWithIcon:dic[@"icon"] Title:dic[@"text"] countString:@"0"];
        }
        
        return cell;
        
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];

    return cell;
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == 0) {
            
            UICollectionReusableView *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewIdentifier forIndexPath:indexPath];
            
            WJAvatarView *avatarView = [[WJAvatarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeaderViewHeight)];
            avatarView.backgroundColor = WJColorMainColor;
            [avatarView configDataWithCanUseCredits:self.individualCenterModel.creditsCount friendsCount:self.individualCenterModel.friendsCount];
            avatarView.delegate = self;
            [headerview addSubview:avatarView];
            
            return headerview;
            
        } else if (indexPath.section == 1) {
            
            WJIndivdualMoreCollectionViewCell *moreView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:kMoreCollectionViewcellIdentifier forIndexPath:indexPath];
            moreView.delegate = self;
            return moreView;
            
        } else if (indexPath.section == 2) {
            
            UICollectionReusableView * headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewDefaultIdentifier forIndexPath:indexPath];
            headerview.backgroundColor = WJColorViewBg;
            return headerview;
        }
        
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
    }
    
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    
    if (section == 0) {
        return CGSizeMake(0,0);
        
    } else if (section == 1) {
        
        return CGSizeMake(kScreenWidth/5,kScreenWidth/5);
        
    } else {
        
        return CGSizeMake(kScreenWidth,ALD(44));
    }
    
    return CGSizeMake(0,0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    } else if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    } else if (section == 2) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0.f;
        
    } else if (section == 1) {
        return 0.f;
        
    } else if (section == 2) {
        return 0.f;
        
    }
    
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return 0.f;
        
    } else if (section == 1) {
        return 0.f;
        
    } else if (section == 2) {
        return 0.f;
        
    }
    
    return 0.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return CGSizeMake(kScreenWidth, HeaderViewHeight);
        
    } else if (section == 1) {
        
        return CGSizeMake(kScreenWidth, ALD(44));
        
    } else if (section == 2) {
        
        return CGSizeMake(kScreenWidth, ALD(10));
        
    }
    
    return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section;
    NSUInteger index = indexPath.row;
    
    switch (section) {
        case 1:
        {
            switch (index) {
                case 0:
                {
                    if (USER_ID) {
                        
                        WJIndividualWaitingPayViewController *individualWaitingPayVC = [[WJIndividualWaitingPayViewController alloc] init];
                        [self.navigationController pushViewController:individualWaitingPayVC animated:YES];

                        
                    } else {
                        
                        WJLoginController *loginVC = [[WJLoginController alloc]init];
                        WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                        [self.navigationController presentViewController:nav animated:YES completion:nil];
                    }

                }
                    break;
                    
                case 1:
                    {
                        if (USER_ID) {
                            
//                            WJChargeOrderViewController *chargeOrderVC = [[WJChargeOrderViewController alloc] init];
//                            [self.navigationController pushViewController:chargeOrderVC animated:YES];
                            
                            WJIndividualWaitingDeliverViewController *individualWaitingDeliverVC = [[WJIndividualWaitingDeliverViewController alloc] init];
                            [self.navigationController pushViewController:individualWaitingDeliverVC animated:YES];

                            
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                        
                    }
                    break;
                case 2:
                    {
                        if (USER_ID) {
                            
                            
//                            WJGivingOrderViewController *givingOrderVC = [[WJGivingOrderViewController alloc] init];
//                            [self.navigationController pushViewController:givingOrderVC animated:YES];
                            
                            WJIndividualWaitingReceiveViewController *individualWaitingReceiveVC = [[WJIndividualWaitingReceiveViewController alloc] init];
                            [self.navigationController pushViewController:individualWaitingReceiveVC animated:YES];

                            
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                        
                    }
                    break;
                    
                    
                case 3:
                    {
                        if (USER_ID) {
//                            
//                            WJCreditsSwitchViewController *creditsSwitchVC = [[WJCreditsSwitchViewController alloc] init];
//                            [self.navigationController pushViewController:creditsSwitchVC animated:YES];
                            
//                            WJTradingOrderController *tradingOrderVC = [[WJTradingOrderController alloc] init];
//                            [self.navigationController pushViewController:tradingOrderVC animated:YES];
                            
                            WJIndividualFinishOrderViewController *individualFinishOrderVC = [[WJIndividualFinishOrderViewController alloc] init];
                            [self.navigationController pushViewController:individualFinishOrderVC animated:YES];

                          
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                        
                    }
                    break;
                    
                    
                case 4:
                {
                    if (USER_ID) {

//                        WJIndividualAllOrderController *individualAllOrderVC = [[WJIndividualAllOrderController alloc] init];
//                        [self.navigationController pushViewController:individualAllOrderVC animated:YES];
                        
                        WJIndividualRefundOrderViewController *individualRefundOrderVC =  [[WJIndividualRefundOrderViewController alloc] init];
                        [self.navigationController pushViewController:individualRefundOrderVC animated:YES];


                        
                    } else {
                        
                        WJLoginController *loginVC = [[WJLoginController alloc]init];
                        WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                        [self.navigationController presentViewController:nav animated:YES completion:nil];
                    }
                    
                }
                    break;
                    
                default:
                    break;
                }
            }
            break;
            
        case 2:
            {
                switch (index) {
                    case 0:
                    {
                        if (USER_ID) {
                            
                            WJMyStoreViewController *myStoreVC = [[WJMyStoreViewController alloc] init];
                            [self.navigationController pushViewController:myStoreVC animated:YES];
                            
//                            WJApplyStoreViewController *applyStoreVC = [[WJApplyStoreViewController alloc] init];
//                            [self.navigationController pushViewController:applyStoreVC animated:YES];

                            
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                            
                        }
                    }
                        break;
                        
                    case 1:
                    {
                        if (USER_ID) {
                            
                            WJRechargeCenterViewController *rechargeCenterVC = [[WJRechargeCenterViewController alloc] init];
                            [self.navigationController pushViewController:rechargeCenterVC animated:YES];
                            
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                    }
                        break;
                        
                    case 2:
                    {
                        if (USER_ID) {
                            
                            WJMyMessageViewController *myMessageVC = [[WJMyMessageViewController alloc] init];
                            [self.navigationController pushViewController:myMessageVC animated:YES];
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                    }
                        
                        break;
                        
                    case 3:
                    {
                        if (USER_ID) {
                            
                            WJShareMemberViewController *shareMemberVC = [[WJShareMemberViewController alloc] init];
                            [self.navigationController pushViewController:shareMemberVC animated:YES];
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                            
                        }
                    }
                        break;
                    case 4:
                    {
                        WJBindindConsumerServicesCenterViewController *bindindConsumerServicesCenterVC = [[WJBindindConsumerServicesCenterViewController alloc] init];
//                        bindindConsumerServicesCenterVC.serviceCode = @"1111";
                        [self.navigationController pushViewController:bindindConsumerServicesCenterVC animated:YES];

                    }
                        break;
                        
                    case 5:
                    {
                        if (USER_ID) {
                            
                            WJConsumerServicesProtocolViewController *consumerServicesProtocolVC = [[WJConsumerServicesProtocolViewController alloc] init];
                            [self.navigationController pushViewController:consumerServicesProtocolVC animated:YES];
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                    }
                        break;
                        
                        case 6:
                    {
                        WJSwitchIntegralViewController *switchIntegralVC = [[WJSwitchIntegralViewController alloc] init];
                        [self.navigationController pushViewController:switchIntegralVC animated:YES];

                    }
                        break;
                        
                        case 7:
                    {
                        if (USER_ID) {
                            
                            WJSettingTradePasswordViewController *settingTradePasswordVC = [[WJSettingTradePasswordViewController alloc] init];
                            [self.navigationController pushViewController:settingTradePasswordVC animated:YES];
                            
                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                    }
                        break;
                        
                    case 8:
                    {
                        if (USER_ID) {
                            
                            WJBondExchangeViewController *bondExchangeVC = [[WJBondExchangeViewController alloc] init];
                            [self.navigationController pushViewController:bondExchangeVC animated:YES];

                        } else {
                            
                            WJLoginController *loginVC = [[WJLoginController alloc]init];
                            WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
                            [self.navigationController presentViewController:nav animated:YES completion:nil];
                        }
                    }
                        break;
                        
                    case 9:
                    {
                        WJLotteryQueryViewController *lotteryQueryVC = [[WJLotteryQueryViewController alloc] init];
                        [self.navigationController pushViewController:lotteryQueryVC animated:YES];

                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
            break;
            
        default:
            break;
        
    }
}

#pragma mark - WJAvatarViewDelegate
-(void)tapAvatar
{
    if (USER_ID) {
        
        WJIndividualInformationController *individualInformationVC = [[WJIndividualInformationController alloc] init];
        individualInformationVC.informationFrom = FromIndividualCenter;

        [self.navigationController pushViewController:individualInformationVC animated:YES];
        
    } else {
        
        WJLoginController *loginVC = [[WJLoginController alloc]init];
        WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}


-(void)tapCredits
{
    WJIntegralViewController *integralVC = [[WJIntegralViewController alloc] init];
    [self.navigationController pushViewController:integralVC animated:YES];
}

-(void)tapFriends
{
    WJGoodFriendsViewController *goodFriendsVC = [[WJGoodFriendsViewController alloc] init];
    [self.navigationController pushViewController:goodFriendsVC animated:YES];

}
#pragma mark - WJIndivdualMoreCollectionViewCellDelagate
- (void)allTypeOrderCollectionViewCellWithClick
{
    if (USER_ID) {
        
        WJIndividualAllOrderViewController *individualAllOrderVC = [[WJIndividualAllOrderViewController alloc] init];
        [self.navigationController pushViewController:individualAllOrderVC animated:YES];
        
    } else {
        
        WJLoginController *loginVC = [[WJLoginController alloc]init];
        WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark - Action
- (void)settingButtonAction
{
    WJSettingViewController *settingVC = [[WJSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:NO];
}

-(void)refreshHeadPortrait:(NSNotification *)note
{
    avatarImageView.image = [note.userInfo objectForKey:@"head_portrait"];
    phoneL.text = note.userInfo[@"nick_name"] ? : note.userInfo[@"login_name"];
}


#pragma mark - setter属性
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -kNavigationBarHeight - kStatusBarHeight, kScreenWidth,  kScreenHeight + kNavigationBarHeight + kStatusBarHeight) collectionViewLayout:flowLayout];
        
        _collectionView.backgroundColor = WJColorWhite;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultCellIdentifier];
        
        //header
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewIdentifier];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewDefaultIdentifier];

        
        //订单类型cell
        [_collectionView registerClass:[WJOrderTypeCollectionViewCell class] forCellWithReuseIdentifier:kOrderTypeCellIdentifier];
        
        //中间cell
        [_collectionView registerClass:[WJIndivdualCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
        
        //全部订单cell
        [_collectionView registerClass:[WJIndivdualMoreCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMoreCollectionViewcellIdentifier];
        
    }
    return _collectionView;
}

- (NSArray *)dataArray
{
    if(nil==_dataArray)
    {
        _dataArray = @[@{@"icon":@"myCollection",@"text":@"个人店铺"},
                       @{@"icon":@"myCoupons",@"text":@"充值中心"},
                       @{@"icon":@"addressManage",@"text":@"我的消息"},
                       @{@"icon":@"aboutMe",@"text":@"分享会员"},
                       @{@"icon":@"aboutMe",@"text":@"绑定消费服务中心"},
                       @{@"icon":@"aboutMe",@"text":@"消费服务中心"},
                       @{@"icon":@"aboutMe",@"text":@"转积分"},
                       @{@"icon":@"aboutMe",@"text":@"积分交易密码"},
                       @{@"icon":@"aboutMe",@"text":@"债券兑换"},
                       @{@"icon":@"aboutMe",@"text":@"抽奖查询"}
                       ];
    }
    return _dataArray;
}

- (NSArray *)orderTypeArray
{
    if(nil == _orderTypeArray)
    {
        _orderTypeArray = @[@{@"icon":@"WaitPayOrder_icon",@"text":@"待付款"},
                            @{@"icon":@"waitDeliverOrder_icon",@"text":@"待发货"},
                            @{@"icon":@"waitReceiveOrder_icon",@"text":@"待收货"},
                            @{@"icon":@"finishOrder_icon",@"text":@"完成"},
                            @{@"icon":@"refundOrder_icon",@"text":@"退款"}
                            ];
    }
    return _orderTypeArray;
}

-(APIIndividualCenterManager *)individualCenterManager
{
    if (!_individualCenterManager) {
        _individualCenterManager = [[APIIndividualCenterManager alloc] init];
        _individualCenterManager.delegate = self;
    }
    _individualCenterManager.userID = USER_ID;
    return _individualCenterManager;
}

@end
