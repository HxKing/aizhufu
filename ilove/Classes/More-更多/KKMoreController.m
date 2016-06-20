//
//  KKMoreController.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKMoreController.h"
#import "SVProgressHUD.h"

@interface KKMoreController ()<UITableViewDelegate,UITableViewDataSource>


/** <#注释#> */
@property (nonatomic, strong) NSArray *dataArray;

@property (strong, nonatomic) IBOutlet UITableView *contentTv;




@end

@implementation KKMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentTv.tableFooterView = [[UIView alloc] init];
    
    
    
//    UITableView *tableView = [[UITableView alloc] init];
//    tableView.tableFooterView = [[UIView alloc] init];
//    
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.frame = [UIScreen mainScreen].bounds;
//    
//    tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
//    
//    self.view.backgroundColor = [UIColor orangeColor];
//    
//    [self.view addSubview:tableView];
//    
//    self.dataArray = @[@"意见反馈",@"意见反馈",@"意见反馈"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@ -- %ld",indexPath,indexPath.row);
    
    if (indexPath.row == 1) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"软件更新" message:@"有现版本，是否要下载?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            timeManger  = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(downloadFile) userInfo:nil repeats:YES];
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            

            
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

- (void)downloadFile
{
    
    static float i = 0;
    i+=0.2;
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showProgress:i status:@"正在下载..."];
    if (i >= 1) {
        i = 0;
        [timeManger invalidate];
        [SVProgressHUD dismiss];
    }
    
}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return self.dataArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"more"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"more"];
//    }
//    
//    cell.textLabel.text = self.dataArray[indexPath.row];
//    
//    return cell;
//}
//
//
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
