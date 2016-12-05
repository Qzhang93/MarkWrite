//
//  QWPTools.m
//  TongHuoMaMa
//
//  Created by 彭启伟 on 16/11/14.
//  Copyright © 2016年 yejiajun. All rights reserved.
//

#import "QWPTools.h"

@implementation QWPTools

+(void)showMessageWithTitle:(NSString *)title
                    content:(NSString *)content{
    [self showMessageWithTitle:title content:content buttonTitles:@[@"确定"] clickedHandle:nil];
}

+ (void)showMessageWithTitle:(NSString *)title
                     content:(NSString *)content
                buttonTitles:(NSArray<NSString *> *)titles
               clickedHandle:(void (^)(NSInteger))clickedButton
            compeletedHandle:(void (^)())handle{
    if (title == nil) {
        title = @"";
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIViewController *currentVC = [self keyViewController];
    NSInteger index = 0;
    for (NSString *buttonTitle in titles) {
        [alertVC addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (clickedButton != nil) {
                clickedButton(index);
            }
        }]];
        ++index;
    }
    [currentVC presentViewController:alertVC animated:YES completion:^{
        if (handle != nil) {
            handle();
        }
    }];
}

+ (void)showMessageWithTitle:(NSString *)title
                     content:(NSString *)content
                buttonTitles:(NSArray <NSString *> *)titles
               clickedHandle:(void(^)(NSInteger index))clickedButton {
    [self showMessageWithTitle:title content:content buttonTitles:titles clickedHandle:clickedButton compeletedHandle:nil];
}

+ (void)showMessageWithTitle:(NSString *)title
                     content:(NSString *)content
                 disMissTime:(NSTimeInterval)time {
    if (title == nil) {
        title = @"";
    }
    if (time == 0) {
        time = 0.75f;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIViewController *currentVC = [self keyViewController];
    [currentVC presentViewController:alertVC animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertVC dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

+ (UIViewController *)keyViewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    return vc;
}

@end
