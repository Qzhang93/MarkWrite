//
//  addNewView.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/14.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "addNewView.h"

@implementation addNewView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = COLOR(whiteColor);
        self.layer.cornerRadius = frame.size.width * 0.03;
        self.clipsToBounds = YES;
        
        //保存路径选择
        _filePath = [[UISegmentedControl alloc] initWithItems:@[@"本地文件", @"iCloud文件"]];
        _filePath.frame = CGRectMake(frame.size.width / 6, AAdaption(40), frame.size.width * 2 / 3, frame.size.height * 0.05);
        _filePath.selectedSegmentIndex = 0;
        _filePath.tintColor = DOMINANTHUE;
        [self addSubview:_filePath];
        
        //文件名
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, AAdaption(145), frame.size.width / 5, frame.size.height * 0.07)];
        [self addSubview:label];
        label.text = @"文件名:";
        label.font = AAFont(30);
        label.textAlignment = NSTextAlignmentCenter;
        
        _fileName = [[UITextField alloc] initWithFrame:CGRectMake(MAX_X(label), MIN_Y(label), frame.size.width * 0.75, GET_H(label))];
        _fileName.layer.borderColor = [UIColor colorWithRed:0.902 green:0.898 blue:0.902 alpha:1].CGColor;
        _fileName.layer.borderWidth = AAdaption(1);
        _fileName.layer.cornerRadius = AAdaption(7);
        _fileName.clearButtonMode = UITextFieldViewModeWhileEditing;
        _fileName.autocorrectionType = UITextAutocorrectionTypeNo;
        _fileName.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _fileName.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_fileName];
        
        //取消
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancel.frame = CGRectMake(frame.size.width / 9, AAdaption(240), frame.size.width / 3, frame.size.height * 0.1);
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:COLOR(redColor) forState:UIControlStateNormal];
        _cancel.titleLabel.font = AAFont(40);
        [self addSubview:_cancel];
        
        //保存
        _save = [UIButton buttonWithType:UIButtonTypeCustom];
        _save.frame = CGRectMake(MAX_X(_cancel) + frame.size.width / 9, MIN_Y(_cancel), GET_W(_cancel), GET_H(_cancel));
        [_save setTitle:@"新建" forState:UIControlStateNormal];
        [_save setTitleColor:DOMINANTHUE forState:UIControlStateNormal];
        _save.titleLabel.font = AAFont(40);
        [self addSubview:_save];
    }
    
    return self;
}


@end
