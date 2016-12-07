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
    
    //logo
    _logoImageView = [[UIImageView alloc] initWithFrame:AAdaptionRect(275, 120, 200, 200)];
    _logoImageView.backgroundColor = COLOR(cyanColor);
    _logoImageView.layer.cornerRadius = 10;
    [self.view addSubview:_logoImageView];
    //版本
<<<<<<< HEAD
    _version = [[UILabel alloc] initWithFrame:AAdaptionRect(0, 340, 750, 30)];
=======
    _version = [[UILabel alloc] initWithFrame:AAdaptionRect(275, 340, 200, 30)];
>>>>>>> f96caf89b84e3de0091abfa90859ddfcd311acde
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
    _introduce.text = @"        MarkWrite是一款iOS平台上的Markdown文本编辑工具，界面简洁干净，支持iCloud同步，支持标准的Markdown语法。这款App的主要功能及用途就是为用户提供一个简单快捷的方式来将自己所想表述的文字或者图片记录下来，方便用户分享，同时多种导出格式也让用户有更多的选择。我们本着一颗开发出最优秀的软件的心，为您提供最优质的服务，给您带来不一样的用户体验。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_introduce.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_introduce.text length])];
    _introduce.attributedText = attributedString;
    CGSize expectSize = [LabelSizeToFit getWidthWithLabel:_introduce maxSize:AAdaptionSize(670, 9999)];
    _introduce.frame = AAdaptionRect(40, 400, 670, expectSize.height * 2);
    [self.view addSubview:_introduce];
    //联系方式
    _contact = [[UILabel alloc] init];
    _contact.textColor = COLOR(blackColor);
    _contact.textAlignment = NSTextAlignmentLeft;
    _contact.font = AAFont(24);
    _contact.text = @"联系方式";
    CGSize contactSize = [LabelSizeToFit getWidthWithLabel:_contact maxSize:AAdaptionSize(200, 30)];
    _contact.frame = AAdaptionRect(40, 700, contactSize.width * 2, 30);
    [self.view addSubview:_contact];
    //邮箱、电话
    NSArray *email = @[@"390242198@qq.com",@"295649322@qq.com"];
    for (NSInteger index = 0; index < 2; index ++) {
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:AAdaptionRect(40, 834 + 79 * index, 670, 80)];
        emailLabel.textAlignment = NSTextAlignmentCenter;
        emailLabel.textColor = RGBCOLOR(89, 89, 89, 1.0);
        emailLabel.font = AAFont(24);
        emailLabel.layer.borderWidth = 1.0;
        emailLabel.layer.borderColor = RGBCOLOR(230, 230, 230, 1.0).CGColor;
        emailLabel.text = email[index];
        [self.view addSubview:emailLabel];
        
        NSArray *tel = @[@"11111111111",@"22222222222"];
        UILabel *telephone = [[UILabel alloc] initWithFrame:AAdaptionRect(40 + 334 * index, 760, 335, 75)];
        telephone.textAlignment = NSTextAlignmentCenter;
        telephone.textColor = RGBCOLOR(89, 89, 89, 1.0);
        telephone.font = AAFont(24);
        telephone.layer.borderWidth = 1.0;
        telephone.layer.borderColor = RGBCOLOR(230, 230, 230, 1.0).CGColor;
        telephone.text = tel[index];
        [self.view addSubview:telephone];
    }
    
}

@end
