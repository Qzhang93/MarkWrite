//
//  SettingTableViewCell.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/2.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section row:(NSInteger)row
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUIWithSection:section withRow:row];
    }
    return self;
}

- (void)setupUIWithSection:(NSInteger)section withRow:(NSInteger)row {
    _switchButton = [[UISwitch alloc] initWithFrame:AAdaptionRect(600, 15, 100, 80)];
    _switchButton.hidden = YES;
    NSString *string = [NSString stringWithFormat:@"%ld.%ld",section,row];
    NSLog(@"%f",string.floatValue);
    _switchButton.tag = section + row;
    [_switchButton setOn:NO];
    [_switchButton addTarget:self action:@selector(switchButtonAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_switchButton];
}

- (void)switchButtonAction:(UISwitch *)sender {
    [self.delegate cellSwitchClick:sender];
}


@end
