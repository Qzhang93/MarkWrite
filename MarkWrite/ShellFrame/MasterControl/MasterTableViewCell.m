//
//  MasterTableViewCell.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "MasterTableViewCell.h"

@implementation MasterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUserInterface];
    }
    
    return self;
}

- (void)setUserInterface{
    
    //文件名
    UILabel *line = [[UILabel alloc] initWithFrame:AAdaptionRectFromFrame(CGRectMake(30, 20, 15, 50))];
    line.backgroundColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:0.5];
    [self.contentView addSubview:line];
    
    _title = [[UILabel alloc] initWithFrame:AAdaptionRect(50, 20, 500, 50)];
    [self.contentView addSubview:_title];
    _title.font = AAFont(40);
    _title.textColor = [UIColor blackColor];
    _title.adjustsFontSizeToFitWidth = YES;
    
    //最后编辑时间
    _editTime = [[UILabel alloc] initWithFrame:AAdaptionRect(50, 100, 500, 30)];
    [self.contentView addSubview:_editTime];
    _editTime.font = AAFont(25);
    _editTime.textColor = [UIColor colorWithRed:0.451 green:0.451 blue:0.451 alpha:1];
    
    //文件大小
    _fileSize = [[UILabel alloc] initWithFrame:CGRectMake(MAX_X(_title), MIN_Y(_title), AAdaption(170), GET_H(_title))];
    [self.contentView addSubview:_fileSize];
    _fileSize.font = AAFont(33);
    _fileSize.textColor = DOMINANTHUE;
    _fileSize.textAlignment = NSTextAlignmentRight;
}

@end
