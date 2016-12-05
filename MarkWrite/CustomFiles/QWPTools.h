//
//  QWPTools.h
//  TongHuoMaMa
//
//  Created by 彭启伟 on 16/11/14.
//  Copyright © 2016年 yejiajun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QWPTools : NSObject

//消息展示
+ (void)showMessageWithTitle:(NSString * _Nullable)title
                     content:(NSString * _Nullable)content;
//消息展示后消失
+ (void)showMessageWithTitle:(NSString * _Nullable) title
                     content:(NSString * _Nullable)content
                 disMissTime:(NSTimeInterval)time;
//消息展示带按钮事件
+ (void)showMessageWithTitle:(NSString * _Nullable)title
                     content:(NSString * _Nullable)content
                buttonTitles:(NSArray <NSString *> * _Nullable)titles
               clickedHandle:(void(^ _Nullable)(NSInteger index))clickedButton;
//消失展示带按钮事件
+ (void)showMessageWithTitle:(NSString * _Nullable)title
                     content:(NSString * _Nullable)content
                buttonTitles:(NSArray <NSString *> * _Nullable)titles
               clickedHandle:(void(^ _Nullable)(NSInteger index))clickedButton
            compeletedHandle:(void(^ _Nullable)())handle;

//获取当前控制器
+ (UIViewController * _Nullable)keyViewController;

@end
