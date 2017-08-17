//
//  HotelDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "CalendarViewController.h"

#import "HotelDetailDateView.h"
#import "ZYCalendarManager.h"
#import "ZZFoldCellModel.h"

#import "BlankCell.h"
#import "HotelDetailHeaderCell.h"
#import "HotelDetailMapCell.h"
#import "HotelDetailRoomTypeCell.h"
#import "HotelDetailRoomListCell.h"
#import "HotelDetailRoomPriceTypeCell.h"
#import "HotelDetailMoreCell.h"
#import "MapViewController.h"

NSString *const kBlankCell = @"BlankCell";
NSString *const kHotelDetailHeaderCell = @"HotelDetailHeaderCell";
NSString *const kHotelDetailMapCell = @"HotelDetailMapCell";
NSString *const kHotelDetailRoomTypeCell = @"HotelDetailRoomTypeCell";
NSString *const kHotelDetailRoomListCell = @"HotelDetailRoomListCell";
NSString *const kHotelDetailRoomPriceTypeCell = @"HotelDetailRoomPriceTypeCell";
NSString *const kHotelDetailMoreCell = @"HotelDetailMoreCell";


@interface HotelDetailViewController ()<UITableViewDelegate,
UITableViewDataSource, HotelDetailRoomPriceTypeCellDelegate, HotelDetailDateViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray<__kindof ZZFoldCellModel *> *data;
//@property(nonatomic, assign) BOOL isAlldayRoomExpand; // 是否伸缩 defalut NO

@end

@implementation HotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initUI {
    
    [_naviBackBtn setHidden:YES];
    [_naviView setAlpha:0];
    _naviLabel.text = @"酒店详情";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    [self.view addSubview:view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.view addSubview:bgView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 10;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:_tableView];
    [_tableView registerClass:[BlankCell class] forCellReuseIdentifier:kBlankCell];
    [_tableView registerClass:[HotelDetailHeaderCell class] forCellReuseIdentifier:kHotelDetailHeaderCell];
    [_tableView registerClass:[HotelDetailMapCell class] forCellReuseIdentifier:kHotelDetailMapCell];
    [_tableView registerClass:[HotelDetailRoomTypeCell class] forCellReuseIdentifier:kHotelDetailRoomTypeCell];
    [_tableView registerClass:[HotelDetailRoomListCell class] forCellReuseIdentifier:kHotelDetailRoomListCell];
    [_tableView registerClass:[HotelDetailRoomPriceTypeCell class] forCellReuseIdentifier:kHotelDetailRoomPriceTypeCell];
    [_tableView registerClass:[HotelDetailMoreCell class] forCellReuseIdentifier:kHotelDetailMoreCell];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    [self.view bringSubviewToFront:_naviView];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 75, 44);
    [backBtn setImage:[UIImage imageNamed:@"nav_return_ic_wiphone"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 27)];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setImage:kImage(@"nav_detail_like_btn_siphone") forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    collectBtn.tag = kNavButtonTag1;
    [self.view addSubview:collectBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:kImage(@"nav_detail_share_btn_siphone") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    [shareBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [shareBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:25];
    [shareBtn autoSetDimensionsToSize:CGSizeMake(34, 34)];
    
    [collectBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:shareBtn];
    [collectBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:shareBtn];
    [collectBtn autoSetDimensionsToSize:CGSizeMake(34, 34)];
    
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return 1;
    }else if(section == 2) {
        return 1+self.data.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 420;
    }else if (indexPath.section == 1) {
        return 101;
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            return 104;
        }else {
            ZZFoldCellModel *foldCellModel = self.data[indexPath.row-1];
            return foldCellModel.level.intValue==0?65:50;
        }
    }
    return 0;
}


