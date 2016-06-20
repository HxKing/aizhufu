//
//  KKNavController.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKNavController.h"
#import "UIView+Extension.h"

@interface KKNavController ()

@end

@implementation KKNavController

//+(void)initialize{
//    
//    UINavigationBar *item = [UINavigationBar appearance];
//    
//    // 按钮的颜色
//    item.tintColor = [UIColor redColor];
//    // 整个背景的颜色
//    item.barTintColor = [UIColor orangeColor];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    UINavigationBar *item = [UINavigationBar appearance];
    [item setTitleTextAttributes:dic];
    
    [item setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"back_hover"] forState:UIControlStateSelected];
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.size = CGSizeMake(50, 29);
//        btn.backgroundColor = [UIColor lightGrayColor];
        
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
        
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
//        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"haha" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
