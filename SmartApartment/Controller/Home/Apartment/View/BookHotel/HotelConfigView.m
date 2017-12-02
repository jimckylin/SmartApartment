//
//  HotelConfigView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigView.h"
#import "HotelConfigCell.h"
#import "HotelConfigHeaderView.h"


#import "Hotel.h"
#import <PPNumberButton/PPNumberButton.h>

NSString *const kHotelConfigCollectionCell = @"kHotelConfigCollectionCell";

@interface HotelConfigView ()<UITableViewDelegate, UITableViewDataSource, HotelConfigCollectionCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray<Breakfast*> *breakfasts;
@property (nonatomic, strong) NSArray         *breakfastNums;
@property (nonatomic, strong) FivePiece       *fivePiece;
@property (nonatomic, strong) Aroma           *aroma;
@property (nonatomic, strong) RoomLayout      *roomLayout;
@property (nonatomic, strong) NSArray<Wine*>  *wines;
@property (nonatomic, strong) NSArray         *wineNums;
@property (nonatomic, strong) NSMutableArray       *sectionTitles;

@property (nonatomic, assign) BOOL      clearAromaConfig;
@property (nonatomic, assign) BOOL      clearBreakfastConfig;
@property (nonatomic, assign) BOOL      clearFivePieceConfig;
@property (nonatomic, assign) BOOL      clearRoomLayoutConfig;
@property (nonatomic, assign) BOOL      clearWineConfig;

@end


@implementation HotelConfigView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        _sectionTitles = [[NSMutableArray alloc] initWithCapacity:1];
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.bounds;
    [btn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, kScreenWidth-50, 400)];
    bgView.backgroundColor = RGBA(255, 255, 255, 1);
    bgView.center = self.center;
    [self addSubview:bgView];
    
    _tableView = [UITableView new];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotelConfigCell class] forCellReuseIdentifier:kHotelConfigCollectionCell];
    [_tableView registerClass:[HotelConfigHeaderView class] forHeaderFooterViewReuseIdentifier:@"HotelConfigHeaderView"];
    [bgView addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30, 0, 40, 0)];
    
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.text = @"您可选择的套餐";
    [bgView addSubview:titleLabel];
    [titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [titleLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [cancelBtn setTitle:@"重置" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:confirmBtn];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [cancelBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [cancelBtn autoSetDimensionsToSize:CGSizeMake(bgView.width/2, 44)];
    
    [confirmBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cancelBtn];
    [confirmBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [confirmBtn autoSetDimensionsToSize:CGSizeMake(bgView.width/2, 44)];
    
    [line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:cancelBtn];
    [line autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:cancelBtn withOffset:10];
    [line autoSetDimensionsToSize:CGSizeMake(0.5, 33)];
}

- (void)setRoomConfig:(RoomConfig *)roomConfig {
    
    _roomConfig = roomConfig;
    [self setSectionTitlesWith:roomConfig];
    [_tableView reloadData];
}



#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger sections = 0;
    if (_roomConfig.breakfastList) {
        sections ++;
    }
    if (_roomConfig.fivePieceList) {
        sections ++;
    }
    if (_roomConfig.roomLayoutList) {
        sections ++;
    }
    if (_roomConfig.aromaList) {
        sections ++;
    }
    if (_roomConfig.wineList) {
        sections ++;
    }
    
    return _roomConfig?5:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        return [HotelConfigCell getCellHeight:_roomConfig.breakfastList];
    }
    if (section == 1) {
        return [HotelConfigCell getCellHeight:_roomConfig.fivePieceList];
    }
    if (section == 2) {
        return [HotelConfigCell getCellHeight:_roomConfig.roomLayoutList];
    }
    if (section == 3) {
        return [HotelConfigCell getCellHeight:_roomConfig.aromaList];
    }
    if (section == 4) {
        return [HotelConfigCell getCellHeight:_roomConfig.wineList];
    }
    
    return 0;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [NSString stringWithFormat:@"kHotelConfigCollectionCell%zd%zd", indexPath.section, indexPath.row];
    HotelConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HotelConfigCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId section:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
    }
    
    // 重置
    cell.clearAroma = self.clearAromaConfig;
    cell.clearBreakfast = self.clearBreakfastConfig;
    cell.clearFivePiece = self.clearFivePieceConfig;
    cell.clearRoomLayout = self.clearRoomLayoutConfig;
    cell.clearWine = self.clearWineConfig;
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        cell.breakfastList = _roomConfig.breakfastList;
    }
    else if (section == 1) {
        cell.fivePieceList = _roomConfig.fivePieceList;
    }
    else if (section == 2) {
        cell.roomLayoutList = _roomConfig.roomLayoutList;
    }
    else if (section == 3) {
        cell.aromaList = _roomConfig.aromaList;
    }
    else if (section == 4) {
        cell.wineList = _roomConfig.wineList;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0 && _roomConfig.breakfastList) {
        return 44;
    }
    else if (section == 1 && _roomConfig.fivePieceList) {
        return 44;
    }
    else if (section == 2 && _roomConfig.roomLayoutList) {
        return 44;
    }
    else if (section == 3 && _roomConfig.aromaList) {
        return 44;
    }
    else if (section == 4 && _roomConfig.wineList) {
        return 44;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HotelConfigHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HotelConfigHeaderView"];
    view.title = [self setSectionTitlesWith:_roomConfig][section];
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - HotelConfigCollectionCellDelegate

- (void)hotelConfigCollectionCellDidSelectedConfig:(id)object
                                              nums:(NSArray *)nums
                                        configType:(HotelConfigType)configType {
    
    switch (configType) {
        case HotelConfigTypeAroma:
            self.aroma = object;
            break;
        case HotelConfigTypeBreakfast:
        {
            self.breakfasts = object;
            self.breakfastNums = nums;
        }
            break;
        case HotelConfigTypeFivePiece:
            self.fivePiece = object;
            break;
        case HotelConfigTypeRoomLayout:
            self.roomLayout = object;
            break;
        case HotelConfigTypeWine:
        {
            self.wines = object;
            self.wineNums = nums;
        }
            break;
            
        default:
            break;
    }
}

- (void)hotelConfigCollectionCellUpdateSelectedIndex:(HotelConfigType)type {
    
    switch (type) {
        case HotelConfigTypeAroma:
            self.clearAromaConfig = NO;
            break;
        case HotelConfigTypeBreakfast:
            self.clearBreakfastConfig = NO;
            break;
        case HotelConfigTypeFivePiece:
            self.clearFivePieceConfig = NO;
            break;
        case HotelConfigTypeRoomLayout:
            self.clearRoomLayoutConfig = NO;
            break;
        case HotelConfigTypeWine:
            self.clearWineConfig = NO;
            break;
            
        default:
            break;
    }
}

- (void)hotelConfigCollectionCellDidTapImage:(NSArray *)imgUrls
                               selectedIndex:(NSInteger)index
                                        view:(UIView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigViewDidTapImage:selectedIndex:view:)]) {
        [self.delegate hotelConfigViewDidTapImage:imgUrls selectedIndex:index view:view];
    }
}


