//
//  PasswordView.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/8.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "PasswordView.h"

@implementation PasswordView

- (instancetype)initWithFrame:(CGRect)frame isVerifyOpen:(BOOL)isVerifyOpen isOldPassword:(BOOL)isOldPassword isNewPassword:(BOOL)isNewPassword isVerifyNew:(BOOL)isVerifyNew
{
    self = [super initWithFrame:frame];
    if (self) {
       
        _inputPassword = [[UITextField alloc] initWithFrame:AAdaptionRect(0, 100, 750, 50)];
        _inputPassword.borderStyle = UITextBorderStyleNone;
        _inputPassword.keyboardType = UIKeyboardTypeNumberPad;
//        _inputPassword.hidden = YES;
        _inputPassword.delegate = self;
        [self addSubview:self.inputPassword];
        
        
        NSString *title;
        NSArray *titleArray = @[@"请输入密码", @"请输入旧密码", @"请输入新密码", @"验证新密码"];
        if (isVerifyOpen) {
            title = titleArray[0];
        }
        else if(isOldPassword) {
            title = titleArray[1];
        }
        else if (isNewPassword){
            title = titleArray[2];
        }
        else {
            title = titleArray[3];
        }
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:AAdaptionRect(0, 280, 750, 50)];
        [self addSubview:titleLabel];
        titleLabel.text = title;
        titleLabel.font = AAFont(33);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _first = [[UILabel alloc] initWithFrame:AAdaptionRect(204, 400, 42, 7)];
        [self addSubview:_first];
        _first.backgroundColor = COLOR(blackColor);
        
        _second = [[UILabel alloc] initWithFrame:AAdaptionRect(304, 400, 42, 7)];
        [self addSubview:_second];
        _second.backgroundColor = COLOR(blackColor);
        
        _third = [[UILabel alloc] initWithFrame:AAdaptionRect(404, 400, 42, 7)];
        [self addSubview:_third];
        _third.backgroundColor = COLOR(blackColor);
        
        _fourth = [[UILabel alloc] initWithFrame:AAdaptionRect(504, 400, 42, 7)];
        [self addSubview:_fourth];
        _fourth.backgroundColor = COLOR(blackColor);
        
        _errorOld = [[UILabel alloc] initWithFrame:AAdaptionRect(300, 500, 150, 50)];
        [self addSubview:_errorOld];
        _errorOld.text = @"密码错误";
        _errorOld.font = AAFont(25);
        _errorOld.textColor = COLOR(whiteColor);
        _errorOld.textAlignment = NSTextAlignmentCenter;
        _errorOld.backgroundColor = HEXCOLOR(0xB22222);
        _errorOld.layer.borderWidth = AAdaption(2);
        _errorOld.layer.borderColor = COLOR(blackColor).CGColor;
        _errorOld.layer.cornerRadius = AAdaption(25);
        _errorOld.clipsToBounds = YES;
        _errorOld.hidden = YES;
        
        _errorNew = [[UILabel alloc] initWithFrame:AAdaptionRect(0, 500, 750, 50)];
        [self addSubview:_errorNew];
        _errorNew.text = @"两次密码不一致，请重试";
        _errorNew.font = AAFont(28);
        _errorNew.textAlignment = NSTextAlignmentCenter;
        _errorNew.hidden = YES;
        
    }
    
    return self;
}


@end
