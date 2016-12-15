//
//  MasterViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"
#import "PasswordView.h"
#import "SortView.h"
#import "addNewView.h"

@interface MasterViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) PasswordView *openView;

//主视图
@property (nonatomic, strong) UITableView *tableView;
//Y轴偏移量
@property (nonatomic, assign) CGFloat oldY;

@property(nonatomic, strong) UIView *blackView;

//排序
@property (nonatomic, strong) UIBarButtonItem *sortButton;
@property(nonatomic, strong) SortView *sortView;

//设置
@property (nonatomic, strong) UIBarButtonItem *setButton;

//搜索栏
@property (nonatomic, strong) UISearchController *searchController;

//新建
@property (nonatomic, strong) UIButton *NewFileButton;
@property (nonatomic, strong) addNewView *addNewView;

@end

@implementation MasterViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self initUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self showNewFileBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self hideNewFileBtn];
    [_addNewView.fileName resignFirstResponder];
    _sortButton.enabled = YES;
    _blackView.hidden = YES;
    _sortView.frame = AAdaptionRect(0, -181, 750, 181);
    _addNewView.frame = AAdaptionRect(0, 1334, 750, 1000);
    _addNewView.fileName.text = @"";
}

#pragma mark - UI
- (void)initUserInterface {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = AAdaption(140);
    [self.view addSubview:_tableView];
    
    _blackView = [[UIView alloc] initWithFrame:self.view.bounds];
    _blackView.backgroundColor = COLOR(blackColor);
    _blackView.alpha = 0.7;
    _blackView.hidden = YES;
    [self.view addSubview:_blackView];
    UITapGestureRecognizer *withdrawSort = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePressed)];
    [_blackView addGestureRecognizer:withdrawSort];
    
    //排序按钮
    _sortButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sort"] style:UIBarButtonItemStylePlain target:self action:@selector(sortAction:)];
    self.navigationItem.leftBarButtonItem = _sortButton;
    _sortButton.tag = 100;
    
    //排序选择
    _sortView = [[SortView alloc] initWithFrame:AAdaptionRect(0, -181, 750, 181)];
    [self.view addSubview:_sortView];
    [_sortView.sortAsTime addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sortView.sortAsName addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置按钮
    _setButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    self.navigationItem.rightBarButtonItem = _setButton;
    
    //搜索栏
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //新建按钮
    _NewFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _NewFileButton.frame = AAdaptionRect(315, 1334, 120, 120);
    [_NewFileButton setBackgroundImage:IMGNAME(@"add_new") forState:UIControlStateNormal];
    [_NewFileButton addTarget:self action:@selector(scaledBtn) forControlEvents:UIControlEventTouchDown];
    [_NewFileButton addTarget:self action:@selector(addNewFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_NewFileButton];
    
    //新建
    _addNewView = [[addNewView alloc] initWithFrame:AAdaptionRect(0, 1334, 750, 1000)];
    [self.view addSubview:_addNewView];
    [_addNewView.filePath addTarget:self action:@selector(pathOfFile) forControlEvents:UIControlEventValueChanged];
    [_addNewView.cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_addNewView.save addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    //验证密码是否开启
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"pKeyboredStatus"]) {
        _openView = [[PasswordView alloc] initWithFrame:self.view.frame isVerifyOpen:YES isOldPassword:NO isNewPassword:NO isVerifyNew:NO];
        _openView.backgroundColor = RGBCOLOR(230, 230, 230, 1.0);
        _openView.inputPassword.delegate = self;
        [_openView.inputPassword becomeFirstResponder];
        [[[UIApplication sharedApplication] keyWindow] addSubview:_openView];
        
        //验证touchID是否开启
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"tKeyboredStatus"]) {
            
            LAContext *context = [[LAContext alloc] init];
            NSError *error = nil;
            //验证机器是否支持指纹识别
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                //支持指纹识别
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证指纹以解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                        //验证成功
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_openView removeFromSuperview];
                        });
                    }
                }];
            }
        }
    }
    
}


