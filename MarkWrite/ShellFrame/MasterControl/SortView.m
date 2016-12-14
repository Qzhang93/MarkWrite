//
//  SortView.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/14.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame{
    
//    CGRectMake(0, -AAdaption(181), SCREEN_W, AAdaption(181))
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR(lightGrayColor);
        
        //按时间排序
        _sortAsTime = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortAsTime.frame = CGRectMake(0, 0, frame.size.width, AAdaption(90));
        [_sortAsTime setTitle:@"按修改时间排序" forState:UIControlStateNormal];
        [_sortAsTime setTitleColor:COLOR(blackColor) forState:UIControlStateNormal];
        _sortAsTime.backgroundColor = COLOR(whiteColor);
        _sortAsTime.tag = 101;
        [self addSubview:_sortAsTime];
        //按名称排序
        _sortAsName = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortAsName.frame = CGRectMake(0, MAX_Y(_sortAsTime) + AAdaption(1), frame.size.width, GET_H(_sortAsTime));
        [_sortAsName setTitle:@"按文件名排序" forState:UIControlStateNormal];
        [_sortAsName setTitleColor:COLOR(blackColor) forState:UIControlStateNormal];
        _sortAsName.backgroundColor = COLOR(whiteColor);
        _sortAsName.tag = 102;
        [self addSubview:_sortAsName];
        
        _checkView = [[UIImageView alloc] initWithImage:IMGNAME(@"check")];
        _checkView.frame = AAdaptionRect(550, 25, 40, 40);
        [self addSubview:_checkView];
    }
    
    return self;
}


@end
