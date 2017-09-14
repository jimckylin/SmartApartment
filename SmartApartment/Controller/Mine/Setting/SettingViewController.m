//
//  SettingViewController.m
//  SmartApartment
//
//  Created by jimcky on 2017/8/9.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"设置", nil);
    
    [self initSubView];
}

- (void)initSubView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 49, 0)];
    
    // header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 256/2)];
    header.backgroundColor = [UIColor clearColor];
    
    UIImageView *iconV = [UIImageView new];
    iconV.contentMode = UIViewContentModeScaleAspectFill;
    iconV.image = [UIImage imageNamed:@"msx_h_round_256"];
    [header addSubview:iconV];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *appInfoLabel = [UILabel new];
    appInfoLabel.font = [UIFont systemFontOfSize:14];
    appInfoLabel.textColor = [UIColor darkTextColor];
    appInfoLabel.textAlignment = NSTextAlignmentCenter;
    appInfoLabel.text = [NSString stringWithFormat:@"%@ %@", appName, appVersion];
    [header addSubview:appInfoLabel];
    
    [iconV autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [iconV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [iconV autoSetDimensionsToSize:CGSizeMake(57, 57)];
    
    [appInfoLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [appInfoLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconV];
    [appInfoLabel autoSetDimensionsToSize:CGSizeMake(100, 30)];
    
    _tableView.tableHeaderView = header;
    
    
    // footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    footer.backgroundColor = [UIColor clearColor];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.backgroundColor = [UIColor whiteColor];
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [logoutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    logoutBtn.layer.cornerRadius = 3;
    [footer addSubview:logoutBtn];
    
    [logoutBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [logoutBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [logoutBtn autoSetDimensionsToSize:CGSizeMake(kScreenWidth-80, 40)];
    
    _tableView.tableFooterView = footer;
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    return rows = section == 0?3:2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdetifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        UIImage *arrow = [UIImage imageNamed:@"home_arrow_iconiphone"];
        UIImageView *imageV = [[UIImageView alloc] initWithImage:arrow];
        imageV.center = CGPointMake(kScreenWidth-20, 22);
        [cell addSubview:imageV];
        
        cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"关于智慧公寓", @"帮助中心",@"赏赐好评"];
        cell.textLabel.text = [NSString stringWithFormat:@"  %@", titles[indexPath.row]];
    }else {
        NSArray *titles = @[@"清除缓存",@"修改密码"];
        cell.textLabel.text = [NSString stringWithFormat:@"  %@", titles[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - UIButton Action 

- (void)logoutBtnClick:(id)sender {
    
    NSLog(@"登出");
    [UserManager manager].isLogin = NO;
    [[NavManager shareInstance] returnToLoginView:YES];
}


@end
