//
//  KKHomeItem.h
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKHomeItem : NSObject

/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 小图 */
@property (nonatomic, copy) NSString *icon_small;
/** ＝＝ */
@property (nonatomic, copy) NSString *contentLastUpdateTime;
/** 名字 */
@property (nonatomic, copy) NSString *id;
/** 大图url */
@property (nonatomic, copy) NSString *icon_big;
/** ＝ */
@property (nonatomic, copy) NSString *total_count;

//
//name = 情话送给有情人,
//icon_small = http://img.duanqu.com/weizhufu//20131011/0cefa2d4d86d4048a2e29602fe1ed805.jpg,
//contentLastUpdateTime = 1398753543327,
//id = 84,
//flag = 0,
//total_count = 254,
//icon_big = http://img.duanqu.com/weizhufu//20131010/5e1cfa1ec7cf40ccba1f03e7842694ab.jpg
@end
