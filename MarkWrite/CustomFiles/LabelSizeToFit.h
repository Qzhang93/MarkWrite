//
//  LabelSizeToFit.h
//  TongHuoMaMa
//
//  Created by 彭启伟 on 16/11/14.
//  Copyright © 2016年 yejiajun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelSizeToFit : NSObject

+ (CGSize)getWidthWithLabel:(UILabel *)label maxSize:(CGSize)maxSize;

@end
