//
//  SetPasswordViewController.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/9.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "PasswordView.h"

@interface SetPasswordViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong) PasswordView *setView;

@property(nonatomic, strong) PasswordView *checkView;

@property(nonatomic, strong) NSString *password;

@property(nonatomic, strong) NSArray *array;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    _setView = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:NO isOldPassword:NO isNewPassword:YES isVerifyNew:NO];
    _setView.inputPassword.delegate = self;
    [self.view addSubview:_setView];
    
    _checkView = [[PasswordView alloc] initWithFrame:AAdaptionRect(750, 0, 750, 1334) isVerifyOpen:NO isOldPassword:NO isNewPassword:NO isVerifyNew:YES];
    _checkView.inputPassword.delegate = self;
    [self.view addSubview:_checkView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_setView.inputPassword becomeFirstResponder];
    
}

#pragma mark - Button Action
- (void)cancelAction{
    
    if (_isSet) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closePassword" object:nil];
    }
    [_checkView removeFromSuperview];
    [_setView removeFromSuperview];
    
    for (UIViewController *obj in self.navigationController.viewControllers) {
        if ([obj isKindOfClass:[SettingViewController class]]) {
            
            [self.navigationController popToViewController:obj animated:YES];
            break;
            
        }
    }
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _setView.inputPassword) {
        
        switch (range.location) {
            case 0:
            {
                _setView.first.hidden = !_setView.first.hidden;
                _setView.firstR.hidden = !_setView.firstR.hidden;
            }
                break;
                
            case 1:
            {
                _setView.second.hidden = !_setView.second.hidden;
                _setView.secondR.hidden = !_setView.secondR.hidden;
            }
                break;
                
            case 2:
            {
                _setView.third.hidden = !_setView.third.hidden;
                _setView.thirdR.hidden = !_setView.thirdR.hidden;
            }
                break;
                
            case 3:
            {
                _setView.fourth.hidden = !_setView.fourth.hidden;
                _setView.fourthR.hidden = !_setView.fourthR.hidden;
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    _setView.frame = AAdaptionRect(-750, 0, 750, 1334);
                    _checkView.frame = AAdaptionRect(0, 0, 750, 1334);
                } completion:^(BOOL finished) {
                    
                    _setView.errorNew.hidden = YES;
                    _password = _setView.inputPassword.text;
                    _setView.inputPassword.text = @"";
                    NSArray *array = @[_setView.first,_setView.second,_setView.third,_setView.fourth];
                    NSArray *arrayR = @[_setView.firstR,_setView.secondR,_setView.thirdR,_setView.fourthR];
                    for (UILabel *label in array) {
                        label.hidden = NO;
                    }
                    for (UILabel *labelR in arrayR) {
                        labelR.hidden = YES;
                    }
                    [_setView.inputPassword resignFirstResponder];
                    [_checkView.inputPassword becomeFirstResponder];
                }];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
    if (textField == _checkView.inputPassword) {
        
        switch (range.location) {
            case 0:
            {
                _checkView.first.hidden = !_checkView.first.hidden;
                _checkView.firstR.hidden = !_checkView.firstR.hidden;
            }
                break;
                
            case 1:
            {
                _checkView.second.hidden = !_checkView.second.hidden;
                _checkView.secondR.hidden = !_checkView.secondR.hidden;
            }
                break;
                
            case 2:
            {
                _checkView.third.hidden = !_checkView.third.hidden;
                _checkView.thirdR.hidden = !_checkView.thirdR.hidden;
            }
                break;
                
            case 3:
            {
                _checkView.fourth.hidden = !_checkView.fourth.hidden;
                _checkView.fourthR.hidden = !_checkView.fourthR.hidden;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if ([_password isEqualToString:_checkView.inputPassword.text]) {
                        
                        //保存密码
                        [[NSUserDefaults standardUserDefaults] setObject:_checkView.inputPassword.text forKey:@"password"];
                        //发送通知开启开关
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"openPassword" object:nil];
                        
                        
                        [_checkView removeFromSuperview];
                        [_setView removeFromSuperview];
                        
                        for (UIViewController *obj in self.navigationController.viewControllers) {
                            if ([obj isKindOfClass:[SettingViewController class]]) {
                                
                                [self.navigationController popToViewController:obj animated:YES];
                                break;
                                
                            }
                        }
                        
                    } else {
                        
                        [UIView animateWithDuration:0.3 animations:^{
                            
                            _setView.frame = AAdaptionRect(0, 0, 750, 1334);
                            _checkView.frame = AAdaptionRect(750, 0, 750, 1334);
                        } completion:^(BOOL finished) {
                            
                            _checkView.inputPassword.text = @"";
                            NSArray *array = @[_checkView.first,_checkView.second,_checkView.third,_checkView.fourth];
                            NSArray *arrayR = @[_checkView.firstR,_checkView.secondR,_checkView.thirdR,_checkView.fourthR];
                            for (UILabel *label in array) {
                                label.hidden = NO;
                            }
                            for (UILabel *labelR in arrayR) {
                                labelR.hidden = YES;
                            }
                            [_checkView.inputPassword resignFirstResponder];
                            [_setView.inputPassword becomeFirstResponder];
                            _setView.errorNew.hidden = NO;
                        }];
                    }
                });
            }
                break;
                
            default:
                break;
        }
    }
    
    if (range.location >= 4) {
        
        return NO;
    }
    return YES;
}


@end
