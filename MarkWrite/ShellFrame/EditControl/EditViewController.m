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
    if ([_openFile isEqualToString:@"openFile"]) {
        
    }else {
        [self saveFile];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_editView resignFirstResponder];
}

#pragma mark - UserInterface
- (void)setUserInterface{
    
    self.title = _fileTitle;
    
    UIBarButtonItem *previewBtn = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStyleDone target:self action:@selector(previewAction)];
    self.navigationItem.rightBarButtonItem = previewBtn;
    
    //主视图
    _editView = [[UITextView alloc] initWithFrame:self.view.frame];
    _editView.delegate = self;
    _editView.font = AAFont(32);
    if ([_openFile isEqualToString:@"openFile"]) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.md",_fileTitle]];
        NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        _editView.text = text;
        _filePath = filePath;
    }
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
    [self saveFile];
}
#pragma mark - Button Action
- (void)previewAction{
    
    PreviewViewController *previewVC = [[PreviewViewController alloc] init];
    previewVC.fileTitle = _fileTitle;
    previewVC.filePath = _filePath;
    [self.navigationController pushViewController:previewVC animated:YES];
}

- (void)grammarChoose:(NSInteger)tag{
    
    NSInteger index = tag - 200;
    switch (index) {
            
        //#
        case 0:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"#"];
        }
            break;
            
        //link
        case 1:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加链接" message:@"请输入链接以及要显示的文本" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
               textField.placeholder = @"请输入链接显示的文本(可选)";
            }];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
                textField.placeholder = @"请输入链接";
            }];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
               _editView.text = [NSString stringWithFormat:@"%@[%@](%@)",_editView.text,alert.textFields[0].text,alert.textFields[1].text];
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
          
        //img
        case 2:
        {
            
        }
            break;
          
        //space
        case 3:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"&nbsp;"];
        }
            break;
            
        //*
        case 4:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"*"];
        }
            break;
            
        //>
        case 5:
        {
            if (_editView.text.length == 0) {
                
                _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@">"];
            } else {
                
                if ([_editView.text hasSuffix:@">"]) {
                    
                    _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@">"];
                } else {
                    
                    _editView.text = [NSString stringWithFormat:@"%@\n%@",_editView.text,@">"];
                }
            }
        }
            break;
        
        //-
        case 6:
        {
            if (_editView.text.length == 0) {
                
                _editView.text = [NSString stringWithFormat:@"%@%@ ",_editView.text,@"-"];
            } else {
                
                _editView.text = [NSString stringWithFormat:@"%@\n%@ ",_editView.text,@"-"];
            }
        }
            break;
            
        //~~
        case 7:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"~~"];
        }
            break;
            
        //[]
        case 8:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"[]"];
        }
            break;
            
        //!
        case 9:
        {
            _editView.text = [NSString stringWithFormat:@"%@%@",_editView.text,@"!"];
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
//保存文本
- (void)saveFile {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *fileString = _editView.text;
    NSData *fileData = [fileString dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:_filePath contents:fileData attributes:nil];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    UIPreviewAction *renameAction = [UIPreviewAction actionWithTitle:@"重命名" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *deleteAction = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    return @[renameAction, deleteAction];
}

@end
