//
//  WJShareMemberViewController.m
//  jf_store
//
//  Created by reborn on 17/5/16.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "WJShareMemberViewController.h"
#import "WJMemberModel.h"
#import "BMChineseSort.h"
#import "WJRefreshTableView.h"
#import "WJMemberView.h"
@interface WJShareMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}
@property(nonatomic,strong)WJRefreshTableView   *tableView;
@property(nonatomic,strong)NSMutableArray       *indexArray;        //排序后的出现过的首字母数组
@property(nonatomic,strong)NSMutableArray       *letterResultArray; //排序好的结果数组
@property(nonatomic,strong)WJMemberView         *memberView;
@property(nonatomic,strong)UIView               *maskView;


@end

@implementation WJShareMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享会员";
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
    return [self.indexArray objectAtIndex:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArray objectAtIndex:section] count];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
//    [tableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
//     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALD(44);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ALD(30);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    WJMemberModel *model = [[self.letterResultArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = WJColorDardGray3;
    cell.textLabel.font = WJFont15;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view addSubview:self.maskView];
    [self.maskView addSubview:self.memberView];
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
