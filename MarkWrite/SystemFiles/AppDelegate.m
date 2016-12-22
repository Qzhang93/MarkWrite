//
//  AppDelegate.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "AppDelegate.h"
#import "PasswordView.h"

@interface AppDelegate ()<UITextFieldDelegate>

@property (nonatomic, assign) NSNumber *pKeyboredStatus;

@property (nonatomic, assign) NSNumber *tKeyboredStatus;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) PasswordView *openView;

@property (nonatomic, strong) UIWindow *maskWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self creatRootViewControllerWith3Dtouch:NO];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"pKeyboredStatus"]) {
        [application.keyWindow addSubview:self.openView];
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self checkTouchID];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    switch (range.location) {
        case 0:
        {
            _openView.first.hidden = !_openView.first.hidden;
            _openView.firstR.hidden = !_openView.firstR.hidden;
        }
            break;
            
        case 1:
        {
            _openView.second.hidden = !_openView.second.hidden;
            _openView.secondR.hidden = !_openView.secondR.hidden;
        }
            break;
            
        case 2:
        {
            _openView.third.hidden = !_openView.third.hidden;
            _openView.thirdR.hidden = !_openView.thirdR.hidden;
        }
            break;
            
        case 3:
        {
            _openView.fourth.hidden = !_openView.fourth.hidden;
            _openView.fourthR.hidden = !_openView.fourthR.hidden;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if ([_openView.inputPassword.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]) {
                    
                    _openView.errorOld.hidden = YES;
                    _openView.inputPassword.text = @"";
                    NSArray *array = @[_openView.first,_openView.second,_openView.third,_openView.fourth];
                    NSArray *arrayR = @[_openView.firstR,_openView.secondR,_openView.thirdR,_openView.fourthR];
                    for (UILabel *label in array) {
                        label.hidden = NO;
                    }
                    for (UILabel *labelR in arrayR) {
                        labelR.hidden = YES;
                    }
                    [_openView removeFromSuperview];
                } else {
                    
                    _openView.errorOld.hidden = NO;
                    _openView.inputPassword.text = @"";
                    NSArray *array = @[_openView.first,_openView.second,_openView.third,_openView.fourth];
                    NSArray *arrayR = @[_openView.firstR,_openView.secondR,_openView.thirdR,_openView.fourthR];
                    for (UILabel *label in array) {
                        label.hidden = NO;
                    }
                    for (UILabel *labelR in arrayR) {
                        labelR.hidden = YES;
                    }
                }
                
            });
            
        }
            break;
            
        default:
            break;
    }
    
    if (range.location >= 4) {
        
        return NO;
    }
    return YES;
}

#pragma mark - touchID
- (void)checkTouchID{
    
    [_openView.inputPassword becomeFirstResponder];
    //验证touchID是否开启
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"tKeyboredStatus"]) {
        
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        //验证机器是否支持指纹识别
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹识别
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证指纹以解锁" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    //验证成功
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_openView removeFromSuperview];
                    });
                }
            }];
        }
    }
}

#pragma mark - 3Dtouch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    if ([shortcutItem.type isEqualToString:@"CreatNew"]) {
        
        [self creatRootViewControllerWith3Dtouch:YES];
        
    }
}

- (void)creatRootViewControllerWith3Dtouch:(BOOL)is3Dtouch{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MasterViewController *masterVC = [[MasterViewController alloc] init];
    masterVC.title = @"MarkWrite";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterVC];
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
    
    self.openView = [[PasswordView alloc] initWithFrame:[UIScreen mainScreen].bounds isVerifyOpen:YES isOldPassword:NO isNewPassword:NO isVerifyNew:NO];
    self.openView.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    _openView.inputPassword.delegate = self;
    
    if (is3Dtouch) {
        
        [masterVC addNewFile];
    }
}


@end
