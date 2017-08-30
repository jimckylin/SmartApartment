//
//  CommentHotelViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/31.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "CommentHotelViewController.h"

#import "CommentHeaderCell.h"
#import "WRCellView.h"
#import "StarHotelCell.h"
#import "BlankCell.h"


@interface CommentHotelViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation CommentHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    
    _naviLabel.text = @"酒店点评";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[StarHotelCell class] forCellReuseIdentifier:@"StarHotelCell"];
    [_tableView registerClass:[BlankCell class] forCellReuseIdentifier:@"BlankCell"];
    [_tableView registerClass:[CommentHeaderCell class] forCellReuseIdentifier:@"CommentHeaderCell"];
    [self.view addSubview:_tableView];
    
    // footer
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    footerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = footerView;
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.backgroundColor = ThemeColor;
    [commitBtn addTarget:self action:@selector(commitCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [commitBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    commitBtn.layer.cornerRadius = 3;
    [footerView addSubview:commitBtn];
    [commitBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 12, 0, 12) excludingEdge:ALEdgeBottom];
    [commitBtn autoSetDimension:ALDimensionHeight toSize:40];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 146;
    }else if (section == 1) {
        return 40;
    }else if (section == 2) {
        return 301;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        CommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentHeaderCell"];
        return cell;
        
    }else if (section == 1) {
        BlankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlankCell"];
        
        WRCellView *tripTypeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        tripTypeView.frame = CGRectMake(0, 0, kScreenWidth, cell.height);
        tripTypeView.leftLabel.textColor = [UIColor darkTextColor];
        tripTypeView.leftLabel.text = @"出游类型";
        tripTypeView.rightLabel.text = @"出游类型";
        [cell addSubview:tripTypeView];
        
        __weak typeof(self) weakSelf = self;
        tripTypeView.tapBlock = ^ {
            //__strong typeof(self) pThis = weakSelf;
            
        };
        return cell;
        
    }else if (section == 2) {
        StarHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StarHotelCell"];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-4154-451"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}



#pragma mark - UIButton Action

- (void)commitCommentBtnClick:(id)sender {
    
    
}




@end
