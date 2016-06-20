//
//  KKCollectController.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKCollectController.h"
#import "SVProgressHUD.h"
#import "FMDB.h"
#import "KKLove.h"
#import "KKDetailItem.h"
#import "KKLoveCell.h"
//#import "UMSocial.h"

@interface KKCollectController ()<KKLoveCellDelegate>

/**   */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation KKCollectController

static NSString * const loveCell = @"love";

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showLoveData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
}
- (void)setupTableView{
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KKLoveCell class]) bundle:nil] forCellReuseIdentifier:loveCell];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - love cell delegate
- (void)loveCell:(KKLoveCell *)loveCell{
    
    NSLog(@"%@, %@, %@",loveCell,loveCell.item.parent_id,loveCell.item.id);
    
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
//    CGPoint pInView = [self.view convertPoint:loveCell.center fromView:loveCell];
    
    // 获取这一点的indexPath
//    NSIndexPath *indexPathNow = [loveCell indexPathForItemAtPoint:pInView];
    // 赋值给记录当前坐标的变量
    
//    NSLog(@"%@",NSStringFromCGPoint(pInView));

    
    KKDetailItem *item = loveCell.item;
    // 将cell 转为 NSIndexPath
    NSIndexPath *index = [self.tableView indexPathForCell:loveCell];
    
    NSLog(@"%@",index);

    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [doc stringByAppendingPathComponent:@"Collection.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    if ([db open]) {
        NSString *delete = [NSString stringWithFormat:@"delete from love where conid = '%@' and parent_id = '%@'",item.id,item.parent_id];
        
        BOOL de = [db executeUpdate:delete];
        
        if (de) {
            
            [self.dataArray removeObjectAtIndex:index.row];
            
            [self.tableView reloadData];
        }
    }
    [db close];

}

- (void)loveCellFenXiang:(KKLoveCell *)loveCell{
    NSLog(@"---");
    
    NSIndexPath *index = [self.tableView indexPathForCell:loveCell];
    KKDetailItem *item = self.dataArray[index.row];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56e8aac7e0f55abc36000516"
//                                      shareText:item.content
//                                     shareImage:nil
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
//                                       delegate:nil];
//    
    
}

- (void)showLoveData{
    [SVProgressHUD dismiss];
    
    // 获取docment文件夹路径
    NSString *string = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [string stringByAppendingPathComponent:@"Collection.sqlite"];
    
    // 获取数据库对象
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    // 数据源临时数组
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    // 打开数据库，返回bool
    if ([db open]) {
        
        // select 执行语句
        NSString *query = [NSString stringWithFormat:@"select content,icon_uri,parent_id,conid from love"];
        // 执行sql select 语句 返回数据对象
        FMResultSet *state = [db executeQuery:query];
    
        NSString *temp = nil;
        // 将“游标” 向下移动 有下一条数据，就返回true，否则返回0
        while ([state next]) {
            // 模型对象
            KKDetailItem *love = [[KKDetailItem alloc] init];
            // 获得具体值
            love.content = [state stringForColumn:@"content"];
            temp =[state stringForColumn:@"icon_uri"];
            love.icon_uri = [temp isEqualToString:@"(null)"] ? nil : temp;
            love.parent_id = [state stringForColumn:@"parent_id"];
            love.id = [state stringForColumn:@"conid"];
            [tempArray addObject:love];
        }
    }
    // 关闭数据库
    [db close];
    self.dataArray = tempArray;
    [self.tableView reloadData];
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KKLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:loveCell];
    
    cell.loveDelegate = self;
    
    
    cell.item = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKDetailItem *item = self.dataArray[indexPath.row];
    
    return item.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"--hahahhha-");
    
//    NSIndexPath *index = [self.tableView indexPathForCell:loveCell];
//    KKDetailItem *item = self.dataArray[indexPath.row];
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"56e8aac7e0f55abc36000516"
//                                      shareText:item.content
//                                     shareImage:nil
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,nil]
//                                       delegate:nil];
//
    
    
}



@end
