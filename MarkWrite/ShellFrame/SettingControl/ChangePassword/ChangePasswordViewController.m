//
//  ChangePasswordViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/7.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "PasswordView.h"

@interface ChangePasswordViewController ()

@property(nonatomic, strong) PasswordView *changePassword;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    
     self.changePassword = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:NO isOldPassword:YES isNewPassword:NO isVerifyNew:NO];
    
    [self.view addSubview:_changePassword];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_changePassword.inputPassword becomeFirstResponder];
}


@end
