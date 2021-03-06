//
//  PreviewViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PreviewViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserInterface];
    [self loadData];
}

#pragma mark - UserInterface
- (void)setUserInterface{
    
    self.title = _fileTitle;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithImage:IMGNAME(@"share") style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = save;
    
    _webView = [[UIWebView alloc] initWithFrame:AAdaptionRect(0, 0, 750, 1206)];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
}
//加载数据
- (void)loadData {
    NSURL * fileUrl = [NSURL fileURLWithPath:_filePath];
    NSString * markdownStr = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil];
    //    NSString * htmlString = [MMMarkdown HTMLStringWithMarkdown:markdownStr error:nil];
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdownStr extensions:MMMarkdownExtensionsGitHubFlavored error:nil];
    NSRange range = [htmlString rangeOfString:@"<img"];
    NSRange rang = [htmlString rangeOfString:@"alt="""];
    if (range.location != NSNotFound && rang.location != NSNotFound) {
        NSString *string = [NSString stringWithFormat:@"width = \"%f\"",AAdaption(600)];
        NSMutableString *muString = [[NSMutableString alloc] initWithString:htmlString];
        [muString insertString:string atIndex:rang.location + 7];
        NSLog(@"muString = %@",muString);
        [_webView loadHTMLString:muString baseURL:nil];
    } else {
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
}

#pragma mark - Button Action
- (void)saveAction{
    
    UIAlertController *saveAlert = [UIAlertController alertControllerWithTitle:@"选择保存的格式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self shareAction];
    }];
    UIAlertAction *saveAsImage = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self saveAsImageAction];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [saveAlert addAction:share];
    [saveAlert addAction:saveAsImage];
    [saveAlert addAction:cancel];
    
    [self presentViewController:saveAlert animated:YES completion:nil];
}

- (void)shareAction{
    
    UIActivityViewController *shareVC = [[UIActivityViewController alloc]initWithActivityItems:@[@"test"] applicationActivities:nil];
    [self presentViewController:shareVC animated:YES completion:^{
        
    }];
}

- (void)saveAsImageAction{
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContext(screenRect.size);
    UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        
        [QWPTools showMessageWithTitle:@"保存失败" content:nil disMissTime:0.5];
    } else {
        
        [QWPTools showMessageWithTitle:@"保存成功" content:nil disMissTime:0.5];
    }
}


@end
