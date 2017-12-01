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

@property (nonatomic, strong) Breakfast       *breakfast;
@property (nonatomic, copy) NSString          *breakfastNum;
@property (nonatomic, strong) FivePiece       *fivePiece;
@property (nonatomic, strong) Aroma           *aroma;
@property (nonatomic, strong) RoomLayout      *roomLayout;
@property (nonatomic, strong) Wine            *wine;
@property (nonatomic, strong) NSMutableArray       *sectionTitles;

@property (nonatomic, assign) NSInteger      selectedIndex;

@end


@implementation HotelConfigView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        _breakfastNum = @"1";
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
        cell = [[HotelConfigCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
    }
    
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
    
    cell.clearSelectedIndex = self.selectedIndex;
    
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
    view.didSelectedBreakfastNum = ^(NSInteger num){
        self.breakfastNum = [NSString stringWithFormat:@"%zd", num];
    };
    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - HotelConfigCollectionCellDelegate

- (void)hotelConfigCollectionCellDidSelectedConfig:(id)object {
    
    if ([object isKindOfClass:[Breakfast class]]) {
        self.breakfast = object;
    }else if ([object isKindOfClass:[FivePiece class]]) {
        self.fivePiece = object;
    }else if ([object isKindOfClass:[RoomLayout class]]) {
        self.roomLayout = object;
    }else if ([object isKindOfClass:[Aroma class]]) {
        self.aroma = object;
    }else if ([object isKindOfClass:[Wine class]]) {
        self.wine = object;
    }
}

- (void)hotelConfigCollectionCellUpdateSelectedIndex:(NSInteger)index {
    
    self.selectedIndex = index;
}


#pragma mark - Button Action

- (void)cancelBtnClick:(id)sender {
    
    self.selectedIndex = -1;
    
    self.breakfast = nil;
    self.breakfastNum = nil;
    self.fivePiece = nil;
    self.aroma = nil;
    self.roomLayout = nil;
    self.wine = nil;
    
    [_tableView reloadData];
}

- (void)confirmBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigViewDidSelectConfig:breakfastNum:fivePieceId:aromaId:roomLayoutId:wineId:)]) {
        [self.delegate hotelConfigViewDidSelectConfig:self.breakfast
                                         breakfastNum:self.breakfastNum
                                          fivePieceId:self.fivePiece
                                              aromaId:self.aroma
                                         roomLayoutId:self.roomLayout
                                               wineId:self.wine];
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
