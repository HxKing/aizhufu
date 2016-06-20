//
//  KKHomeViewController.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKHomeViewController.h"
#import "KKHttpTool.h"
#import "XMLDictionary.h"
#import "SVProgressHUD.h"
#import "KKHomeItem.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "KKHomeCell.h"
#import "MJRefresh.h"
#import "KKOneItemsTableView.h"
#import "UIButton+WebCache.h"


@interface KKHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *topLeft_btn;

@property (weak, nonatomic) IBOutlet UIButton *topRight_btn;

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

/** dataArray */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 记录随机值 */
@property (nonatomic, assign) NSInteger num;

@end

@implementation KKHomeViewController

static NSString * const homeCellID = @"homeCell";

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [self setupTableView];
}

- (void)setupTableView{
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.contentTableView.tableFooterView = [[UIView alloc] init];
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKHomeCell class]) bundle:nil] forCellReuseIdentifier:homeCellID];
    
    self.contentTableView.dataSource = self;
    self.contentTableView.delegate = self;
    
//    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsStatce)];
    [self.contentTableView.mj_header beginRefreshing];
}

- (void)loadNewsStatce{

    [KKHttpTool get:@"http://211.155.224.10:8087/iphone/findSubjectList.jhtml?lastUpdateTime=0" parame:nil success:^(id result) {
        
        self.dataArray = [KKHomeItem mj_objectArrayWithKeyValuesArray:result[@"subject"]];
        
        [self setupTopImgBtn:self.topLeft_btn];
        [self setupTopImgBtn:self.topRight_btn];

        [self.contentTableView.mj_header endRefreshing];
        [self.contentTableView reloadData];
        
    } failure:^(NSError *error) {
        [self.contentTableView.mj_header endRefreshing];

        NSLog(@"%@",error);
    }];
}


- (void)setupTopImgBtn:(UIButton *)btn{
    
    KKHomeItem *i;
    NSUInteger a;
    self.num = -1;
    do {
        a = arc4random_uniform((int32_t)self.dataArray.count);
        
        if (self.dataArray.count) {
            i = self.dataArray[a];
        }
        
    } while (i.icon_big==nil || self.num == a);
    self.num = a;
    
    [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:i.icon_big] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"maintop"]];
   
}
#pragma mark - uitable View data
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
    
    cell.homeItem = self.dataArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKHomeItem *item = self.dataArray[indexPath.row];
    
    KKOneItemsTableView *oneItems = [[KKOneItemsTableView alloc] init];
    oneItems.item = item;
    oneItems.title = @"详情";
    
    [self.navigationController pushViewController:oneItems animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (IBAction)topLeft_click:(UIButton *)sender {
}

- (IBAction)topRight_click:(UIButton *)sender {
}

@end
