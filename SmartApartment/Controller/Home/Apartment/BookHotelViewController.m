//
//  BookHotelViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookHotelViewController.h"
#import "AddInvoiceViewController.h"
#import "BookSuccessViewController.h"
#import "WRCellView.h"
#import "BookDetailView.h"
#import "BookBottomView.h"
#import <PPNumberButton/PPNumberButton.h>

#import "HotelConfigView.h"

#import "Hotel.h"
#import "HotelDetail.h"

#import "HotelViewModel.h"
#import "MineViewModel.h"

#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface BookHotelViewController ()<BookBottomViewDelegate, HotelConfigViewDelete, UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView  *containerView;
@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *descrLabel;
@property (nonatomic, strong) UILabel       *dateLabel;

@property (nonatomic, strong) WRCellView    *roomNumView;
@property (nonatomic, strong) WRCellView    *livePersonView;
@property (nonatomic, strong) WRCellView    *phoneNumView;
@property (nonatomic, strong) WRCellView    *arriveTimeView;
@property (nonatomic, strong) WRCellView    *invoiceView;  // 发票
@property (nonatomic, strong) WRCellView    *remarkView;
@property (nonatomic, strong) WRCellView    *tipView;

@property (nonatomic, strong) UILabel       *roomNumLabel;
@property (nonatomic, strong) PPNumberButton *roomNumBtn;
@property (nonatomic, strong) UITextField   *livePersonTF;
@property (nonatomic, strong) UIButton      *livePersonBtn;
@property (nonatomic, strong) UITextField   *phoneNumTF;
@property (nonatomic, strong) UILabel       *arriveTimeLabel;

@property (nonatomic, strong) UILabel       *invoiceLabel;
@property (nonatomic, strong) UITextField   *remarkTF;
@property (nonatomic, strong) UILabel       *tipLabel;

@property (nonatomic, strong) BookDetailView *bookDetailView;
@property (nonatomic, strong) HotelConfigView *hotelConfigView;

@property (nonatomic, strong) HotelViewModel *viewModel;
@property (nonatomic, strong) MineViewModel  *mineViewModel;
@property (nonatomic, strong) RoomConfig     *roomConfig;

@property (nonatomic, strong) NSString       *breakfastId;
@property (nonatomic, strong) NSString       *breakfastNum;
@property (nonatomic, strong) NSString       *fivePieceId;
@property (nonatomic, strong) NSString       *aromaId;
@property (nonatomic, strong) NSString       *roomLayoutId;
@property (nonatomic, strong) NSString       *wineId;

@property (nonatomic, strong) NSMutableArray *contactPersons;



@end


@implementation BookHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iniData];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
}

- (void)iniData {
    
    _viewModel = [HotelViewModel new];
    _mineViewModel = [MineViewModel new];
    
    self.hotelConfigView = [HotelConfigView new];
    self.hotelConfigView.delegate = self;
    
    __WeakObj(self)
    [_viewModel requestRoomConfigure:self.roomTypeId complete:^(RoomConfig *roomConfig) {
        
        selfWeak.roomConfig = roomConfig;
        selfWeak.hotelConfigView.roomConfig = roomConfig;
        [selfWeak.view addSubview:self.hotelConfigView];
    }];
}

- (void)initView {

    _naviLabel.text = @"填写订单";
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, self.view.bounds.size.height-64 - 50)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
}

