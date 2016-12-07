//
//  SecondaryKeyboardView.h
//  MarkWrite
//
//  Created by 张琦 on 16/12/7.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SecondaryKeyboardBlock)(UIButton *sender);

@interface SecondaryKeyboardView : UIScrollView

@property(nonatomic, copy) SecondaryKeyboardBlock grammar;

- (instancetype)initWithFrame:(CGRect)frame
                      grammar:(SecondaryKeyboardBlock)grammar;

@end
