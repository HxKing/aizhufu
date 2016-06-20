//
//  KKOneItemsTableView.h
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKHomeItem.h"

@interface KKOneItemsTableView : UITableViewController

/** 模型对象 */
@property (nonatomic, strong) KKHomeItem *item;

@end