#pragma mark - UITableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0 || section == 1) {
        if (section == 0 && row == 0) {
            HotelDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailHeaderCell];
            //cell.delegate = self;
            
            return cell;
        }else if (section == 1 && row == 0) {
            HotelDetailMapCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailMapCell];
            [cell setMapCenterCoordinate:@"26.08" lon:@"119.3"];
            cell.mapViewDidClickBlock = ^{
                MapViewController *map = [MapViewController new];
                [map setMapCenterCoordinate:@"26.08" lon:@"119.3"];
                [[NavManager shareInstance] showViewController:map isAnimated:YES];
            };
            return cell;
        }
    }
    else {
        
        if (row == 0) {
            HotelDetailRoomTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomTypeCell];
            cell.delegate = (id<HotelDetailRoomTypeCellDelegate>)self;
            return cell;
        }else {

            ZZFoldCellModel *foldCellModel = self.data[indexPath.row-1];
            if (foldCellModel.level.intValue == 0) {
                HotelDetailRoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomListCell];
                cell.textLabel.text = foldCellModel.text;
                return cell;
            }else {
                HotelDetailRoomPriceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomPriceTypeCell];
                cell.delegate = self;
                return cell;
            }
        }
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        if (indexPath.row >= 1) {
            ZZFoldCellModel *didSelectFoldCellModel = self.data[indexPath.row-1];
            [tableView beginUpdates];
            if (didSelectFoldCellModel.belowCount == 0) {
                
                //Data
                NSArray *submodels = [didSelectFoldCellModel open];
                NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1-1,submodels.count})];
                [self.data insertObjects:submodels atIndexes:indexes];
                
                //Rows
                NSMutableArray *indexPaths = [NSMutableArray new];
                for (int i = 0; i < submodels.count; i++) {
                    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
                    [indexPaths addObject:insertIndexPath];
                }
                [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                
            }else {
                
                //Data
                NSArray *submodels = [self.data subarrayWithRange:((NSRange){indexPath.row + 1-1,didSelectFoldCellModel.belowCount})];
                [didSelectFoldCellModel closeWithSubmodels:submodels];
                [self.data removeObjectsInArray:submodels];
                
                //Rows
                NSMutableArray *indexPaths = [NSMutableArray new];
                for (int i = 0; i < submodels.count; i++) {
                    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
                    [indexPaths addObject:insertIndexPath];
                }
                [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
            [tableView endUpdates];
        }
        
    }else {
        
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 50) {
        _naviView.alpha = (scrollView.contentOffset.y - 50)/60;
    }else {
        _naviView.alpha = 0.f;
    }
}


#pragma mark - UIButton Action

- (void)backBtnClick:(id)sender {
    
    [[NavManager shareInstance] returnToFrontView:YES];
}

- (void)collectBtnClick:(id)sender {
    
    
}

- (void)shareBtnClick:(id)sender {
    
    
}


#pragma mark - HotelDetailDateViewDelegate

- (void)hotelDetailDateViewDidClick:(HotelSelectBtnType)type {
    
    CalendarViewController *vc = [CalendarViewController new];
    vc.calendarDateBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        for (NSDate *date in manager.selectedDateArray) {
            NSLog(@"%@", [manager.dateFormatter stringFromDate:date]);
        }
    };
    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
}


#pragma mark - HotelDetailRoomPriceTypeCellDelegate

- (void)hotelDetailRoomPriceTypeCellDidClickBtn:(HotelRoomListBtnType)type {
    
    NSLog(@"type:%zd", type);
}



#pragma mark - init Data

- (void)initData {
    
    NSArray *netData = @[
                         @{
                             @"text":@"普通房",
                             @"level":@"0",
                             @"submodels":@[
                                     @{
                                         @"text":@"优惠券",
                                         @"level":@"1",
                                         },
                                     @{
                                         @"text":@"网客价",
                                         @"level":@"1",
                                         }
                                     ]
                             },
                         @{
                             @"text":@"标准房",
                             @"level":@"0",
                             @"submodels":@[
                                     @{
                                         @"text":@"优惠券",
                                         @"level":@"1",
                                         },
                                     @{
                                         @"text":@"网客价",
                                         @"level":@"1",
                                         }
                                     ]
                             },
                         @{
                             @"text":@"豪华房",
                             @"level":@"0",
                             @"submodels":@[
                                     @{
                                         @"text":@"优惠券",
                                         @"level":@"1",
                                         },
                                     @{
                                         @"text":@"网客价",
                                         @"level":@"1",
                                         }
                                     ]
                             },
                         ];
    
    self.data = [NSMutableArray new];
    for (int i = 0; i < netData.count; i++) {
        ZZFoldCellModel *foldCellModel = [ZZFoldCellModel modelWithDic:(NSDictionary *)netData[i]];
        [self.data addObject:foldCellModel];
    }
}


@end

