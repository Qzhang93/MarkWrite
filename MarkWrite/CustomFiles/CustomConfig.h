//
//  CustomConfig.h
//
//  Created by 张琦
//  Copyright © Qzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef CustomConfig_h
#define CustomConfig_h

//宽度，高度
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define GET_W(width) CGRectGetWidth(width.bounds)
#define GET_H(height) CGRectGetHeight(height.bounds)


//坐标
#define MID_X(x) CGRectGetMidX(x.frame)
#define MID_Y(y) CGRectGetMidY(y.frame)
#define MIN_X(x) CGRectGetMinX(x.frame)
#define MIN_Y(y) CGRectGetMinY(y.frame)
#define MAX_X(x) CGRectGetMaxX(x.frame)
#define MAX_Y(y) CGRectGetMaxY(y.frame)


//图片
#define IMGNAME(name) [UIImage imageNamed:name]
#define IMAGE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//颜色
#define RGBCOLOR(R,G,B,Alpha) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:Alpha]
#define COLOR(color) [UIColor color]
#define HEXCOLOR(hexColor) [UIColor colorWithHex:(long)hexColor]
#define DOMINANTHUE [UIColor colorWithRed:0.195 green:0.363 blue:0.620 alpha:1]


#endif
