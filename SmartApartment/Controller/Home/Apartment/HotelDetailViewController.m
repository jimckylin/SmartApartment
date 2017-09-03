//
//  HotelDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/14.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "CalendarViewController.h"
#import "MapViewController.h"
#import "HotelCommentListViewController.h"
#import "BookHotelViewController.h"
#import "HotelDescrViewController.h"

#import "HotelDetailDateView.h"
#import "ZYCalendarManager.h"
#import "ZZFoldCellModel.h"
#import "ShareManager.h"

/* 头部 */
#import "BlankCell.h"
#import "HotelDetailHeaderCell.h"
#import "HotelDetailMapCell.h"
/* 房型 */
#import "HotelDetailRoomTypeCell.h"
#import "HotelDetailRoomListCell.h"
#import "HotelDetailRoomPriceTypeCell.h"
#import "HotelDetailMoreCell.h"
/* 评论 */
#import "HotelDetailCommentHeaderCell.h"
#import "HotelDetailCommentCell.h"
#import "HotelDetailNoCommentCellCell.h"
#import "HotelDetailMoreCommentCell.h"

#import "HotelViewModel.h"


NSString *const kBlankCell = @"BlankCell";
NSString *const kHotelDetailHeaderCell = @"HotelDetailHeaderCell";
NSString *const kHotelDetailMapCell = @"HotelDetailMapCell";
NSString *const kHotelDetailRoomTypeCell = @"HotelDetailRoomTypeCell";
NSString *const kHotelDetailRoomListCell = @"HotelDetailRoomListCell";
NSString *const kHotelDetailRoomPriceTypeCell = @"HotelDetailRoomPriceTypeCell";
NSString *const kHotelDetailMoreCell = @"HotelDetailMoreCell";
NSString *const kHotelDetailCommentHeaderCell = @"HotelDetailCommentHeaderCell";
NSString *const kHotelDetailCommentCell = @"HotelDetailCommentCell";
NSString *const kHotelDetailNoCommentCellCell = @"HotelDetailNoCommentCellCell";
NSString *const kHotelDetailMoreCommentCell = @"HotelDetailMoreCommentCell";


@interface HotelDetailViewController ()<UITableViewDelegate,
UITableViewDataSource, HotelDetailRoomTypeCellDelegate, HotelDetailRoomPriceTypeCellDelegate, HotelDetailDateViewDelegate, HotelDetailHeaderCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray<__kindof ZZFoldCellModel *> *data;
@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) HotelViewModel *viewModel;
@property (nonatomic, assign) HotelRoomType roomType;

@property (nonatomic, strong) NSMutableArray *dayRoomArr;
@property (nonatomic, strong) NSMutableArray *hourRoomArr;

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
    [_tableView registerClass:[HotelDetailCommentHeaderCell class] forCellReuseIdentifier:kHotelDetailCommentHeaderCell];
    [_tableView registerClass:[HotelDetailCommentCell class] forCellReuseIdentifier:kHotelDetailCommentCell];
    [_tableView registerClass:[HotelDetailNoCommentCellCell class] forCellReuseIdentifier:kHotelDetailNoCommentCellCell];
    [_tableView registerClass:[HotelDetailMoreCommentCell class] forCellReuseIdentifier:kHotelDetailMoreCommentCell];
    
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
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return 1;
    }else if(section == 2) {
        if (self.roomType == HotelRoomTypeAllday) {
            return 1+[self.dayRoomArr count];
        }else {
            return 1+[self.hourRoomArr count];
        }
    }else {
        if (_comments.count > 0) {
            return 3;
        }
        return 2;
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
            if (self.roomType == HotelRoomTypeAllday) {
                ZZFoldCellModel *foldCellModel = self.dayRoomArr[indexPath.row-1];
                return foldCellModel.level.intValue==0?65:50;
            }else {
                ZZFoldCellModel *foldCellModel = self.hourRoomArr[indexPath.row-1];
                return foldCellModel.level.intValue==0?65:50;
            }
        }
    }else {
        if (_comments.count > 0) {
            if (indexPath.row == 0) {
                return 80;
            }else if (indexPath.row == 1){
                return 200; // 根据评论及回复内容动态高度
            }
            return 40;
        }else {
            if (indexPath.row == 0) {
                return 80;
            }
            return 120;
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
            cell.hotel = self.hotel;
            cell.delegate = self;
            
            return cell;
        }else if (section == 1 && row == 0) {
            HotelDetailMapCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailMapCell];
            cell.hotel = self.hotel;
            cell.mapViewDidClickBlock = ^{
                MapViewController *map = [MapViewController new];
                map.hotel = self.hotel;
                [[NavManager shareInstance] showViewController:map isAnimated:YES];
            };
            return cell;
        }
        
    }
    else if (section == 2){
        if (row == 0) {
            HotelDetailRoomTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomTypeCell];
            cell.delegate = self;
            return cell;
        }else {

            ZZFoldCellModel *foldCellModel;
            if (self.roomType == HotelRoomTypeAllday) {
                foldCellModel = self.dayRoomArr[indexPath.row-1];
            }else {
                foldCellModel = self.hourRoomArr[indexPath.row-1];
            }
            
            if (foldCellModel.level.intValue == 0) {
                
                HotelDetailRoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomListCell];
                if (self.roomType == HotelRoomTypeAllday) {
                    cell.dayRoom = foldCellModel.dayRoom;
                }else {
                    cell.hourRoom = foldCellModel.hourRoom;
                }
                return cell;
            }else {
                HotelDetailRoomPriceTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailRoomPriceTypeCell];
                cell.delegate = self;
                
                if (self.roomType == HotelRoomTypeAllday) {
                    cell.dayRoom = foldCellModel.dayRoom;
                }else {
                    cell.hourRoom = foldCellModel.hourRoom;
                }
                return cell;
            }
        }
        
    }else {
        if (row == 0) {
            HotelDetailCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailCommentHeaderCell];
            cell.hotelDetail = self.viewModel.hotelDetail;
            return cell;
            
        }else if (indexPath.row == 1) {
            if (_comments.count > 0) {
                HotelDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailCommentCell];
                cell.hotelDetail = self.viewModel.hotelDetail;
                return cell;
            }else {
                HotelDetailNoCommentCellCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailNoCommentCellCell];
                return cell;
            }
        }else {
            HotelDetailMoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kHotelDetailMoreCommentCell];
            cell.hotelDetail = self.viewModel.hotelDetail;
            return cell;
        }
    }
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        if (indexPath.row >= 1) {
            
            ZZFoldCellModel *didSelectFoldCellModel;
            if (self.roomType == HotelRoomTypeAllday) {
                didSelectFoldCellModel = self.dayRoomArr[indexPath.row-1];
            }else {
                didSelectFoldCellModel = self.hourRoomArr[indexPath.row-1];
            }
            
            [tableView beginUpdates];
            if (didSelectFoldCellModel.belowCount == 0) {
                
                //Data
                NSArray *submodels = [didSelectFoldCellModel open];
                NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){indexPath.row + 1-1, submodels.count})];
                
                if (self.roomType == HotelRoomTypeAllday) {
                    [self.dayRoomArr insertObjects:submodels atIndexes:indexes];
                }else {
                    [self.hourRoomArr insertObjects:submodels atIndexes:indexes];
                }
                
                
                //Rows
                NSMutableArray *indexPaths = [NSMutableArray new];
                for (int i = 0; i < submodels.count; i++) {
                    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + 1 + i) inSection:indexPath.section];
                    [indexPaths addObject:insertIndexPath];
                }
                [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                
            }else {
                
                //Data
                NSArray *submodels = nil;
                if (self.roomType == HotelRoomTypeAllday) {
                    submodels = [self.dayRoomArr subarrayWithRange:((NSRange){indexPath.row + 1-1,didSelectFoldCellModel.belowCount})];
                    [didSelectFoldCellModel closeWithSubmodels:submodels];
                    [self.dayRoomArr removeObjectsInArray:submodels];
                }else {
                    submodels = [self.hourRoomArr subarrayWithRange:((NSRange){indexPath.row + 1-1,didSelectFoldCellModel.belowCount})];
                    [didSelectFoldCellModel closeWithSubmodels:submodels];
                    [self.hourRoomArr removeObjectsInArray:submodels];
                }
                
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
        
    }else if(indexPath.section == 3) {
        
        if (_comments.count > 0) {
            if (indexPath.row == 2) {
                HotelCommentListViewController *vc = [HotelCommentListViewController new];
                [[NavManager shareInstance] showViewController:vc isAnimated:YES];
            }
        }
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
    
    [[ShareManager manager] startShare];
}


