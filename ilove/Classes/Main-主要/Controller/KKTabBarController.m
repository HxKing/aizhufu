//
//  KKTabBarController.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "KKTabBarController.h"
#import "KKMoreController.h"
#import "KKSearchController.h"
#import "KKHomeViewController.h"
#import "KKCollectController.h"
#import "KKNavController.h"
#import "KKTabBar.h"
#import "UIView+Extension.h"

@interface KKTabBarController ()<UITabBarDelegate>

@end

@implementation KKTabBarController

+ (void)initialize
{
   
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSForegroundColorAttributeName] = [UIColor purpleColor];
    
    NSMutableDictionary *selectDic = [[NSMutableDictionary alloc] init];
    selectDic[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    KKTabBar *tabBar = [[KKTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];

    KKHomeViewController *home = [[KKHomeViewController alloc] init];
    [self addVc:home title:@"主页" image:@"icon_home" selectImage:@"icon_home" tag:1];
    
    KKCollectController *collect = [[KKCollectController alloc] init];
    [self addVc:collect title:@"收藏" image:@"icon_fav" selectImage:@"icon_fav" tag:2];
    
    KKSearchController *search = [[KKSearchController alloc] init];
    [self addVc:search title:@"搜索" image:@"icon_search" selectImage:@"icon_search" tag:3];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [board instantiateViewControllerWithIdentifier:@"moreController"];
//    KKMoreController *more = [[KKMoreController alloc] init];
    [self addVc:vc title:@"更多" image:@"icon_more" selectImage:@"icon_more" tag:4];
    
}

- (void)addVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage tag:(NSUInteger)tag{
    
    vc.title = title;
    // 放弃系统默认渲染方式，显示图片原本样式
//    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    vc.tabBarItem.tag = tag;
    
    KKNavController *nav = [[KKNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    KKTabBar *bar = (KKTabBar *)tabBar;
    
    [UIView animateWithDuration:.25 animations:^{
        
        bar.barTopView.x = [UIScreen mainScreen].bounds.size.width/4 * (item.tag - 1);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
