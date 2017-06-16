//
//  WJGoodFriendsViewController.m
//  jf_store
//
//  Created by reborn on 2017/5/19.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJGoodFriendsViewController.h"
#import "WJMemberModel.h"
#import "BMChineseSort.h"
#import "WJRefreshTableView.h"
#import "WJMemberView.h"

#import "WJSysContactsManager.h"

@interface WJGoodFriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property(nonatomic,strong)WJRefreshTableView   *tableView;
@property(nonatomic,strong)NSMutableArray       *indexArray;        //排序后的出现过的首字母数组
@property(nonatomic,strong)NSMutableArray       *letterResultArray; //排序好的结果数组
@property(nonatomic,strong)WJMemberView         *memberView;
@property(nonatomic,strong)UIView               *maskView;
@property(nonatomic,strong)NSString             *selectPhoneNumber;

@property(nonatomic,strong)WJSysContactsManager *contactsManager;

@end

@implementation WJGoodFriendsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友";
    self.isHiddenTabBar = YES;
    
    [self loadData];
    
    self.indexArray = [BMChineseSort IndexWithArray:dataArray Key:@"name"];
    self.letterResultArray = [BMChineseSort sortObjectArray:dataArray Key:@"name"];
    
    [self.view addSubview:self.tableView];
    
}

-(void)loadData{
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"安迪",@"阿兰",
                            @"包贝尔",@"白凡",
                            @"蔡国庆",@"蔡明",
                            @"弟弟",@"弟子",
                            @"李白",@"张三",
                            @"重庆",@"重量",
                            @"调节",@"调用",
                            @"小白",@"小明",@"千珏",
                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",
                            nil];
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[stringsToSort count]; i++) {
        WJMemberModel *model = [[WJMemberModel alloc] init];
        model.name = [stringsToSort objectAtIndex:i];
        model.number = i;
        [dataArray addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section - 1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count] + 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [[self.letterResultArray objectAtIndex:section] count];
    
    if (section == 0) {
        return 2;
    } else {
        return [[self.letterResultArray objectAtIndex:section - 1] count];

    }
}

//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

//索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        
        return ALD(30);
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    for (UIView *subView in cell.contentView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        
        UIImageView *iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(ALD(12), (ALD(44) - ALD(25))/2, ALD(25), ALD(25))];
        iconIV.tag = 3001;
        [cell.contentView addSubview:iconIV];
        
        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(iconIV.right + ALD(10), 0, ALD(100), ALD(40))];
        nameL.tag = 3002;
        nameL.textColor = WJColorDardGray3;
        nameL.font = WJFont15;
        [cell.contentView addSubview:nameL];
        
        UIImage *arrawImage = [UIImage imageNamed:@"icon_arrow_right"];
        UIImageView *rightArrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - ALD(20) - arrawImage.size.width, (ALD(44) - arrawImage.size.height)/2, arrawImage.size.width, arrawImage.size.height)];
        rightArrowIV.image = arrawImage;
        [cell.contentView addSubview:rightArrowIV];
        
        if (indexPath.row == 0) {
            
            iconIV.image = [UIImage imageNamed:@"iPhoneFriends_icon"];
            nameL.text = @"邀请手机好友";
            
        } else {
            
            iconIV.image = [UIImage imageNamed:@"wechatFriends_icon"];
            nameL.text = @"邀请微信好友";

        }
        return cell;
        
    } else {
        
        WJMemberModel *model = [[self.letterResultArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        cell.textLabel.textColor = WJColorDardGray3;
        cell.textLabel.font = WJFont15;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {

            self.contactsManager = [WJSysContactsManager new];
            
            [self.contactsManager callContactsHandler:^(WJContactModel *contact) {
                
                NSLog(@"@@~~name : %@, phoneNumber: %@", contact.name, contact.phoneNumber);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.contactsManager sendContacts:@[contact.phoneNumber] message:@"This is a test" completion:^(WJMessageComposeResult result) {
                        NSLog(@"@@~~d : %ld", (long)result);
                    }];
                });
            }];

            
        } else {
            
        }
    } else {
        
        [self.view addSubview:self.maskView];
        [self.maskView addSubview:self.memberView];
    }
}

#pragma mark - Event Response
-(void)tapMaskViewgesture:(UITapGestureRecognizer*)tap
{
    [tap.view removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = ALD(30);
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


#pragma mark - setter/getter
-(WJRefreshTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[WJRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBarAndStatBarHeight) style:UITableViewStylePlain refreshNow:NO refreshViewType:WJRefreshViewTypeBoth];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = WJColorViewBg;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.sectionIndexColor = WJColorDardGray3;//设置默认时索引值颜色
    }
    return _tableView;
}

-(WJMemberView *)memberView
{
    if (!_memberView) {
        _memberView = [[WJMemberView alloc] initWithFrame:CGRectMake(ALD(24), (kScreenHeight - ALD(340))/2, kScreenWidth - ALD(48), ALD(340))];
        _memberView.backgroundColor = WJColorWhite;
        _memberView.layer.cornerRadius = 4;
        
    }
    return _memberView;
}

-(UIView *)maskView
{
    if (nil == _maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = WJColorBlack;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        UITapGestureRecognizer *tapGestureAddress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewgesture:)];
        [_maskView addGestureRecognizer:tapGestureAddress];
        
    }
    return _maskView;
}

@end
