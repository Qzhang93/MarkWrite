//
//  PreviewViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserInterface];
}

#pragma mark - UserInterface
- (void)setUserInterface{
    
    self.title = _fileTitle;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithImage:IMGNAME(@"share") style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
}

#pragma mark - Button Action
- (void)saveAction{
    
    UIAlertController *saveAlert = [UIAlertController alertControllerWithTitle:@"选择保存的格式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *saveAsWeb = [UIAlertAction actionWithTitle:@"Web页面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self saveAsWebAction];
    }];
    UIAlertAction *saveAsMarkdown = [UIAlertAction actionWithTitle:@"Markdown文本" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self saveAsMarkdownAction];
    }];
    UIAlertAction *saveAsImage = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self saveAsImageAction];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [saveAlert addAction:saveAsWeb];
    [saveAlert addAction:saveAsMarkdown];
    [saveAlert addAction:saveAsImage];
    [saveAlert addAction:cancel];
    
    [self presentViewController:saveAlert animated:YES completion:nil];
}

- (void)saveAsWebAction{
    
    
}

- (void)saveAsMarkdownAction{
    
    
}

- (void)saveAsImageAction{
    
    
}


@end
