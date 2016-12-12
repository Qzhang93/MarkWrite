//
//  AppDelegate.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"

@interface AppDelegate ()
@property (nonatomic, assign) NSNumber *pKeyboredStatus;
@property (nonatomic, assign) NSNumber *tKeyboredStatus;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MasterViewController *MasterVC = [[MasterViewController alloc] init];
    MasterVC.title = @"MarkWrite";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:MasterVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //导航栏设置
    nav.navigationBar.translucent = NO;
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AAFont(37),NSForegroundColorAttributeName:COLOR(whiteColor)}];
    nav.navigationBar.barTintColor = DOMINANTHUE;
    nav.navigationBar.tintColor = COLOR(whiteColor);
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //第一次启动
        //键盘状态
        NSUserDefaults *status = [NSUserDefaults standardUserDefaults];
        [status setBool:YES forKey:@"aKeyboredStatus"];
        [status setBool:NO forKey:@"pKeyboredStatus"];
        [status setBool:NO forKey:@"tKeyboredStatus"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"first" object:nil];
    }else{
        //不是第一次启动了
        
    }
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


@end
