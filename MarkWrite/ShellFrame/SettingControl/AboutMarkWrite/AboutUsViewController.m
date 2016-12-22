//
//  AboutUsViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/2.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *version;

@property (nonatomic, strong) UILabel *introduce;

@property (nonatomic, strong) UILabel *contact;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)initUserInterface {
    self.view.backgroundColor = COLOR(whiteColor);
    self.title = @"关于";
    //隐藏导航栏返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault];
    //logo
    _logoImageView = [[UIImageView alloc] initWithFrame:AAdaptionRect(275, 120, 200, 200)];
    _logoImageView.image = IMGNAME(@"icon");
    _logoImageView.layer.cornerRadius = 10;
    [self.view addSubview:_logoImageView];
    //版本
    _version = [[UILabel alloc] initWithFrame:AAdaptionRect(0, 340, 750, 30)];
    _version = [[UILabel alloc] initWithFrame:AAdaptionRect(275, 340, 200, 30)];
    _version.textColor = RGBCOLOR(89, 89, 89, 1.0);
    _version.textAlignment = NSTextAlignmentCenter;
    _version.font = AAFont(22);
    _version.text = @"MarkWrite 1.0";
    [self.view addSubview:_version];
    //介绍
    _introduce = [[UILabel alloc] init];
    _introduce.textAlignment = NSTextAlignmentLeft;
    _introduce.textColor = _version.textColor;
    _introduce.font = AAFont(24);
    _introduce.numberOfLines = 0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"txt"];
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _introduce.text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_introduce.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_introduce.text length])];
    _introduce.attributedText = attributedString;
    CGSize expectSize = [LabelSizeToFit getWidthWithLabel:_introduce maxSize:AAdaptionSize(670, 9999)];
    _introduce.frame = AAdaptionRect(40, 400, 670, expectSize.height * 2 + 60);
    [self.view addSubview:_introduce];
    //联系方式
    _contact = [[UILabel alloc] init];
    _contact.textColor = COLOR(blackColor);
    _contact.textAlignment = NSTextAlignmentLeft;
    _contact.font = AAFont(24);
    _contact.text = @"联系方式";
    CGSize contactSize = [LabelSizeToFit getWidthWithLabel:_contact maxSize:AAdaptionSize(200, 30)];
    _contact.frame = AAdaptionRect(40, 725, contactSize.width * 3, 30);
    [self.view addSubview:_contact];
    //邮箱、电话
    NSArray *email = @[@"390242198@qq.com",@"295649322@qq.com"];
    for (NSInteger index = 0; index < 2; index ++) {
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:AAdaptionRect(40, 780 + 79 * index, 670, 80)];
        emailLabel.textAlignment = NSTextAlignmentCenter;
        emailLabel.textColor = RGBCOLOR(89, 89, 89, 1.0);
        emailLabel.font = AAFont(24);
        emailLabel.layer.borderWidth = 1.0;
        emailLabel.layer.borderColor = RGBCOLOR(230, 230, 230, 1.0).CGColor;
        emailLabel.text = email[index];
        [self.view addSubview:emailLabel];
    }
    
}

@end
