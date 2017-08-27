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


#define WRCellViewHeight  50
#define CustomViewX       110
#define CustomViewWidth   150

@interface BookHotelViewController ()<BookBottomViewDelegate, UIActionSheetDelegate>

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

@end


@implementation BookHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
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
    [self.roomNumView addSubview:self.roomNumBtn];
    [self.livePersonView addSubview:self.livePersonTF];
    [self.livePersonView addSubview:self.livePersonBtn];
    [self.phoneNumView addSubview:self.phoneNumTF];
    [self.arriveTimeView addSubview:self.arriveTimeLabel];
    
    [self.invoiceView addSubview:self.invoiceLabel];
    [self.remarkView addSubview:self.remarkTF];
    [self.tipView addSubview:self.tipLabel];
    
    BookBottomView *bottomView = [BookBottomView new];
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
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"请选择入住时间" delegate:pThis cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"12:00前", @"13:00前", @"14:00前", @"15:00前", @"16:00前", @"17:00前", @"18:00前", @"19:00前", @"20:00前", @"21:00前", @"22:00前", @"23:00前", @"24:00前", nil];
        // 显示
        [actionsheet showInView:pThis.view];
    };
    
    self.invoiceView.tapBlock = ^{
        AddInvoiceViewController *vc = [AddInvoiceViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
    };
    
}


#pragma mark - 

- (void)btnClick:(id)sender {
    
    
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSArray *times = @[@"12:00前", @"13:00前", @"14:00前", @"15:00前", @"16:00前", @"17:00前", @"18:00前", @"19:00前", @"20:00前", @"21:00前", @"22:00前", @"23:00前", @"24:00前"];
    if (buttonIndex < [times count]) {
        NSString *time = times[buttonIndex];
        self.arriveTimeLabel.text = time;
    }
}


#pragma mark - BookBottomViewDelegate

- (void)bookBottomViewDickBtn:(HotelBookBtnType)type detailShow:(BOOL)show {
    
    if (type == HotelSelectBtnTypeBook) {
        BookSuccessViewController *vc = [BookSuccessViewController new];
        [[NavManager shareInstance] showViewController:vc isAnimated:YES];
        
    }else {
        if (show) {
            _bookDetailView = [[BookDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)];
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
        _titleLabel.text = @"尚客优酒店北京怀柔区北房镇幸福大街店";
        [_headerView addSubview:_titleLabel];
        
        _descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _titleLabel.bottom, kScreenHeight-30, 25)];
        _descrLabel.font = [UIFont systemFontOfSize:14];
        _descrLabel.textColor = [UIColor grayColor];
        _descrLabel.text = @"高级麻将套房";
        [_headerView addSubview:_descrLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, _descrLabel.bottom, kScreenHeight-30, 25)];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textColor = [UIColor grayColor];
        _dateLabel.text = @"入住08月19日 离店08月20日 1晚";
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
        _invoiceView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Indicator];
        _invoiceView.leftLabel.text = @"发票";
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
        _livePersonTF.text = @"Jimcky Lin";
    }
    return _livePersonTF;
}

- (UIButton *)livePersonBtn {
    if (!_livePersonBtn) {
        _livePersonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _livePersonBtn.frame = CGRectMake(kScreenWidth-35, 15, 20, 20);
        [_livePersonBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_livePersonBtn setImage:kImage(@"order_add_iciphone") forState:UIControlStateNormal];
    }
    return _livePersonBtn;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _phoneNumTF.font = [UIFont systemFontOfSize:14];
        _phoneNumTF.textColor = [UIColor darkTextColor];
        _phoneNumTF.text = @"15606025989";
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
        _invoiceLabel.text = @"不需要";
    }
    return _invoiceLabel;
}

- (UITextField *)remarkTF {
    if (_remarkTF == nil) {
        _remarkTF = [[UITextField alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _remarkTF.font = [UIFont systemFontOfSize:14];
        _remarkTF.textColor = [UIColor darkTextColor];
        _remarkTF.placeholder = @"需要告知酒店的特殊要求";
    }
    return _remarkTF;
}

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(CustomViewX, 0, 175, WRCellViewHeight)];
        _tipLabel.text = @"请于入住日中午12:00后办理入住，如提前到店，视酒店空房情况安排";
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.frame = CGRectMake(40, 0, kScreenWidth-72, WRCellViewHeight);
    }
    return _tipLabel;
}

@end
