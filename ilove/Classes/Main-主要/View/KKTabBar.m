//
//  KKTabBar.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTabBar.h"
#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation KKTabBar

//- (UIView *)barTopView{
//    if (!_barTopView) {
//        _barTopView = [[UIView alloc] init];
//    }
//    return _barTopView;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_bottom"]];
        imgView.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 49);
        [self addSubview:imgView];
        
        UIView *view = [[UIView alloc] init];
        view.size = CGSizeMake([UIScreen mainScreen].bounds.size.width/4, 2);
        view.x = 0;
        view.y = 0;
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        
        self.barTopView = view;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    int i = 0 ;
//    for (UIView *subView in self.subviews) {
//        if (![subView isKindOfClass:NSClassFromString(@"UITabBarButton")])
//        continue;
//        subView.tag = ++i;
//        
//        NSLog(@"%@",subView.subviews);
//        
//        
//    }
}






@end
