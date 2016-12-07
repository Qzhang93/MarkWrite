//
//  SettingTableViewCell.h
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/2.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellSwitchClickDelegate <NSObject>

- (void)cellSwitchClick:(UISwitch *)sender;

@end

@interface SettingTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

@property (nonatomic, strong) UISwitch *switchButton;

@property (nonatomic, weak) id<CellSwitchClickDelegate>delegate;

@end