- (void)addViews {
    [self.containerView addSubview:self.headerView];
    [self.containerView addSubview:self.roomNumView];
    [self.containerView addSubview:self.livePersonView];
    [self.containerView addSubview:self.phoneNumView];
    [self.containerView addSubview:self.arriveTimeView];
    [self.containerView addSubview:self.invoiceView];
    [self.containerView addSubview:self.remarkView];
    [self.containerView addSubview:self.tipView];
    
    [self.roomNumView addSubview:self.roomNumLabel];
    //[self.roomNumView addSubview:self.roomNumBtn];
    [self.livePersonView addSubview:self.livePersonTF];
    [self.livePersonView addSubview:self.livePersonBtn];
    [self.phoneNumView addSubview:self.phoneNumTF];
    [self.arriveTimeView addSubview:self.arriveTimeLabel];
    
    [self.invoiceView addSubview:self.invoiceLabel];
    [self.remarkView addSubview:self.remarkTF];
    [self.tipView addSubview:self.tipLabel];
    
    BookBottomView *bottomView = [BookBottomView new];
    bottomView.roomPrice = self.roomPrice;
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    [bottomView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [bottomView autoSetDimension:ALDimensionHeight toSize:50];
}

- (void)setCellFrame {
    self.roomNumView.frame = CGRectMake(0, _headerView.bottom+10, kScreenWidth, WRCellViewHeight);
    self.livePersonView.frame = CGRectMake(0, _roomNumView.bottom, kScreenWidth, WRCellViewHeight);
    self.phoneNumView.frame = CGRectMake(0, _livePersonView.bottom, kScreenWidth, WRCellViewHeight);
    
    self.arriveTimeView.frame = CGRectMake(0, _phoneNumView.bottom + 10, kScreenWidth, WRCellViewHeight);
    
    self.invoiceView.frame = CGRectMake(0, _arriveTimeView.bottom + 10, kScreenWidth, WRCellViewHeight);
    self.remarkView.frame = CGRectMake(0, _invoiceView.bottom, kScreenWidth, WRCellViewHeight);
    self.tipView.frame = CGRectMake(0, _remarkView.bottom + 10, kScreenWidth, WRCellViewHeight);
    
    if (self.tipView.bottom< (kScreenHeight -64-50)) {
        self.containerView.contentSize = CGSizeMake(0, (kScreenHeight -64-50 + 20));
    }else {
        self.containerView.contentSize = CGSizeMake(0, self.remarkView.top + WRCellViewHeight + 50);
    }
}

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    self.arriveTimeView.tapBlock = ^ {
        __strong typeof(self) pThis = weakSelf;
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"请选择入住时间" delegate:pThis cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"14:00前", @"15:00前", @"16:00前", @"17:00前", @"18:00前", @"19:00前", @"20:00前", @"21:00前", @"22:00前", @"23:00前", @"24:00前", nil];
        // 显示
        actionsheet.tag = 1000;
        [actionsheet showInView:pThis.view];
    };
    
    self.invoiceView.tapBlock = ^{
        
        [weakSelf.hotelConfigView show];
    };
    
}


#pragma mark - UIButton Action

- (void)addLivePersonBtnClick:(id)sender {
    
    if ([_contactPersons count]) {
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"请选择入住人" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
        for( NSString *person in _contactPersons)  {
            [actionsheet addButtonWithTitle:person];
        }
        [actionsheet addButtonWithTitle:@"取消"];
        actionsheet.cancelButtonIndex = [_contactPersons count];
        // 显示
        [actionsheet showInView:self.view];
        
    }else {
        __weak typeof(self) weakSelf = self;
        [_mineViewModel requestQueryCommonInfo:^(NSArray *contacts) {
            
            _contactPersons = [self getPersons:contacts];
            __strong typeof(self) pThis = weakSelf;
            UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"请选择入住人" delegate:pThis cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            for( NSString *person in _contactPersons)  {
                [actionsheet addButtonWithTitle:person];
            }
            [actionsheet addButtonWithTitle:@"取消"];
            actionsheet.cancelButtonIndex = [_contactPersons count];
            // 显示
            [actionsheet showInView:pThis.view];
        }];
    }
}


#pragma mark - Private

- (NSMutableArray *)getPersons:(NSArray *)contacts {
    
    _contactPersons = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *contact in contacts) {
        NSString *name = contact[@"name"];
        [_contactPersons addObject:name];
    }
    return _contactPersons;
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1000) {
        NSArray *times = @[@"14:00前", @"15:00前", @"16:00前", @"17:00前", @"18:00前", @"19:00前", @"20:00前", @"21:00前", @"22:00前", @"23:00前", @"24:00前"];
        if (buttonIndex < [times count]) {
            NSString *time = times[buttonIndex];
            self.arriveTimeLabel.text = time;
        }
    }else {
        if (buttonIndex < [_contactPersons count]) {
            self.livePersonTF.text = _contactPersons[buttonIndex];
        }
    }
}


#pragma mark - HotelConfigViewDelete

