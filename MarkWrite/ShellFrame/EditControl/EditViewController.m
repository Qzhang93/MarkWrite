//
//  EditViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "EditViewController.h"
#import "SecondaryKeyboardView.h"

@interface EditViewController ()

@end

@implementation EditViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(whiteColor);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self setUserInterface];
}

#pragma mark - UserInterface
- (void)setUserInterface{
    
    self.title = _fileTitle;
    
    UIBarButtonItem *previewBtn = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(previewAction)];
    self.navigationItem.rightBarButtonItem = previewBtn;
    
    //辅助键盘
    SecondaryKeyboardView *secondKeyboard = [[SecondaryKeyboardView alloc] initWithFrame:AAdaptionRect(0, 250, 750, 85) grammar:^(UIButton *sender) {
        
        [self grammarChoose:sender.tag];
    }];
    [self.view addSubview:secondKeyboard];
}

#pragma mark - Button Action
- (void)previewAction{
    
    PreviewViewController *previewVC = [[PreviewViewController alloc] init];
    previewVC.fileTitle = _fileTitle;
    [self.navigationController pushViewController:previewVC animated:YES];
}

- (void)grammarChoose:(NSInteger)tag{
    
    NSInteger index = tag - 200;
    switch (index) {
        case 0:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 1:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 2:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 3:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 4:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 5:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 6:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 7:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 8:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        case 9:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        default:
            break;
    }
}


@end
