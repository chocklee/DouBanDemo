//
//  AppDelegate.m
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "AppDelegate.h"
#import "ActivityViewController.h"
#import "MovieViewController.h"
#import "CinemaViewController.h"
#import "UserTableViewController.h"
#import "DataBaseTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //打开数据库
    [[DataBaseTool shareDataBaseTool] openDataBase];
    //创建用户表
    [[DataBaseTool shareDataBaseTool] createTable:@"CREATE TABLE IF NOT EXISTS user (USER_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, USER_NAME TEXT, USER_PASSWORD TEXT, USER_EMAIL TEXT, USER_PHONE TEXT)"];
    //创建收藏表
    [[DataBaseTool shareDataBaseTool] createTable:@"CREATE TABLE IF NOT EXISTS activity (A_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, A_TITLE TEXT, A_TIME TEXT, A_NAME TEXT,A_CATEGORY TEXT, A_ADDRESS, A_CONTENT TEXT, A_IMAGEPHOTO BLOB, USER_ID INTEGER REFERENCES user (USER_ID))"];
    
    [[DataBaseTool shareDataBaseTool] createTable:@"CREATE TABLE IF NOT EXISTS movie (M_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, M_CONTENT TEXT, USER_ID INTEGER REFERENCES user (USER_ID))"];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //tabBar
    UITabBarController *tbc = [[UITabBarController alloc] init];
    //活动页面
    ActivityViewController *avc = [[ActivityViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:avc];
    //设置tabBarItem
    navc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"活动" image:[UIImage imageNamed:@"activity.png"] tag:101];
    
    //电影页面
    MovieViewController *mvc = [[MovieViewController alloc] init];
    UINavigationController *nmvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    //设置tabBarItem
    nmvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:[UIImage imageNamed:@"movie.png"] tag:101];
    
    //影院页面
    CinemaViewController *cvc = [[CinemaViewController alloc] init];
    UINavigationController *ncvc = [[UINavigationController alloc] initWithRootViewController:cvc];
    //设置tabBarItem
    ncvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"影院" image:[UIImage imageNamed:@"cinema.png"] tag:101];
    
    //我的页面
    UserTableViewController *uvc = [[UserTableViewController alloc] init];
    UINavigationController *nuvc = [[UINavigationController alloc] initWithRootViewController:uvc];
    //设置tabBarItem
    nuvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"user.png"] tag:101];
    
    tbc.viewControllers = @[navc,nmvc,ncvc,nuvc];
    self.window.rootViewController = tbc;
  
    return YES;
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
    //关闭数据库
    [[DataBaseTool shareDataBaseTool] closeDataBase];
}

@end
