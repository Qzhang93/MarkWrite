//
//  PasswordView.h
//  MarkWrite
//
//  Created by 张琦 on 16/12/8.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                 isVerifyOpen:(BOOL)isVerifyOpen
                isOldPassword:(BOOL)isOldPassword
                isNewPassword:(BOOL)isNewPassword
                  isVerifyNew:(BOOL)isVerifyNew;

@property(nonatomic, strong) UILabel *first;

@property(nonatomic, strong) UILabel *second;

@property(nonatomic, strong) UILabel *third;

@property(nonatomic, strong) UILabel *fourth;

@property(nonatomic, strong) UITextField *inputPassword;

@property(nonatomic, strong) UILabel *errorOld;

@property(nonatomic, strong) UILabel *errorNew;

@end
