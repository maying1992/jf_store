//
//  AppDelegate.m
//  jf_store
//
//  Created by XT Xiong on 2017/4/28.
//  Copyright © 2017年 JF. All rights reserved.
//

#import "AppDelegate.h"
#import "WJSqliteBaseManager.h"
#import "WJShareManager.h"


@interface AppDelegate ()
{
    BOOL isFirstLoadAfterInstalled;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    isFirstLoadAfterInstalled = [WJUtilityMethod whetherIsFirstLoadAfterInstalled];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tabBarController = [[WJTabBarController alloc]init];
    self.window.rootViewController = _tabBarController;
    [self.window makeKeyAndVisible];
    
    
    [self initDatabase];
    [self initWJShare];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Handle Url

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //分享回调
    [WJShareManager shareHandleOpenURL:url sourceApplication:sourceApplication];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    //分享回调
    [WJShareManager application:app openURL:url options:options];
    
    return YES;
}

#pragma mark - 初始化SDK
- (void)initWJShare
{
    //分享和支付共用
    [WJShareManager initShareEnviroment];
}

//所在地选择 地区表
- (void)initDatabase
{
    if(isFirstLoadAfterInstalled){
        [WJSqliteBaseManager copyBaseData];
    }
}


@end
