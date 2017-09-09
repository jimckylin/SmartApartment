//
//  RechargeView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/25.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "RechargeView.h"
#import "RechargeItemCell.h"
#import "WRCellView.h"

#define WRCellViewHeight  50

@interface RechargeView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, strong) WRCellView    *aliPayView;
@property (nonatomic, strong) WRCellView    *wechatPayView;
@property (nonatomic, strong) UIButton      *payBtn;

@property (nonatomic, strong) NSDictionary *rechargeDic;
@property (nonatomic, copy) NSString *payType; //  支付方式（0-微信支付，1-支付宝支付）

@end

@implementation RechargeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    if (self) {
        [self onClickEvent];
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    //这个是横向滑动
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [self addSubview:_collectionView];
    [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // cell注册
    [_collectionView registerClass:[RechargeItemCell class] forCellWithReuseIdentifier:@"RechargeItemCell"];
    //这是头部
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    
}

- (void)setMoneyList:(NSArray *)moneyList {
    
    _moneyList = moneyList;
    self.rechargeDic = moneyList[0];
    self.payType = @"1";   // 默认选择支付宝
    
    [_collectionView reloadData];
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


#pragma mark - UICollectionViewDelegate UICollectionViewDataSource

//一共有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    NSInteger sections = 1;
    return sections;
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_moneyList count];
}

//每一个cell是什么
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RechargeItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RechargeItemCell" forIndexPath:indexPath];
    NSDictionary *rechargeDic = _moneyList[indexPath.row];
    cell.rechargeDic = rechargeDic;
    [self setCellStyle:cell];
    
    return cell;
}

//头部和脚部的加载
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UILabel *chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 20)];
        chargeLabel.font = [UIFont boldSystemFontOfSize:14];
        chargeLabel.textColor = [UIColor darkTextColor];
        chargeLabel.text = @"充值金额";
        [view addSubview:chargeLabel];
        
    }else {
        UIView *footerView = [self collectionFooterView];
        [view addSubview:footerView];
    }
    return view;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}


//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//头部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(50, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 280);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellwidth = (kScreenWidth-30)/2;
    return CGSizeMake(cellwidth, 74);
}

//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *rechargeDic = _moneyList[indexPath.row];
    self.rechargeDic = rechargeDic;
}


#pragma mark - Button Action

- (void)onClickEvent {
    
    __weak typeof(self) weakSelf = self;
    // 支付选择
    self.aliPayView.tapBlock = ^ {
        weakSelf.payType = @"1";
        weakSelf.aliPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
        weakSelf.wechatPayView.rightIndicator.image = kImage(@"reserve_payiphone");
    };
    self.wechatPayView.tapBlock = ^ {
        weakSelf.payType = @"0";
        weakSelf.aliPayView.rightIndicator.image = kImage(@"reserve_payiphone");
        weakSelf.wechatPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
    };
    
}

- (void)payBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rechargeViewDidClickRechargeBtn:rechargeDic:)]) {
        [self.delegate rechargeViewDidClickRechargeBtn:self.payType rechargeDic:self.rechargeDic];
    }
}


#pragma mark - Private

- (UIView *)collectionFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 280)];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 100, 20)];
    typeLabel.font = [UIFont boldSystemFontOfSize:14];
    typeLabel.textColor = [UIColor darkTextColor];
    typeLabel.text = @"选择支付方式";
    [footerView addSubview:typeLabel];
    
    [footerView addSubview:self.aliPayView];
    [footerView addSubview:self.wechatPayView];
    self.aliPayView.frame = CGRectMake(0, typeLabel.bottom+15, kScreenWidth, WRCellViewHeight);
    self.wechatPayView.frame = CGRectMake(0, _aliPayView.bottom, kScreenWidth, WRCellViewHeight);
    
    [footerView addSubview:self.payBtn];
    return footerView;
}

- (WRCellView *)aliPayView {
    if (_aliPayView == nil) {
        _aliPayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _aliPayView.leftIcon.image = kImage(@"reserve_pay_1_iciphone");
        _aliPayView.rightIndicator.image = kImage(@"reserve_pay_siphone");
        _aliPayView.leftLabel.text = @"支付宝支付";
    }
    return _aliPayView;
}

- (WRCellView *)wechatPayView {
    if (_wechatPayView == nil) {
        _wechatPayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleIconLabel_Indicator];
        _wechatPayView.leftIcon.image = kImage(@"wechat_iciphone");
        _wechatPayView.rightIndicator.image = kImage(@"reserve_payiphone");
        _wechatPayView.leftLabel.text = @"微信支付";
    }
    return _wechatPayView;
}

- (UIButton *)payBtn {
    
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(21, self.wechatPayView.bottom + 50, kScreenWidth-42, 44);
        _payBtn.backgroundColor = ThemeColor;
        [_payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_payBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [_payBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        _payBtn.layer.cornerRadius = 44/2;
        _payBtn.layer.masksToBounds = YES;
    }
    return _payBtn;
}


- (void)setCellStyle:(RechargeItemCell *)cell {
    
    cell.layer.cornerRadius = 5;
    cell.contentView.layer.cornerRadius = 5.0f;
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.borderColor = [UIColor colorWithHexString:@"#FCF742"].CGColor;
    cell.contentView.layer.masksToBounds = YES;
}

@end
