//
//  OldPasswordViewController.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/9.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "OldPasswordViewController.h"
#import "PasswordView.h"

@interface OldPasswordViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) PasswordView *changePassword;

@end

@implementation OldPasswordViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    self.changePassword = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:NO isOldPassword:YES isNewPassword:NO isVerifyNew:NO];
    _changePassword.inputPassword.delegate = self;
    
    [self.view addSubview:_changePassword];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_changePassword.inputPassword becomeFirstResponder];
}

#pragma mark - Button Action
- (void)cancelAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    switch (range.location) {
        case 0:
        {
            _changePassword.first.hidden = !_changePassword.first.hidden;
            _changePassword.firstR.hidden = !_changePassword.firstR.hidden;
        }
            break;
            
        case 1:
        {
            _changePassword.second.hidden = !_changePassword.second.hidden;
            _changePassword.secondR.hidden = !_changePassword.secondR.hidden;
        }
            break;
            
        case 2:
        {
            _changePassword.third.hidden = !_changePassword.third.hidden;
            _changePassword.thirdR.hidden = !_changePassword.thirdR.hidden;
        }
            break;
            
        case 3:
        {
            _changePassword.fourth.hidden = !_changePassword.fourth.hidden;
            _changePassword.fourthR.hidden = !_changePassword.fourthR.hidden;
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

@end