//
//  AddInvoiceViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/26.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "AddInvoiceViewController.h"
#import "NewAddInvoiceViewController.h"

#import "InvoiceTypeCell.h"
#import "InvoiceInfoCell.h"

#import <BAButton/BAButton.h>

NSString *const kInvoiceTypeCell= @"InvoiceTypeCell";
NSString *const kInvoiceInfoCell= @"InvoiceInfoCell";


@interface AddInvoiceViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *comments;
@property(nonatomic, assign) BOOL isNeetInvoice;   // 是否需要发票

@end

@implementation AddInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initUI {
    
    _naviLabel.text = @"添加发票";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[InvoiceTypeCell class] forCellReuseIdentifier:kInvoiceTypeCell];
    [_tableView registerClass:[InvoiceInfoCell class] forCellReuseIdentifier:kInvoiceInfoCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    // header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 45)];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor darkTextColor];
    label.text = @"需要发票";
    [headerView addSubview:label];
    
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    switchBtn.onTintColor = ThemeColor;
    switchBtn.center = CGPointMake(kScreenWidth - 40, 22.5);
    [switchBtn addTarget:self action:@selector(switchBtnAciton:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:switchBtn];
    
    // footer
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _tableView.tableFooterView = footerView;
    
    UIButton *addBtn = [UIButton ba_buttonWithFrame:CGRectMake(20, 40, kScreenWidth-40, 44) title:@"新增发票" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:13] image:[UIImage imageNamed:@"order_add_grey_iciphone"] backgroundColor:ThemeColor];
    [addBtn ba_button_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:4];
    [addBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeNormal padding:10];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
}


#pragma mark - UIControl 

- (void)switchBtnAciton:(UISwitch *)switchBtn {
    
    _isNeetInvoice = switchBtn.on;
    [_tableView reloadData];
}

- (void)addBtnClick:(id)sender {
    
    NewAddInvoiceViewController *vc = [NewAddInvoiceViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}



#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _isNeetInvoice?2:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 57*3;
    }
    return 57;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}


#pragma mark - UITableView DataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 60, 20)];
    label.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    if (section == 0) {
        label.text = @"发票类型";
    }else
        label.text = @"发票信息";
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        InvoiceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kInvoiceTypeCell];
        cell.InvoiceCellBlock = ^(InvoiceType type){
            
            
        };
        return cell;
    }
    
    InvoiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kInvoiceInfoCell];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





#pragma mark - init Data

- (void)initData {
    
}


@end