#pragma mark - Button Action

- (void)cancelBtnClick:(id)sender {
    
    self.clearAromaConfig = YES;
    self.clearBreakfastConfig = YES;
    self.clearFivePieceConfig = YES;
    self.clearRoomLayoutConfig = YES;
    self.clearWineConfig = YES;
    
    self.breakfasts = nil;
    self.breakfastNums = nil;
    self.fivePiece = nil;
    self.aroma = nil;
    self.roomLayout = nil;
    self.wines = nil;
    self.wineNums = nil;
    
    [_tableView reloadData];
}

- (void)confirmBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigViewDidSelectConfig:breakfastNums:fivePieceId:aromaId:roomLayoutId:wines:wineNums:)]) {
        [self.delegate hotelConfigViewDidSelectConfig:self.breakfasts
                                        breakfastNums:self.breakfastNums
                                          fivePieceId:self.fivePiece
                                              aromaId:self.aroma
                                         roomLayoutId:self.roomLayout
                                                wines:self.wines
                                             wineNums:self.wineNums];
    }
    [self hide];
}


#pragma mark - Public

- (void)show {
    
    self.hidden = NO;
}

- (void)hide {
    
    self.hidden = YES;
}



#pragma mark - Private

- (NSArray *)setSectionTitlesWith:(RoomConfig *)roomConfig {
    
    [_sectionTitles removeAllObjects];
    if (roomConfig.breakfastList) {
        [_sectionTitles addObject:@"早餐"];
    }
    if (roomConfig.fivePieceList) {
        [_sectionTitles addObject:@"五件套"];
    }
    if (roomConfig.roomLayoutList) {
        [_sectionTitles addObject:@"房间布局"];
    }
    if (roomConfig.aromaList) {
        [_sectionTitles addObject:@"香气"];
    }
    if (roomConfig.wineList) {
        [_sectionTitles addObject:@"酒水"];
    }
    
    return @[@"早餐", @"五件套", @"房间布局", @"香气", @"酒水"];
}

@end
