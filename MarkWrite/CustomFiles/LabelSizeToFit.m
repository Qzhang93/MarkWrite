//
//  LabelSizeToFit.m
//  TongHuoMaMa
//
//  Created by 彭启伟 on 16/11/14.
//  Copyright © 2016年 yejiajun. All rights reserved.
//

#import "LabelSizeToFit.h"

@implementation LabelSizeToFit

+ (CGSize)getWidthWithLabel:(UILabel *)label maxSize:(CGSize)maxSize {
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = maxSize;
    CGSize expectSize = [label sizeThatFits:maximumLabelSize];
    return expectSize;
}

@end
