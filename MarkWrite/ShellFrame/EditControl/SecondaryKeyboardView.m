//
//  SecondaryKeyboardView.m
//  MarkWrite
//
//  Created by 张琦 on 16/12/7.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SecondaryKeyboardView.h"

#define TAG 200

@implementation SecondaryKeyboardView

- (instancetype)initWithFrame:(CGRect)frame grammar:(SecondaryKeyboardBlock)grammar
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.grammar = grammar;
        NSArray *grammarTitle = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MarkdownGrammar" ofType:@"plist"]];
        
        NSInteger count = grammarTitle.count;       /**< button数量 */
        CGFloat button_H = frame.size.height;       /**< button高度 */
        CGFloat button_W = frame.size.width / 8;    /**< button宽度 */
        
        for (NSInteger index = 0; index < count; index++) {
            
            UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(button_W * index, 0, button_W, button_H);
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            button.backgroundColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:0.5];
            button.tag = TAG + index;
            
            UILabel *title = [[UILabel alloc] initWithFrame:AAdaptionRect(11.875, 7.5, 70, 70)];
            [button addSubview:title];
            title.text = grammarTitle[index][@"grammarTitle"];
            title.font = AAFont(28);
            title.adjustsFontSizeToFitWidth = YES;
            title.layer.cornerRadius = AAdaption(7);
            title.clipsToBounds = YES;
            title.backgroundColor = COLOR(whiteColor);
            title.textAlignment = NSTextAlignmentCenter;
        }
        
        self.contentSize = CGSizeMake(button_W * count, 0);
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender{
    
    self.grammar(sender);
}


@end