#pragma mark - HotelDetailRoomTypeCellDelegate

- (void)hotelDetailRoomTypeCellDidClickBtn:(HotelRoomType)type {
    
    self.roomType = type;
    [_tableView reloadData];
}



#pragma mark - HotelDetailHeaderCellDelegate

- (void)hotelDetailHeaderCellDidClickBtn:(HotelDetailHeaderType)type {
    
    if (type == HotelDetailHeaderTypeHotelDetail) {
        HotelDescrViewController *vc = [HotelDescrViewController new];
        vc.hotel = self.hotel;
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }else {
        NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", _hotel.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
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
    if (type == HotelRoomListBtnTypeBook) {
        BookHotelViewController *vc = [BookHotelViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    }
}



#pragma mark - init Data

- (void)initRoomData {
    
    for (NSInteger index = 0; index<[self.viewModel.hotelDetail.dayRoomList count]; index++) {
        
        DayRoom *dayRoom = self.viewModel.hotelDetail.dayRoomList[index];
        ZZFoldCellModel *foldCellModel = [ZZFoldCellModel modelWithDayRoom:dayRoom];
        [_dayRoomArr addObject:foldCellModel];
    }
    
    for (NSInteger index = 0; index<[self.viewModel.hotelDetail.hourRoomList count]; index++) {
        
        HourRoom *hourRoom = self.viewModel.hotelDetail.hourRoomList[index];
        ZZFoldCellModel *foldCellModel = [ZZFoldCellModel modelWithHourRoom:hourRoom];
        [_hourRoomArr addObject:foldCellModel];
    }
}


- (void)initData {
    
    self.roomType = HotelRoomTypeAllday;
    _viewModel = [HotelViewModel new];
    [_viewModel requestSelectApartment:self.storeId storeName:self.storeName checkInTime:self.checkInTime checkOutTime:self.checkOutTime complete:^(HotelDetail *hotelDetail) {
        
        [self initRoomData];
        [_tableView reloadData];
    }];
    
    _dayRoomArr = [[NSMutableArray alloc] initWithCapacity:1];
    _hourRoomArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    NSArray *comments = @[@{@"userid": @"1",
                           @"name": @"Jimcky",
                           @"avatar": @"https://www.baidu.com",
                           @"content": @"这是评论内容",
                           @"reply": @"这是回复内容"
                           },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },
                          @{@"userid": @"1",
                            @"name": @"Jimcky",
                            @"avatar": @"https://www.baidu.com",
                            @"content": @"这是评论内容",
                            @"reply": @"这是回复内容"
                            },];
    _comments = [NSMutableArray new];
    [_comments addObjectsFromArray:comments];
}


@end

