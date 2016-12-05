//
//  MasterTableViewCell.h
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterTableViewCell : UITableViewCell

//文件名
@property(nonatomic, strong) UILabel *title;

//最后编辑时间
@property(nonatomic, strong) UILabel *editTime;

//文件大小
@property(nonatomic, strong) UILabel *fileSize;

@end
