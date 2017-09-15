//
//  HotelConfigView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/9/4.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigView.h"
#import "HotelConfigHeaderView.h"
#import "HotelConfigItemCell.h"
#import "RoomConfig.h"


@interface HotelConfigView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;


@property (nonatomic, strong) NSString       *breakfastId;
@property (nonatomic, strong) NSString       *breakfastNum;
@property (nonatomic, strong) NSString       *fivePieceId;
@property (nonatomic, strong) NSString       *aromaId;
@property (nonatomic, strong) NSString       *roomLayoutId;
@property (nonatomic, strong) NSString       *wineId;

@end

@implementation HotelConfigView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self initView];
    }
    
    return self;
}

- (void)initView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, kScreenWidth-50, 400)];
    bgView.backgroundColor = RGBA(255, 255, 255, 1);
    bgView.center = self.center;
    [self addSubview:bgView];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.allowsMultipleSelection = YES;
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    //这个是横向滑动
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [bgView addSubview:_collectionView];
    [_collectionView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30, 0, 40, 0)];
    
    // cell注册
    [_collectionView registerClass:[HotelConfigItemCell class] forCellWithReuseIdentifier:@"HotelConfigItemCell"];
    //这是头部
    [_collectionView registerClass:[HotelConfigHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotelConfigHeaderView"];
    
    
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
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
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
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate UICollectionViewDataSource

//一共有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
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
    
    return sections;
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [_roomConfig.breakfastList count];
    }
    else if (section == 1) {
        return [_roomConfig.fivePieceList count];
    }
    else if (section == 2) {
        return [_roomConfig.roomLayoutList count];
    }
    else if (section == 3) {
        return [_roomConfig.aromaList count];
    }
    else if (section == 4) {
        return [_roomConfig.wineList count];
    }
    return 0;
}

//每一个cell是什么
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotelConfigItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotelConfigItemCell" forIndexPath:indexPath];
    [self setCellStyle:cell];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        cell.breakfast = _roomConfig.breakfastList[row];
    }
    else if (section == 1) {
        cell.fivePiece = _roomConfig.fivePieceList[row];
    }
    else if (section == 2) {
        cell.roomLayout = _roomConfig.roomLayoutList[row];
    }
    else if (section == 3) {
        cell.aroma = _roomConfig.aromaList[row];
    }
    else if (section == 4) {
        cell.wine = _roomConfig.wineList[row];
    }
    
    return cell;
}

//头部和脚部的加载
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSArray *titles = @[@"早餐", @"五件套", @"房间布局", @"香气", @"酒水"];
        
        HotelConfigHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HotelConfigHeaderView" forIndexPath:indexPath];
        view.title = titles[indexPath.section];
        
        return view;
    }
    return nil;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}


//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//头部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(50, 44);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellwidth = (kScreenWidth-50-10 - 20)/2;
    return CGSizeMake(cellwidth, 100);
}

//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        Breakfast *breakfast = _roomConfig.breakfastList[row];
        self.breakfastId = breakfast.breakfastId;
    }
    else if (section == 1) {
        FivePiece *fivePiece = _roomConfig.fivePieceList[row];
        self.fivePieceId = fivePiece.fivePieceId;
    }
    else if (section == 2) {
        RoomLayout *roomLayout = _roomConfig.roomLayoutList[row];
        self.roomLayoutId = roomLayout.roomLayoutId;
    }
    else if (section == 3) {
        Aroma *aroma = _roomConfig.aromaList[row];
        self.aromaId = aroma.aromaId;
    }
    else if (section == 4) {
        Wine *wine = _roomConfig.wineList[row];
        self.wineId = wine.wineId;
    }
}


#pragma mark - Button Action

- (void)cancelBtnClick:(id)sender {
    
    [self removeFromSuperview];
}

- (void)confirmBtnClick:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigViewDidSelectConfig:breakfastNum:fivePieceId:aromaId:roomLayoutId:wineId:)]) {
        [self.delegate hotelConfigViewDidSelectConfig:self.breakfastId
                                         breakfastNum:@"1"
                                          fivePieceId:self.fivePieceId
                                              aromaId:self.aromaId
                                         roomLayoutId:self.roomLayoutId
                                               wineId:self.wineId];
    }
    [self removeFromSuperview];
}


#pragma mark - Private

- (void)setCellStyle:(HotelConfigItemCell *)cell {
    
    cell.layer.cornerRadius = 5;
    cell.contentView.layer.cornerRadius = 5.0f;
    cell.contentView.layer.borderWidth = 0.5f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;
    
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(1, 1);
    cell.layer.shadowRadius = 2.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
}

@end
