//
//  NewAddInvoiceViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "NewAddInvoiceViewController.h"
#import "InvoiceTypeCell.h"
#import "NewAddInvoiceCell.h"
#import "WRCellView.h"

#import <BAButton/BAButton.h>

NSString *const KInvoiceTypeCell= @"InvoiceTypeCell";
NSString *const KNewAddInvoiceCell= @"NewAddInvoiceCell";


@interface NewAddInvoiceViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *comments;
@property(nonatomic, assign) BOOL isNeetInvoice;   // 是否需要发票

@property(nonatomic, assign) InvoiceType type;   // 发票类型

@property (nonatomic, strong) WRCellView    *tipView;
@property (nonatomic, strong) UILabel       *tipLabel;

@end

@implementation NewAddInvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initUI {
    
    _naviLabel.text = @"新增发票";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[InvoiceTypeCell class] forCellReuseIdentifier:KInvoiceTypeCell];
    [_tableView registerClass:[NewAddInvoiceCell class] forCellReuseIdentifier:KNewAddInvoiceCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    
    // footer
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _tableView.tableFooterView = footerView;
    
    [footerView addSubview:self.tipView];
    [self.tipView addSubview:self.tipLabel];
    self.tipView.frame = CGRectMake(0, 10, kScreenWidth, 50);
    
    UIButton *addBtn = [UIButton ba_buttonWithFrame:CGRectMake(20, 80, kScreenWidth-40, 44) title:@"保存" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:13] image:[UIImage imageNamed:@"order_add_grey_iciphone"] backgroundColor:ThemeColor];
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
    
}



#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        if (_type == InvoiceTypePersonal) {
            return 1;
        }else if (_type == InvoiceTypeSpecial) {
            return 6;
        }else {
            return 2;
        }
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
        InvoiceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:KInvoiceTypeCell];
        
        __WeakObj(self);
        cell.InvoiceCellBlock = ^(InvoiceType type){
            selfWeak.type = type;
            [tableView reloadData];
        };
        return cell;
    }
    
    NewAddInvoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:KNewAddInvoiceCell];
    
    if (_type == InvoiceTypePersonal) {
        [cell setTitleAndPlaceholder:@{@"title":@"发票抬头", @"placeholder":@"个人姓名"}];
    }else if (_type == InvoiceTypeSpecial) {
        NSArray *dic = @[ @{@"title":@"企业名称",  @"placeholder":@"公司名称"},
                          @{@"title":@"识别号",    @"placeholder":@"纳税人识别号"},
                          @{@"title":@"注册地址",  @"placeholder":@"公司注册地址"},
                          @{@"title":@"联系电话",  @"placeholder":@"区号-总机"},
                          @{@"title":@"开户行",    @"placeholder":@"对外付款的开户行"},
                          @{@"title":@"开户行电话", @"placeholder":@"对外付款的的银行帐号"},];
        
        [cell setTitleAndPlaceholder:dic[indexPath.row]];
    }else {
        NSArray *dic = @[@{@"title":@"发票抬头", @"placeholder":@"公司名称"},
                         @{@"title":@"识别号",    @"placeholder":@"纳税人识别号"}];
        [cell setTitleAndPlaceholder:dic[indexPath.row]];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





#pragma mark - init Data

- (void)initData {
    
}


- (WRCellView *)tipView {
    if (_tipView == nil) {
        _tipView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Icon];
        _tipView.leftIcon.image = kImage(@"oeder_reminder_iciphone");
    }
    return _tipView;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 175, 50)];
        _tipLabel.text = @"请于入住日中午12:00后办理入住，如提前到店，视酒店空房情况安排";
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.frame = CGRectMake(40, 0, kScreenWidth-72, 50);
    }
    return _tipLabel;
}



@end
