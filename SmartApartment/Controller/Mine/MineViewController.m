//
//  MineViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "MineViewController.h"
#import "UIScrollView+HeaderScaleImage.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    
    [_naviBackBtn setHidden:YES];
    _naviLabel.text = NSLocalizedString(@"我的", nil);
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    // 设置tableView头部缩放图片 *一行代码就集成了*
    _tableView.yz_headerScaleImage = [UIImage imageNamed:@"snapshot"];
    
    // 设置tableView头部视图，必须设置头部视图背景颜色为clearColor,否则会被挡住
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    // 清空头部视图背景颜色
    headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerView;
    
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 160;
    }else {
        return 150;
    }
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdetifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
    }
    
    return cell;
}



@end
