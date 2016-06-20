//
//  KKDetailItem.h
//  ilove
//
//  Created by 王亚康 on 16/3/1.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKDetailItem : NSObject

/** 类目 id */
@property (nonatomic, copy) NSString *parent_id;

/** 短信 id */
@property (nonatomic, copy) NSString *id;

/** 短信内容 */
@property (nonatomic, copy) NSString *content;

/** 短信类目 名称 */
@property (nonatomic, copy) NSString *parent_name;

/** 短信类目的图片地址 名称 */
@property (nonatomic, copy) NSString *icon_uri;


/** 辅助属性 **/
/** cell height  */
@property (nonatomic, assign) CGFloat cellHeight;



@end