- (void)hotelConfigViewDidSelectConfig:(NSString *)breakfastId
                          breakfastNum:(NSString *)breakfastNum
                           fivePieceId:(NSString *)fivePieceId
                               aromaId:(NSString *)aromaId
                          roomLayoutId:(NSString *)roomLayoutId
                                wineId:(NSString *)wineId {
    
    self.breakfastId = breakfastId;
    self.breakfastNum = breakfastNum;
    self.fivePieceId = fivePieceId;
    self.aromaId = aromaId;
    self.roomLayoutId = roomLayoutId;
    self.wineId = wineId;
}


#pragma mark - BookBottomViewDelegate

- (void)bookBottomViewDickBtn:(HotelBookBtnType)type detailShow:(BOOL)show {
    
    if (type == HotelSelectBtnTypeBook) {
        
        NSString *arriveTime = [self.arriveTimeLabel.text stringByReplacingOccurrencesOfString:@"前" withString:@""];
        arriveTime = [NSString stringWithFormat:@"%@ %@", self.checkInTime, arriveTime];
        NSString *name = [self.livePersonTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        __WeakObj(self)
        [_viewModel requestSubmitOrder:self.hotel.storeId
                            roomTypeId:self.roomTypeId
                       checkInRoomType:self.checkInRoomType
                                  name:name
                           mobilePhone:self.phoneNumTF.text
                           checkInTime:self.checkInTime
                          checkOutTime:self.checkOutTime
                            arriveTime:arriveTime
                                remark:self.remarkTF.text
                           breakfastId:self.breakfastId
                          breakfastNum:self.breakfastNum
                           fivePieceId:self.fivePieceId
                               aromaId:self.aromaId
                          roomLayoutId:self.wineId
                                wineId:@"" complete:^(NSDictionary *resp) {
            
                                    BookSuccessViewController *vc = [BookSuccessViewController new];
                                    vc.orderDict = resp;
                                    vc.roomTypeId = selfWeak.roomTypeId;
                                    vc.storeId = selfWeak.hotel.storeId;
                                    [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        }];
    }else {
        if (show) {
            _bookDetailView = [[BookDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
            _bookDetailView.checkInTime = self.checkInTime;
            _bookDetailView.roomPrice = self.roomPrice;
            [self.view addSubview:_bookDetailView];
        }else {
            [_bookDetailView removeFromSuperview];
        }
    }
}



#pragma mark - getter

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 103)];
        
        UIImageView *bgImgV = [UIImageView new];
        bgImgV.frame = _headerView.bounds;
        bgImgV.contentMode = UIViewContentModeScaleAspectFit;
        bgImgV.image = [UIImage imageNamed:@"order_fill_bgiphone"];
        [_headerView addSubview:bgImgV];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, kScreenHeight-30, 25)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.text = self.hotel.storeName;
        [_headerView addSubview:_titleLabel];
        
        _descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _titleLabel.bottom, kScreenHeight-30, 25)];
        _descrLabel.font = [UIFont systemFontOfSize:14];
        _descrLabel.textColor = [UIColor grayColor];
        _descrLabel.text = self.roomTypeName;
        [_headerView addSubview:_descrLabel];
        
        
        
        NSDate *checkinDate = [NSDate sia_dateFromString:self.checkInTime withFormat:@"yyyy-MM-dd"];
        NSDate *checkoutDate = [NSDate sia_dateFromString:self.checkOutTime withFormat:@"yyyy-MM-dd"];
        NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
        
        NSString *checkinDateStr = [NSString sia_stringFromDate:checkinDate withFormat:@"MM月dd"];
        NSString *checkoutDateStr = [NSString sia_stringFromDate:checkoutDate withFormat:@"MM月dd"];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _descrLabel.bottom, kScreenHeight-30, 25)];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.text = [NSString stringWithFormat:@"入住%@ 离店%@ %zd晚", checkinDateStr, checkoutDateStr, days];
        [_headerView addSubview:_dateLabel];
        
    }
    return _headerView;
}

- (WRCellView *)roomNumView {
    if (_roomNumView == nil) {
        _roomNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _roomNumView.leftLabel.text = @"房间数";
    }
    return _roomNumView;
}

- (WRCellView *)livePersonView {
    if (_livePersonView == nil) {
        _livePersonView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Icon];
        _livePersonView.leftLabel.text = @"入住人";
    }
    return _livePersonView;
}

