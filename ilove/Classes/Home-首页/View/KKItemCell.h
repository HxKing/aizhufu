//
//  KKItemCell.h
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDetailItem.h"
@class KKItemCell;

@protocol KKItemCellDelegate <NSObject>

- (void)itemCellSendToMessage:(KKItemCell *)detailItem;

- (void)itemCellLoveMessage:(KKItemCell *)detailItem;
@end

@interface KKItemCell : UITableViewCell

/** moxing */
@property (nonatomic, strong) KKDetailItem *item;

@property (nonatomic, weak) id<KKItemCellDelegate> itemCellDelegate;


@end
