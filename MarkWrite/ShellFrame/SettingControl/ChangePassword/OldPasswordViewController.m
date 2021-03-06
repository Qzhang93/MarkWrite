//
//  OldPasswordViewController.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/9.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "OldPasswordViewController.h"
#import "SetPasswordViewController.h"
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openPassword" object:nil];
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
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (_isDelete) {
                    
                    if ([_changePassword.inputPassword.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]) {
                        
                        //删除密码
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                        
                        //关闭密码开关
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"closePassword" object:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    } else {
                        
                        _changePassword.errorOld.hidden = NO;
                        _changePassword.inputPassword.text = @"";
                        NSArray *array = @[_changePassword.first,_changePassword.second,_changePassword.third,_changePassword.fourth];
                        NSArray *arrayR = @[_changePassword.firstR,_changePassword.secondR,_changePassword.thirdR,_changePassword.fourthR];
                        for (UILabel *label in array) {
                            label.hidden = NO;
                        }
                        for (UILabel *labelR in arrayR) {
                            labelR.hidden = YES;
                        }
                    }
                    
                } else {
                    
                    if ([_changePassword.inputPassword.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]) {
                        
                        _changePassword.errorOld.hidden = YES;
                        SetPasswordViewController *setPasswordVC = [[SetPasswordViewController alloc] init];
                        setPasswordVC.isSet = NO;
                        [self.navigationController pushViewController:setPasswordVC animated:YES];
                    } else {
                        
                        _changePassword.errorOld.hidden = NO;
                        _changePassword.inputPassword.text = @"";
                        NSArray *array = @[_changePassword.first,_changePassword.second,_changePassword.third,_changePassword.fourth];
                        NSArray *arrayR = @[_changePassword.firstR,_changePassword.secondR,_changePassword.thirdR,_changePassword.fourthR];
                        for (UILabel *label in array) {
                            label.hidden = NO;
                        }
                        for (UILabel *labelR in arrayR) {
                            labelR.hidden = YES;
                        }
                    }
                }
                
            });
            
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
