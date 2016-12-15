//
//  EditViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "EditViewController.h"
#import "SecondaryKeyboardView.h"

@interface EditViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *editView;

@property (nonatomic, strong) SecondaryKeyboardView *secondKeyboard;

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

- (void)viewWillAppear:(BOOL)animated{
    
    _secondKeyboard.hidden = ![[NSUserDefaults standardUserDefaults] boolForKey:@"aKeyboredStatus"];
}

#pragma mark - UserInterface
- (void)setUserInterface{
    
    self.title = _fileTitle;
    
    UIBarButtonItem *previewBtn = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(previewAction)];
    self.navigationItem.rightBarButtonItem = previewBtn;
    
    //主视图
    _editView = [[UITextView alloc] initWithFrame:self.view.frame];
    _editView.delegate = self;
    [self.view addSubview:_editView];
    
    //辅助键盘
    _secondKeyboard = [[SecondaryKeyboardView alloc] initWithFrame:AAdaptionRect(0, 250, 750, 85) grammar:^(UIButton *sender) {
        
        [self grammarChoose:sender.tag];
    }];
    
    _editView.inputAccessoryView = _secondKeyboard;
    
    
}
#pragma mark - UITextViewDelegate
//textView中文本改变时保存文件
- (void)textViewDidChange:(UITextView *)textView {
    
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
            
        //tab
        case 0:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //#
        case 1:
        {
            NSLog(@"%ld",index);
        }
            break;
          
        //link
        case 2:
        {
            NSLog(@"%ld",index);
        }
            break;
          
        //Img
        case 3:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //Space
        case 4:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //*
        case 5:
        {
            NSLog(@"%ld",index);
        }
            break;
        
        //>
        case 6:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //-
        case 7:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //~~
        case 8:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        //[ ]
        case 9:
        {
            NSLog(@"%ld",index);
        }
            break;
            
        default:
            break;
    }
}

- (void)hideSecondaryKeyboard{
    
    _secondKeyboard.hidden = YES;
}

- (void)showSecondaryKeyboard{
    
    _secondKeyboard.hidden = NO;
}


@end
