//
//  SettingTableViewCell.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/2.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _switchView = [[UISwitch alloc] initWithFrame:AAdaptionRect(600, 13, 100, 80)];
    _switchView.hidden = YES;
    [self.contentView addSubview:_switchView];
}

@end
