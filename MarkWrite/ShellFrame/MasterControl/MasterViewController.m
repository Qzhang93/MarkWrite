//
//  MasterViewController.m
//  MarkWrite
//
//  Created by 彭启伟 on 2016/12/1.
//  Copyright © 2016年 彭启伟. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterTableViewCell.h"

@interface MasterViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
//主视图
@property (nonatomic, strong) UITableView *tableView;

//排序
@property (nonatomic, strong) UIBarButtonItem *sortButton;

@property(nonatomic, strong) UIView *blackView;
@property(nonatomic, strong) UIView *sortView;
@property(nonatomic, strong) UIButton *sortAsName;
@property(nonatomic, strong) UIButton *sortAsTime;
@property(nonatomic, strong) UIImageView *checkView;

//设置
@property (nonatomic, strong) UIBarButtonItem *setButton;

//搜索栏
@property (nonatomic, strong) UISearchController *searchController;

//新建
@property (nonatomic, strong) UIButton *NewFileButton;



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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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
    _sortView = [[UIView alloc] initWithFrame:CGRectMake(0, -AAdaption(181), SCREEN_W, AAdaption(181))];
    _sortView.backgroundColor = COLOR(lightGrayColor);
    [self.view addSubview:_sortView];
    
        //按时间排序
    _sortAsTime = [UIButton buttonWithType:UIButtonTypeCustom];
    _sortAsTime.frame = CGRectMake(0, 0, GET_W(_sortView), AAdaption(90));
    [_sortAsTime setTitle:@"按修改时间排序" forState:UIControlStateNormal];
    [_sortAsTime setTitleColor:COLOR(blackColor) forState:UIControlStateNormal];
    [_sortAsTime addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    _sortAsTime.backgroundColor = COLOR(whiteColor);
    _sortAsTime.tag = 101;
    [_sortView addSubview:_sortAsTime];
        //按名称排序
    _sortAsName = [UIButton buttonWithType:UIButtonTypeCustom];
    _sortAsName.frame = CGRectMake(0, MAX_Y(_sortAsTime) + AAdaption(1), GET_W(_sortView), GET_H(_sortAsTime));
    [_sortAsName setTitle:@"按文件名排序" forState:UIControlStateNormal];
    [_sortAsName setTitleColor:COLOR(blackColor) forState:UIControlStateNormal];
    [_sortAsName addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    _sortAsName.backgroundColor = COLOR(whiteColor);
    _sortAsName.tag = 102;
    [_sortView addSubview:_sortAsName];
    
    _checkView = [[UIImageView alloc] initWithImage:IMGNAME(@"check")];
    _checkView.frame = AAdaptionRect(550, 25, 40, 40);
    [_sortView addSubview:_checkView];
    
    //设置按钮
    _setButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    self.navigationItem.rightBarButtonItem = _setButton;
    
    //搜索栏
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //新建按钮
    _NewFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _NewFileButton.frame = AAdaptionRect(315, 1008, 120, 120);
    [_NewFileButton setBackgroundImage:IMGNAME(@"add_new") forState:UIControlStateNormal];
    [_NewFileButton addTarget:self action:@selector(addNewFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_NewFileButton];
    
    [self.view bringSubviewToFront:_sortView];
    [self.view insertSubview:_blackView belowSubview:_sortView];
}

#pragma mark - Events
//排序
- (void)sortAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 100:
        {
            [self withdrawSortAction];
        }
            break;
            
        case 101:
        {
            _checkView.frame = AAdaptionRect(550, 25, 40, 40);
        }
            break;
            
        case 102:
        {
            _checkView.frame = AAdaptionRect(550, 116, 40, 40);
        }
            break;
            
        default:
            break;
    }
}

//设置
- (void)setAction {
    
    if (_blackView.hidden == NO) {
        [self withdrawSortAction];
    }
    
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//新建
- (void)addNewFile {
    
    [self.navigationController pushViewController:[EditViewController new] animated:YES];
}

- (void)gesturePressed{
    
    [self withdrawSortAction];
}

- (void)withdrawSortAction{
    
    _blackView.hidden = !_blackView.hidden;
    [UIView animateWithDuration:0.3 animations:^{
        _sortView.frame = CGRectMake(0, _sortView.frame.origin.y == 0 ? -AAdaption(181) : 0, SCREEN_W, AAdaption(181));
    }];
}

#pragma mark - UISearchResultsUpdating
//当搜索时每一次改变文本长度该方法就会被触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UITableViewDataSource
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
