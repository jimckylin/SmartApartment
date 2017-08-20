//
//  UsefullInfoViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/20.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "UsefullInfoViewController.h"
#import "YJSliderView.h"
#import "PassengerCell.h"
#import <BAButton/BAButton.h>
#import <BMLine/UIView+BMLine.h>
#import "AddPassengerViewController.h"

@interface UsefullInfoViewController ()<YJSliderViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YJSliderView *sliderView;

@end

@implementation UsefullInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = @"常用信息";
    
    self.sliderView = [[YJSliderView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    self.sliderView.delegate = self;
    [self.view addSubview:self.sliderView];
    
    [self initSubView];
}


- (void)initSubView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // [self.view addSubview:_tableView];
    //[_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"PassengerCell" bundle:nil] forCellReuseIdentifier:@"PassengerCell"];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _tableView.tableFooterView = footerView;
    
    UIButton *addBtn = [UIButton ba_buttonWithFrame:CGRectMake(20, 40, kScreenWidth-40, 44) title:@"新增常用旅客" titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:13] image:[UIImage imageNamed:@"order_add_grey_iciphone"] backgroundColor:ThemeColor];
    [addBtn ba_button_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:4];
    [addBtn ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeNormal padding:10];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
}


#pragma mark - 

- (void)addBtnClick:(id)sender {
    
    AddPassengerViewController *vc = [AddPassengerViewController new];
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


- (NSInteger)numberOfItemsInYJSliderView:(YJSliderView *)sliderView {
    return 1;
}

- (UIView *)yj_SliderView:(YJSliderView *)sliderView viewForItemAtIndex:(NSInteger)index {
    
    return _tableView;
}

- (NSString *)yj_SliderView:(YJSliderView *)sliderView titleForItemAtIndex:(NSInteger)index {
    NSArray *titles = @[@"旅客"];
    return titles[index];
}

- (NSInteger)initialzeIndexForYJSliderView:(YJSliderView *)sliderView {
    return 0;
}

- (NSInteger)yj_SliderView:(YJSliderView *)sliderView redDotNumForItemAtIndex:(NSInteger)index {
    return 0;
}

- (void)changeCurrrentToIndex:(NSInteger)index {
    NSLog(@"切换到位置%ld", index);
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PassengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassengerCell" forIndexPath:indexPath];
    [cell addLineWithType:BMLineTypeCustomDefault color:nil position:BMLinePostionCustomBottom];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}




@end