- (WRCellView *)phoneNumView {
    if (_phoneNumView == nil) {
        _phoneNumView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _phoneNumView.leftLabel.text = @"手机号";
        [_arriveTimeView setLineStyleWithLeftZero];
    }
    return _phoneNumView;
}

- (WRCellView *)arriveTimeView {
    if (_arriveTimeView == nil) {
        _arriveTimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _arriveTimeView.leftLabel.text = @"到店时间";
    }
    return _arriveTimeView;
}

- (WRCellView *)invoiceView {
    if (_invoiceView == nil) {
        _invoiceView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _invoiceView.leftLabel.text = @"个性配置";
        _invoiceView.rightLabel.text = @"查看";
    }
    return _invoiceView;
}

- (WRCellView *)remarkView {
    if (_remarkView == nil) {
        _remarkView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_];
        _remarkView.leftLabel.text = @"备注";
        [_remarkView setLineStyleWithLeftZero];
    }
    return _remarkView;
}

- (WRCellView *)tipView {
    if (_tipView == nil) {
        _tipView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Icon];
        _tipView.leftIcon.image = kImage(@"oeder_reminder_iciphone");
    }
    return _tipView;
}


// Custom
- (UILabel *)roomNumLabel {
    if (_roomNumLabel == nil) {
        _roomNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _roomNumLabel.font = [UIFont systemFontOfSize:14];
        _roomNumLabel.textColor = [UIColor darkTextColor];
        _roomNumLabel.text = @"1间";
    }
    return _roomNumLabel;
}

- (PPNumberButton *)roomNumBtn{
    if (!_roomNumBtn) {
        _roomNumBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth - 117, 17.5, 100, 15)];
        // 初始化时隐藏减按钮
        _roomNumBtn.defaultNumber = 1;
        _roomNumBtn.minValue = 1;
        _roomNumBtn.maxValue = 200;
        _roomNumBtn.decreaseHide = YES;
        _roomNumBtn.increaseImage = [UIImage imageNamed:@"order_add_iciphone"];
        _roomNumBtn.decreaseImage = [UIImage imageNamed:@"order_minus_ic_scopyiphone"];
    }
    return _roomNumBtn;
}

- (UITextField *)livePersonTF {
    if (_livePersonTF == nil) {
        _livePersonTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _livePersonTF.font = [UIFont systemFontOfSize:14];
        _livePersonTF.textColor = [UIColor darkTextColor];
        _livePersonTF.text = [UserManager manager].user.name;
    }
    return _livePersonTF;
}

- (UIButton *)livePersonBtn {
    if (!_livePersonBtn) {
        _livePersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _livePersonBtn.frame = CGRectMake(kScreenWidth-35, 15, 20, 20);
        [_livePersonBtn addTarget:self action:@selector(addLivePersonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_livePersonBtn setImage:kImage(@"order_add_iciphone") forState:UIControlStateNormal];
    }
    return _livePersonBtn;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.textColor = [UIColor darkTextColor];
        _phoneNumTF.text = [UserManager manager].user.mobilePhone;
    }
    return _phoneNumTF;
}

- (UILabel *)arriveTimeLabel {
    if (_arriveTimeLabel == nil) {
        _arriveTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _arriveTimeLabel.font = [UIFont systemFontOfSize:14];
        _arriveTimeLabel.textColor = [UIColor darkTextColor];
        _arriveTimeLabel.text = @"19:00前";
    }
    return _arriveTimeLabel;
}

- (UILabel *)invoiceLabel {
    if (_invoiceLabel == nil) {
        _invoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _invoiceLabel.font = [UIFont systemFontOfSize:14];
        _invoiceLabel.textColor = [UIColor darkTextColor];
        //_invoiceLabel.text = @"不需要";
    }
    return _invoiceLabel;
}

- (UITextField *)remarkTF {
    if (_remarkTF == nil) {
        _remarkTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _remarkTF.font = [UIFont systemFontOfSize:14];
        _remarkTF.textColor = [UIColor darkTextColor];
        _remarkTF.placeholder = @"需要告知公寓的特殊要求";
    }
    return _remarkTF;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _tipLabel.text = @"请于入住日中午12:00后办理入住，如提前到店，视公寓空房情况安排";
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.frame = CGRectMake(40, 0, kScreenWidth-72, WRCellViewHeight);
    }
    return _tipLabel;
}

@end
