//
//  SettingTableViewCell.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/2.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUIWithSection:section];
    }
    return self;
}

- (void)setupUIWithSection:(NSInteger)section {
    _switchButton = [[UISwitch alloc] initWithFrame:AAdaptionRect(600, 15, 100, 80)];
    _switchButton.hidden = YES;
    NSString *string = [NSString stringWithFormat:@"%ld",section];
    NSLog(@"%f",string.floatValue);
    _switchButton.tag = string.floatValue;
    [_switchButton setOn:NO];
    [_switchButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_switchButton];
}

- (void)switchButtonAction:(UISwitch *)sender {
    [self.delegate cellSwitchClick:sender];
}


@end
