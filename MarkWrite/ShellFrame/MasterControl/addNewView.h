//
//  addNewView.h
//  MarkWrite
//
//  Created by 张琦 on 16/12/14.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewView : UIView

@property(nonatomic, strong) UISegmentedControl *filePath;

@property(nonatomic, strong) UITextField *fileName;

@property(nonatomic, strong) UIButton *cancel;

@property(nonatomic, strong) UIButton *save;

@end
