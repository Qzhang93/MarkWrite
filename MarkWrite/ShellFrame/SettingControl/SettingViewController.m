//
//  SettingViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController
#pragma mark - Lifycycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
}
#pragma mark - UI
- (void)initUserInterface {
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    switch (section) {
//        case 0: {
//            
//        }
//            break;
//        case 1: {
//            
//        }
//            break;
//        case 2: {
//            
//        }
//            break;
//        case 3: {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    if (section == 1) {
        return 2;
    }else {
        return 1;
    }
}
//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
//配置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"setting";
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = @"键盘辅助";
            cell.switchView.hidden = NO;
        }
            break;
        case 1: {
            NSArray *arr = @[@"好评鼓励",@"意见反馈"];
            cell.textLabel.text = arr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 2: {
            cell.textLabel.text = @"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3: {
            cell.textLabel.text = @"打赏";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        default:
            break;
    }
    cell.textLabel.textColor = HEXCOLOR(0x4f4f4f);
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
#pragma mark - UITableViewDelegate
//表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AAdaption(50);
}
//表头内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [UIView new];
    headerView.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    return headerView;
}
//选择某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1: {
            switch (indexPath.row) {
                case 1: {
                    
                }
                    break;
                case 2: {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2: {
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        case 3: {
            [QWPTools showMessageWithTitle:@"给口狗粮" content:@"MartWrite是一款很实用的App，如果您觉得这款软件还适合您的话请给口狗粮吧，谢谢！" buttonTitles:@[@"取消",@"狗粮6元"] clickedHandle:^(NSInteger index) {
                
            } compeletedHandle:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kwidth, kheight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = AAdaption(100);
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        _tableView.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
    }
    return _tableView;
}
@end
