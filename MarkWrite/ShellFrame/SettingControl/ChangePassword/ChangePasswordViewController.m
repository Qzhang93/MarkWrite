//
//  ChangePasswordViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/7.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "PasswordView.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) PasswordView *changePassword;

@end

@implementation ChangePasswordViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    
     self.changePassword = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:NO isOldPassword:YES isNewPassword:NO isVerifyNew:NO];
    _changePassword.inputPassword.delegate = self;
    [self test];
    
    [self.view addSubview:_changePassword];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_changePassword.inputPassword becomeFirstResponder];
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    switch (range.location) {
        case 0:
        {
            NSLog(@"1");
        }
            break;
            
        case 1:
        {
            NSLog(@"2");
        }
            break;
            
        case 2:
        {
            NSLog(@"3");
        }
            break;
            
        case 3:
        {
            NSLog(@"4");
        }
            break;
            
        default:
            break;
    }
    
    if (range.location >= 4) {
        
        return NO;
    }
    return YES;
}

- (void)test{
    
    
}


@end
