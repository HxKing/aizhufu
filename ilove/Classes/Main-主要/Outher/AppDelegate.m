//
//  AppDelegate.m
//  ilove
//
//  Created by 王亚康 on 16/2/29.
//  Copyright © 2016年 王亚康. All rights reserved.
//

#import "AppDelegate.h"
#import "KKTabBarController.h"
#import "SVProgressHUD.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [UMSocialData setAppKey:@"56e8aac7e0f55abc36000516"];
    
    
    // 拷贝文件
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        [self copyFile];
    }];
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[KKTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


// 拷贝文件
- (void)copyFile{
    
    // 获取文件夹的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   
    // 拼接文件名
    NSString *path = [doc stringByAppendingPathComponent:@"Collection.sqlite"];
    
    // 获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 如果path路径中不存在该文件，就开始拷贝
    if (![fileManager fileExistsAtPath:path]) {
        // 获取项目中（bundle）中的sqlite文件
        NSString *score = [[NSBundle mainBundle] pathForResource:@"Collection" ofType:@"sqlite"];
        
        NSError *err;
        // 文件管理者拷贝文件 srcPath：原文件路径， dstPath：目标路径
        BOOL fileCopy = [fileManager copyItemAtPath:score toPath:path error:&err];
        
        fileCopy ? NSLog(@"数据库 拷贝 OK") : NSLog(@"数据库 拷贝 NO");
    }else{
        NSLog(@"数据库 已存在");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
