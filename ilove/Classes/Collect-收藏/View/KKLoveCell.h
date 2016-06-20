//
//  KKLoveCell.h
//  ilove
//
//  Created by 王亚康 on 16/3/1.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDetailItem.h"
@class KKLoveCell;

@protocol KKLoveCellDelegate <NSObject>

- (void)loveCell:(KKLoveCell *)loveCell;
- (void)loveCellFenXiang:(KKLoveCell *)loveCell;

@end

@interface KKLoveCell : UITableViewCell

/** moxing */
@property (nonatomic, strong) KKDetailItem *item;

@property (nonatomic, weak) id<KKLoveCellDelegate> loveDelegate;


@end
