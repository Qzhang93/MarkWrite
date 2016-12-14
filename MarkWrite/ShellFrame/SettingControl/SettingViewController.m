//
//  SettingViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "OldPasswordViewController.h"
#import "SetPasswordViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,CellSwitchClickDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger sectionNum;
@property (nonatomic, strong) NSArray *sectionTitle;

@property (nonatomic, strong) UISwitch *passwordSwitch;

@end

@implementation SettingViewController
#pragma mark - Lifycycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPassword) name:@"openPassword" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePassword) name:@"closePassword" object:nil];
}

#pragma mark - UI
- (void)initUserInterface {
    self.title = @"设置";
    _sectionNum = 1;
    _sectionTitle = @[@"密码和TouchID"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }else if (section == 2){
        NSUserDefaults *status = [NSUserDefaults standardUserDefaults];
        if ([status boolForKey:@"pKeyboredStatus"]) {
            NSError *error = nil;
            if ([[[LAContext alloc] init] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                
                _sectionNum = 3;
                _sectionTitle = @[@"密码",@"修改密码",@"TouchID"];
            } else {
                
                _sectionNum = 2;
                _sectionTitle = @[@"密码",@"修改密码"];
            }
            return _sectionNum;
        }else {
            return _sectionNum;
        }
    }else {
        return 1;
    }
}

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

//配置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"setting";
    NSUserDefaults *status = [NSUserDefaults standardUserDefaults];
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer section:indexPath.section row:indexPath.row];
    }
    cell.delegate = self;
    switch (indexPath.section) {
        
        //辅助键盘
        case 0: {
            cell.textLabel.text = @"辅助键盘";
            cell.switchButton.hidden = NO;
            cell.switchButton.on = [status boolForKey:@"aKeyboredStatus"];
        }
            break;
            
        //好评鼓励，意见反馈
        case 1: {
            NSArray *arr = @[@"好评鼓励",@"意见反馈"];
            cell.textLabel.text = arr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        //密码
        case 2: {
            cell.switchButton.hidden = NO;
            cell.accessoryType = UITableViewCellStyleDefault;
            cell.textLabel.text = _sectionTitle[indexPath.row];
            if ([status boolForKey:@"pKeyboredStatus"]) {
                
                switch (indexPath.row) {
                    //密码开关
                    case 0: {
                        cell.switchButton.hidden = NO;
                        [cell.switchButton setOn:[status boolForKey:@"pKeyboredStatus"]];
                    }
                        break;
                        
                    //修改密码
                    case 1: {
                        cell.switchButton.hidden = YES;
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                        break;
                        
                    //touchID开关
                    case 2:
                    {
                        cell.switchButton.hidden = NO;
                        [cell.switchButton setOn:[status boolForKey:@"tKeyboredStatus"]];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
            break;
            
        //关于
        case 3: {
            cell.textLabel.text = @"关于";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        //打赏
        case 4: {
            cell.textLabel.text = @"打赏";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.switchButton.hidden = YES;
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
                case 0: {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/shan-shan-pen-di-fu-nu-jian/id1049660516?mt=8"]];
                }
                    break;
                case 1: {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2: {
            switch (indexPath.row) {
                case 1: {
                    [self.navigationController pushViewController:[OldPasswordViewController new] animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 3: {
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
            
        case 4: {
           
            [QWPTools showMessageWithTitle:@"请我们喝饮料" content:@"如果你觉得这个应用还不错，请给予我们鼓励，谢谢！" buttonTitles:@[@"取消",@"请喝饮料6元"] clickedHandle:^(NSInteger index) {
                
            } compeletedHandle:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - CellSwitchClickDelegate
- (void)cellSwitchClick:(UISwitch *)sender {
    NSUserDefaults *status = [NSUserDefaults standardUserDefaults];
    //辅助键盘开关
    if (sender.tag == 0) {
                if (sender.isOn) {
                    
                    [status setBool:YES forKey:@"aKeyboredStatus"];
                }else {
                    
                    [status setBool:NO forKey:@"aKeyboredStatus"];
                }
            }
    //密码开关
    else if (sender.tag == 2) {
        _passwordSwitch = sender;
        if (sender.isOn) {
            
            SetPasswordViewController *setPasswordVC = [[SetPasswordViewController alloc] init];
            setPasswordVC.isSet = YES;
            [self.navigationController pushViewController:setPasswordVC animated:YES];
            
        }else {
            
            OldPasswordViewController *oldPasswordVC = [[OldPasswordViewController alloc] init];
            oldPasswordVC.isDelete = YES;
            [self.navigationController pushViewController:oldPasswordVC animated:YES];
        }
    }
    //touchID开关
    else if (sender.tag == 4) {
                if (sender.isOn) {
                    
                    [status setBool:YES forKey:@"tKeyboredStatus"];
                }else {
                    
                    [status setBool:NO forKey:@"tKeyboredStatus"];
                }
            }
}

#pragma mark - Events
- (void)closeTouchID {
    NSUserDefaults *status = [NSUserDefaults standardUserDefaults];
    if ([status boolForKey:@"tKeyboredStatus"]) {
        NSLog(@"close TouchID");
        [status setBool:NO forKey:@"tKeyboredStatus"];
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

- (void)openPassword{
    
    [_passwordSwitch setOn:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pKeyboredStatus"];
    NSError *error = nil;
    if ([[[LAContext alloc] init] canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        _sectionNum = 3;
        _sectionTitle = @[@"密码",@"修改密码",@"TouchID"];
    } else {
        
        _sectionNum = 2;
        _sectionTitle = @[@"密码",@"修改密码"];
    }
    [self.tableView reloadData];
}

- (void)closePassword{
    
    [_passwordSwitch setOn:NO];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pKeyboredStatus"];
    _sectionNum = 1;
    _sectionTitle = @[@"密码和TouchID"];
    [self closeTouchID];
    [self.tableView reloadData];
}


@end
