//
//  KKOneItemsTableView.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKOneItemsTableView.h"
#import "KKHttpTool.h"
#import "MJExtension.h"
#import "KKDetailItem.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "KKItemCell.h"
#import <MessageUI/MessageUI.h>

@interface KKOneItemsTableView ()<KKItemCellDelegate,MFMessageComposeViewControllerDelegate>

/** 数据源数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 短信的id 用来加载更多数据 */
@property (nonatomic, strong) NSString *minId;

@end

@implementation KKOneItemsTableView

static NSString * const itemCell = @"itemCell";

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    
}

- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKItemCell class]) bundle:nil] forCellReuseIdentifier:itemCell];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatce)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewsStatce)];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)loadNewsStatce{
    
    NSString *urlString = [NSString stringWithFormat:@"http://211.155.224.10:8087/t/findSubjectContentList.jhtml?subjectId=%@&minId=0",self.item.id];
    
    [KKHttpTool get:urlString parame:nil success:^(id result) {
        
        [self.dataArray removeAllObjects];
        
        // 字典 转 模型
        NSArray *temp = [KKDetailItem mj_objectArrayWithKeyValuesArray:result[@"bless"]];
        
        [self.dataArray addObjectsFromArray:temp];
        
        // 存储最小id
        KKHomeItem *item = [self.dataArray lastObject];
        self.minId = item.id;
        
        // 展示数据
        [self.tableView reloadData];

        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        // 友好提示
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        NSLog(@"%@",error);
    }];
}

- (void)loadMoreStatce{

    NSString *urlString = [NSString stringWithFormat:@"http://211.155.224.10:8087/t/findSubjectContentList.jhtml?subjectId=%@&minId=%@",self.item.id,self.minId];
    NSLog(@"%@",urlString);
    [KKHttpTool get:urlString parame:nil success:^(id result) {
        NSLog(@"%@",result);
        
        NSArray *temp = [KKDetailItem mj_objectArrayWithKeyValuesArray:result[@"bless"]];
        NSLog(@"%@",temp);
        
        [self.dataArray addObjectsFromArray:temp];
        
        KKHomeItem *item = [self.dataArray lastObject];
        self.minId = item.id;
        
        [self.tableView reloadData];
        
        NSLog(@"%ld -- %ld",[result[@"total_count"] integerValue],self.dataArray.count);
        if ([result[@"total_count"] integerValue] == self.dataArray.count) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_footer endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"请求失败!"];
        
    }];

    
}

- (void)dealloc{
    // 停止所有网络请求
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = !self.dataArray.count;
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCell];
    
    cell.itemCellDelegate = self;
    cell.item = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    KKDetailItem *item = self.dataArray[indexPath.row];
    return item.cellHeight;
    
}


- (void)itemCellSendToMessage:(KKItemCell *)detailItem
{
    //发短信 不能设置短信内容
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"]];
    NSLog(@"====");
    //判断能否接收短信
    if (![MFMessageComposeViewController canSendText]) {
        return ;
    }
    
    //如果要设置内容，我使用MessageUI
    //1.创建MFMessageComposeViewController
    MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
    
    //设置电话
    msgVc.recipients = @[];
    
    //设置内容
    msgVc.body = detailItem.item.content;
    
    //设置代理
    msgVc.messageComposeDelegate = self;
    
    //显示信息界面
    [self presentViewController:msgVc animated:YES completion:nil];
}

#pragma mark 信息的代理方法
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //    MessageComposeResultCancelled,
    //    MessageComposeResultSent,
    //    MessageComposeResultFailed
    if (result == MessageComposeResultCancelled || result == MessageComposeResultSent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
