//
//  OpenViewController.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/9.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "OpenViewController.h"
#import "PasswordView.h"

@interface OpenViewController ()

@property(nonatomic, strong) PasswordView *openView;

@property(nonatomic, strong) NSString *password;

@end

@implementation OpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _openView = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:YES isOldPassword:NO isNewPassword:NO isVerifyNew:NO];
    [self.view addSubview:_openView];
}


@end
