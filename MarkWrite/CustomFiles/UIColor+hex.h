//
//  UIColor+hex.h
//
//  Created by 张琦
//  Copyright © Qzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)

//16进制Color
+ (UIColor *)colorWithHex:(long)hexColor;

//16进制Color，有透明度
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