#pragma mark - Events
//排序
- (void)sortAction:(UIButton *)sender {
    
    [self.view bringSubviewToFront:_sortView];
    [self.view insertSubview:_blackView belowSubview:_sortView];
    switch (sender.tag) {
        //排序按钮
        case 100:
        {
            [self withdrawSortAction];
        }
            break;
            
        //按修改时间排序
        case 101:
        {
            _sortView.checkView.frame = AAdaptionRect(550, 25, 40, 40);
            [self withdrawSortAction];
            [_tableView reloadData];
        }
            break;
            
        //按文件名排序
        case 102:
        {
            _sortView.checkView.frame = AAdaptionRect(550, 116, 40, 40);
            [self withdrawSortAction];
            [_tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

//设置
- (void)setAction {
    
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//新建
- (void)addNewFile {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _NewFileButton.transform = CGAffineTransformIdentity;
        [self.view bringSubviewToFront:_addNewView];
        [self.view insertSubview:_blackView belowSubview:_addNewView];
        [self withdrawAddNewAction];
        [_addNewView.fileName becomeFirstResponder];
    }];
    
}

//路径选择
- (void)pathOfFile{
    
    
}

//取消新建
- (void)cancelAction{
    
    [self withdrawAddNewAction];
}

//保存新建
- (void)saveAction{
    
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.fileTitle = _addNewView.fileName.text;
    [self.navigationController pushViewController:editVC animated:YES];
}

//点击屏幕空余部分收回视图
- (void)gesturePressed{
    
    if (_sortView.frame.origin.y == -AAdaption(181)) {
       [self withdrawAddNewAction];
    }
    
    if (_sortView.frame.origin.y == 0) {
        [self withdrawSortAction];
    }
    
}

//首页开启密码验证
- (void)openVerify{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_openView];
}

#pragma mark - Animation Method
- (void)withdrawSortAction{
    
    _blackView.hidden = !_blackView.hidden;
    [UIView animateWithDuration:0.3 animations:^{
        _sortView.frame = AAdaptionRect(0, _sortView.frame.origin.y == 0 ? -181 : 0, 750, 181);
    }];
}

- (void)withdrawAddNewAction{
    
    [_addNewView.fileName resignFirstResponder];
    _sortButton.enabled = !_sortButton.enabled;
    _blackView.hidden = !_blackView.hidden;
    if (_addNewView.frame.origin.y == AAdaption(1334)){
        [UIView animateWithDuration:0.3 animations:^{
            _addNewView.frame = AAdaptionRect(0, 230, 750, 1000);
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            _addNewView.frame = AAdaptionRect(0, 1334, 750, 1000);
        }];
    }
}

- (void)hideNewFileBtn{
    
    [UIView animateWithDuration:0.7 animations:^{
        
        _NewFileButton.frame = AAdaptionRect(315, 1334, 120, 120);
    }];
}

- (void)showNewFileBtn{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _NewFileButton.frame = AAdaptionRect(315, 1008, 120, 120);
    }];
}

- (void)scaledBtn{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _NewFileButton.transform = CGAffineTransformMakeScale(0.5, 0.5);
        _NewFileButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    }];
}

#pragma mark - UISearchResultsUpdating
//当搜索时每一次改变文本长度该方法就会被触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

//自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = @"master";
    MasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        
        cell = [[MasterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual: self.tableView]) {
        if (self.tableView.contentOffset.y > _oldY) {
            // 向下滚动
            [self hideNewFileBtn];
        }
        else{
            // 向上滚动
            [self showNewFileBtn];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = _tableView.contentOffset.y;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    switch (range.location) {
        case 0:
        {
            _openView.first.hidden = !_openView.first.hidden;
            _openView.firstR.hidden = !_openView.firstR.hidden;
        }
            break;
            
        case 1:
        {
            _openView.second.hidden = !_openView.second.hidden;
            _openView.secondR.hidden = !_openView.secondR.hidden;
        }
            break;
            
        case 2:
        {
            _openView.third.hidden = !_openView.third.hidden;
            _openView.thirdR.hidden = !_openView.thirdR.hidden;
        }
            break;
            
        case 3:
        {
            _openView.fourth.hidden = !_openView.fourth.hidden;
            _openView.fourthR.hidden = !_openView.fourthR.hidden;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if ([_openView.inputPassword.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]) {
                    
                    _openView.errorOld.hidden = YES;
                    [_openView removeFromSuperview];
                } else {
                    
                    _openView.errorOld.hidden = NO;
                    _openView.inputPassword.text = @"";
                    NSArray *array = @[_openView.first,_openView.second,_openView.third,_openView.fourth];
                    NSArray *arrayR = @[_openView.firstR,_openView.secondR,_openView.thirdR,_openView.fourthR];
                    for (UILabel *label in array) {
                        label.hidden = NO;
                    }
                    for (UILabel *labelR in arrayR) {
                        labelR.hidden = YES;
                    }
                }
                
            });
            
        }
            break;
            
        default:
            break;
    }
    
    if (range.location >= 4) {
        
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (UISearchController *)searchController{
    if (!_searchController) {
        //初始化
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //设置刷新对象
        _searchController.searchResultsUpdater = self;
        //设置搜索时是否模糊背景
        _searchController.dimsBackgroundDuringPresentation = YES;
        //设置搜索时是否隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = NO;
        //设置搜索栏的fram
        _searchController.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44);
    }
    return _searchController;
}


@end
