//
//  KKDetailItem.m
//  ilove
//
//  Created by 王亚康 on 16/3/1.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKDetailItem.h"

@implementation KKDetailItem


- (void)setContent:(NSString *)content{
    _content = [content copy];
    if (!_cellHeight) {
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        CGFloat labelHeight = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        
        _cellHeight += labelHeight + 40 + 10 + 10 + 10;
        
    }
}

- (void)setIcon_uri:(NSString *)icon_uri{
    _icon_uri = [icon_uri copy];

    if (icon_uri) {
        _cellHeight += 100;
    }
    
}

@end
