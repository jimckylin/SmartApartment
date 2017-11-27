//
//  HotelConfigCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigCollectionCell.h"
#import "HotelConfigHeaderView.h"
#import "HotelConfigItemCell.h"
#import "RoomConfig.h"


@interface HotelConfigCollectionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger      selectedIndex; // 初始-1 不选中任何

@end

@implementation HotelConfigCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        _selectedIndex = -1;
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
    [_collectionView registerClass:[HotelConfigItemCell class] forCellWithReuseIdentifier:@"HotelConfigItemCell"];
}


#pragma mark - Setter

- (void)setAromaList:(NSArray<Aroma *> *)aromaList {
    
    _aromaList = aromaList;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = nil;
    
    [_collectionView reloadData];
}

- (void)setBreakfastList:(NSArray<Breakfast *> *)breakfastList {
    
    _aromaList = nil;
    _breakfastList = breakfastList;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = nil;
    [_collectionView reloadData];
}

- (void)setFivePieceList:(NSArray<FivePiece *> *)fivePieceList {
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = fivePieceList;
    _roomLayoutList = nil;
    _wineList = nil;
    [_collectionView reloadData];
}

- (void)setRoomLayoutList:(NSArray<RoomLayout *> *)roomLayoutList {
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = roomLayoutList;
    _wineList = nil;
    [_collectionView reloadData];
}

- (void)setWineList:(NSArray<Wine *> *)wineList {
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = wineList;
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate UICollectionViewDataSource

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.breakfastList) {
        return [self.breakfastList count];
    }
    else if (self.fivePieceList) {
        return [self.fivePieceList count];
    }
    else if (self.roomLayoutList) {
        return [self.roomLayoutList count];
    }
    else if (self.aromaList) {
        return [self.aromaList count];
    }
    else if (self.wineList) {
        return [self.wineList count];
    }
    return 0;
}

//每一个cell是什么
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotelConfigItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotelConfigItemCell" forIndexPath:indexPath];
    [self setCellStyle:cell];
    
    NSInteger row = indexPath.row;
    if (self.breakfastList) {
        cell.breakfast = self.breakfastList[row];
    }
    else if (self.fivePieceList) {
        cell.fivePiece = self.fivePieceList[row];
    }
    else if (self.roomLayoutList) {
        cell.roomLayout = self.roomLayoutList[row];
    }
    else if (self.aromaList) {
        cell.aroma = self.aromaList[row];
    }
    else if (self.wineList) {
        cell.wine = self.wineList[row];
    }
    
    if (self.clearSelectedIndex == -1) {
        _selectedIndex = -1;
        //[cell setCellSelected:NO];
    }else {
        if (indexPath.row == _selectedIndex) {
            //[cell setCellSelected:YES];
        }else {
            //[cell setCellSelected:NO];
        }
    }
    
    return cell;
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}


//每一个分组的上左下右间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellwidth = (kScreenWidth-50-10 - 20)/2;
    return CGSizeMake(cellwidth, 120);
}

//cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    
    NSInteger row = indexPath.row;
    if (self.breakfastList) {
        Breakfast *breakfast = self.breakfastList[row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:)]) {
            [self.delegate hotelConfigCollectionCellDidSelectedConfig:breakfast];
        }
    }
    else if (self.fivePieceList) {
        FivePiece *fivePiece = self.fivePieceList[row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:)]) {
            [self.delegate hotelConfigCollectionCellDidSelectedConfig:fivePiece];
        }
    }
    else if (self.roomLayoutList) {
        RoomLayout *roomLayout = self.roomLayoutList[row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:)]) {
            [self.delegate hotelConfigCollectionCellDidSelectedConfig:roomLayout];
        }
    }
    else if (self.aromaList) {
        Aroma *aroma = self.aromaList[row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:)]) {
            [self.delegate hotelConfigCollectionCellDidSelectedConfig:aroma];
        }
    }
    else if (self.wineList) {
        Wine *wine = self.wineList[row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:)]) {
            [self.delegate hotelConfigCollectionCellDidSelectedConfig:wine];
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellUpdateSelectedIndex:)]) {
        [self.delegate hotelConfigCollectionCellUpdateSelectedIndex:-2];
    }
    
    self.clearSelectedIndex = 0;
    _selectedIndex = indexPath.row;
    [collectionView reloadData];
}


#pragma mark - Public

+ (CGFloat)getCellHeight:(NSArray *)arr {
    
    CGFloat heigth = 0;
    CGFloat padding = 15;
    NSInteger count = [arr count];
    
    CGFloat shang = count/2;
    CGFloat yushu = count%2;
    
    if (count > 0) {
        heigth = 5+ 120 * (shang+(yushu?1:0)) +(shang+(yushu?1:0)-1)*padding+5;
    }
    return heigth;
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
