//
//  HotelConfigCell.m
//  SmartApartment
//
//  Created by jimcky on 2017/9/15.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelConfigCell.h"
#import "HotelConfigHeaderView.h"
#import "HotelConfigItemCell.h"
#import "RoomConfig.h"


@interface HotelConfigCell ()<HotelConfigItemCellDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
// 用来存放Cell的唯一标示符
@property (nonatomic, strong) NSMutableDictionary *cellDic;

@property (nonatomic, strong) NSMutableArray<Breakfast*> *breakfasts;
@property (nonatomic, strong) NSMutableArray             *breakfastNums;
@property (nonatomic, strong) NSMutableArray<Wine*>      *wines;
@property (nonatomic, strong) NSMutableArray             *wineNums;


@end

@implementation HotelConfigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.section = section;
        self.cellDic = [[NSMutableDictionary alloc] init];
        [self initView];
        
    }
    
    return self;
}

- (void)initView {
    
    /*
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
    [_collectionView registerClass:[HotelConfigItemCell class] forCellWithReuseIdentifier:@"HotelConfigItemCell"];*/
}

- (void)setClearAroma:(BOOL)clearAroma {
    
    _clearAroma = clearAroma;
    if (clearAroma) {
        [self clearSelfView];
    }
}

- (void)setClearBreakfast:(BOOL)clearBreakfast {
    
    _clearBreakfast = clearBreakfast;
    if (clearBreakfast) {
        [self clearSelfView];
    }
}

- (void)setClearFivePiece:(BOOL)clearFivePiece {
    
    _clearFivePiece = clearFivePiece;
    if (clearFivePiece) {
        [self clearSelfView];
    }
}

- (void)setClearRoomLayout:(BOOL)clearRoomLayout {
    
    _clearRoomLayout = clearRoomLayout;
    if (clearRoomLayout) {
        [self clearSelfView];
    }
}

- (void)setClearWine:(BOOL)clearWine {
    
    _clearWine = clearWine;
    if (clearWine) {
        [self clearSelfView];
    }
}



- (void)updateClearConfigFlag:(HotelConfigType)configType {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellUpdateSelectedIndex:)]) {
        [self.delegate hotelConfigCollectionCellUpdateSelectedIndex:configType];
    }
}


#pragma mark - Setter

- (void)setAromaList:(NSArray<Aroma *> *)aromaList {
    
    if (!_aromaList || _clearAroma) {
        _clearAroma = NO;
        [self updateClearConfigFlag:HotelConfigTypeAroma];
        
        CGFloat originX = 10;
        CGFloat originY = 10;
        CGFloat itemWidth = ((kScreenWidth - 30) - 30)/2;
        CGFloat itemHeight = 120;
        
        for (int index = 0; index < aromaList.count; index ++) {
            CGFloat shang = index/2;
            CGFloat yushu = index%2;
            CGRect frame = CGRectMake((yushu+1)*originX + itemWidth*yushu, (shang+1) * originY + itemHeight*shang, itemWidth, itemHeight);
            
            HotelConfigItemCell *configItemView = [[HotelConfigItemCell alloc] initWithFrame:frame];
            configItemView.aroma = aromaList[index];
            configItemView.configType = HotelConfigTypeAroma;
            configItemView.delegate = self;
            configItemView.tag = index+100;
            [self addSubview:configItemView];
            
            __WeakObj(self)
            configItemView.didChangeSelectedBtnStatus = ^(NSInteger tag, BOOL selected, NSInteger num) {
                for (NSInteger idx = 0; idx < aromaList.count; idx ++) {
                    HotelConfigItemCell *cell = [selfWeak viewWithTag:idx+100];
                    if (tag-100 != idx) {
                        [cell setSelectedBtnStatus:NO];
                    }
                }
                
                Aroma *aroma = selected? aromaList[index]:nil;
                if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [selfWeak.delegate hotelConfigCollectionCellDidSelectedConfig:aroma nums:nil configType:HotelConfigTypeAroma];
                }
            };
        }
    }
    
    _aromaList = aromaList;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = nil;
}

- (void)setBreakfastList:(NSArray<Breakfast *> *)breakfastList {
    
    if (!_breakfastList || _clearBreakfast) {
        _clearBreakfast = NO;
        [self.breakfasts removeAllObjects];
        [self.breakfastNums removeAllObjects];
        [self updateClearConfigFlag:HotelConfigTypeBreakfast];
        
        CGFloat originX = 10;
        CGFloat originY = 10;
        CGFloat itemWidth = ((kScreenWidth - 30) - 30)/2;
        CGFloat itemHeight = 120;
        
        for (int index = 0; index < breakfastList.count; index ++) {
            CGFloat shang = index/2;
            CGFloat yushu = index%2;
            CGRect frame = CGRectMake((yushu+1)*originX + itemWidth*yushu, (shang+1) * originY + itemHeight*shang, itemWidth, itemHeight);
            
            HotelConfigItemCell *configItemView = [[HotelConfigItemCell alloc] initWithFrame:frame];
            configItemView.breakfast = breakfastList[index];
            configItemView.configType = HotelConfigTypeBreakfast;
            configItemView.delegate = self;
            configItemView.tag = index;
            [self addSubview:configItemView];
            
            __WeakObj(self)
            // 点击勾选按钮
            configItemView.didChangeSelectedBtnStatus = ^(NSInteger tag, BOOL selected, NSInteger num) {
                
                Breakfast *breakfast = breakfastList[index];
                if (selected) {
                    if (![selfWeak.breakfasts containsObject:breakfast]) {
                        [selfWeak.breakfasts addObject:breakfast];
                        [selfWeak.breakfastNums addObject:[NSString stringWithFormat:@"%zd", num]];
                    }
                } else {
                    if ([selfWeak.breakfasts containsObject:breakfast]) {
                        NSInteger breakfastIndex = [selfWeak.breakfasts indexOfObject:breakfast];
                        [selfWeak.breakfasts removeObject:breakfast];
                        [selfWeak.breakfastNums removeObjectAtIndex:breakfastIndex];
                    }
                }
                if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [selfWeak.delegate hotelConfigCollectionCellDidSelectedConfig:selfWeak.breakfasts nums:selfWeak.breakfastNums configType:HotelConfigTypeBreakfast];
                }
            };
            
            // 点击数量按钮
            configItemView.didSelectedBreakfastConfigNum = ^(Breakfast *breakfast, NSInteger num) {
                
                if ([selfWeak.breakfasts containsObject:breakfast]) {
                    NSInteger breakfastIndex = [selfWeak.breakfastList indexOfObject:breakfast];
                    NSString *numStr = [NSString stringWithFormat:@"%zd", num];
                    [selfWeak.breakfastNums replaceObjectAtIndex:breakfastIndex withObject:numStr];
                }
                if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [selfWeak.delegate hotelConfigCollectionCellDidSelectedConfig:selfWeak.breakfasts nums:selfWeak.breakfastNums configType:HotelConfigTypeBreakfast];
                }
            };
        }
    }
    
    _aromaList = nil;
    _breakfastList = breakfastList;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = nil;
}

- (void)setFivePieceList:(NSArray<FivePiece *> *)fivePieceList {
    
    if (!_fivePieceList || _clearFivePiece) {
        _clearFivePiece = NO;
        [self updateClearConfigFlag:HotelConfigTypeFivePiece];
        
        CGFloat originX = 10;
        CGFloat originY = 10;
        CGFloat itemWidth = ((kScreenWidth - 30) - 30)/2;
        CGFloat itemHeight = 120;
        
        for (int index = 0; index < fivePieceList.count; index ++) {
            CGFloat shang = index/2;
            CGFloat yushu = index%2;
            CGRect frame = CGRectMake((yushu+1)*originX + itemWidth*yushu, (shang+1) * originY + itemHeight*shang, itemWidth, itemHeight);
            
            HotelConfigItemCell *configItemView = [[HotelConfigItemCell alloc] initWithFrame:frame];
            configItemView.fivePiece = fivePieceList[index];
            configItemView.configType = HotelConfigTypeFivePiece;
            configItemView.delegate = self;
            configItemView.tag = index+100;
            [self addSubview:configItemView];
            
            __WeakObj(self)
            configItemView.didChangeSelectedBtnStatus = ^(NSInteger tag, BOOL selected, NSInteger num) {
                for (NSInteger idx = 0; idx < fivePieceList.count; idx ++) {
                    HotelConfigItemCell *cell = [selfWeak viewWithTag:idx+100];
                    if (tag-100 != idx) {
                        [cell setSelectedBtnStatus:NO];
                    }
                }
                
                FivePiece *fivePiece = selected? fivePieceList[index]:nil;
                if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [self.delegate hotelConfigCollectionCellDidSelectedConfig:fivePiece nums:nil configType:HotelConfigTypeFivePiece];
                }
            };
        }
    }
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = fivePieceList;
    _roomLayoutList = nil;
    _wineList = nil;
}

- (void)setRoomLayoutList:(NSArray<RoomLayout *> *)roomLayoutList {
    
    if (!_roomLayoutList || _clearRoomLayout) {
        _clearRoomLayout = NO;
        [self updateClearConfigFlag:HotelConfigTypeRoomLayout];
        
        CGFloat originX = 10;
        CGFloat originY = 10;
        CGFloat itemWidth = ((kScreenWidth - 30) - 30)/2;
        CGFloat itemHeight = 120;
        
        for (int index = 0; index < roomLayoutList.count; index ++) {
            CGFloat shang = index/2;
            CGFloat yushu = index%2;
            CGRect frame = CGRectMake((yushu+1)*originX + itemWidth*yushu, (shang+1) * originY + itemHeight*shang, itemWidth, itemHeight);
            
            HotelConfigItemCell *configItemView = [[HotelConfigItemCell alloc] initWithFrame:frame];
            configItemView.roomLayout = roomLayoutList[index];
            configItemView.configType = HotelConfigTypeRoomLayout;
            configItemView.delegate = self;
            configItemView.tag = index+100;
            [self addSubview:configItemView];
            
            __WeakObj(self)
            configItemView.didChangeSelectedBtnStatus = ^(NSInteger tag, BOOL selected, NSInteger num) {
                for (NSInteger idx = 0; idx < roomLayoutList.count; idx ++) {
                    HotelConfigItemCell *cell = [selfWeak viewWithTag:idx+100];
                    if (tag-100 != idx) {
                        [cell setSelectedBtnStatus:NO];
                    }
                }
                
                RoomLayout *roomLayout = selected? roomLayoutList[index]:nil;
                if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [self.delegate hotelConfigCollectionCellDidSelectedConfig:roomLayout nums:nil configType:HotelConfigTypeRoomLayout];
                }
            };
        }
    }
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = roomLayoutList;
    _wineList = nil;
}

- (void)setWineList:(NSArray<Wine *> *)wineList {
    
    if (!_wineList || _clearWine) {
        _clearWine = NO;
        [self.wines removeAllObjects];
        [self.wineNums removeAllObjects];
        [self updateClearConfigFlag:HotelConfigTypeWine];
        
        CGFloat originX = 10;
        CGFloat originY = 10;
        CGFloat itemWidth = ((kScreenWidth - 30) - 30)/2;
        CGFloat itemHeight = 120;
        
        for (int index = 0; index < wineList.count; index ++) {
            CGFloat shang = index/2;
            CGFloat yushu = index%2;
            CGRect frame = CGRectMake((yushu+1)*originX + itemWidth*yushu, (shang+1) * originY + itemHeight*shang, itemWidth, itemHeight);
            
            HotelConfigItemCell *configItemView = [[HotelConfigItemCell alloc] initWithFrame:frame];
            configItemView.wine = wineList[index];
            configItemView.configType = HotelConfigTypeWine;
            configItemView.delegate = self;
            configItemView.tag = index;
            [self addSubview:configItemView];
            
            __WeakObj(self)
            // 点击勾选按钮
            configItemView.didChangeSelectedBtnStatus = ^(NSInteger tag, BOOL selected, NSInteger num) {
                
                Wine *wine = wineList[index];
                if (selected) {
                    if (![selfWeak.wines containsObject:wine]) {
                        [selfWeak.wines addObject:wine];
                        [selfWeak.wineNums addObject:[NSString stringWithFormat:@"%zd", num]];
                    }
                } else {
                    if ([selfWeak.wines containsObject:wine]) {
                        NSInteger wineIndex = [selfWeak.wines indexOfObject:wine];
                        [selfWeak.wines removeObject:wine];
                        [selfWeak.wineNums removeObjectAtIndex:wineIndex];
                    }
                }
                if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [selfWeak.delegate hotelConfigCollectionCellDidSelectedConfig:selfWeak.wines nums:selfWeak.wineNums configType:HotelConfigTypeWine];
                }
            };
            
            // 点击数量按钮
            configItemView.didSelectedWineConfigNum = ^(Wine *wine, NSInteger num) {
                
                if ([selfWeak.wines containsObject:wine]) {
                    NSInteger wineIndex = [selfWeak.wines indexOfObject:wine];
                    NSString *numStr = [NSString stringWithFormat:@"%zd", num];
                    [selfWeak.wineNums replaceObjectAtIndex:wineIndex withObject:numStr];
                }
                if (selfWeak.delegate && [selfWeak.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidSelectedConfig:nums:configType:)]) {
                    [selfWeak.delegate hotelConfigCollectionCellDidSelectedConfig:selfWeak.wines nums:selfWeak.wineNums configType:HotelConfigTypeWine];
                }
            };
        }
    }
    
    _aromaList = nil;
    _breakfastList = nil;
    _fivePieceList = nil;
    _roomLayoutList = nil;
    _wineList = wineList;
}


#pragma mark - Public

+ (CGFloat)getCellHeight:(NSArray *)arr {
    
    CGFloat heigth = 0;
    CGFloat padding = 10;
    CGFloat itemHeight = 120;
    
    NSInteger count = [arr count]-1;
    
    CGFloat shang = count/2;
    //CGFloat yushu = count%2;
    
    if (count > 0) {
        heigth = itemHeight * (shang+1) + (shang+2)*padding;
    }
    return heigth;
}


#pragma mark - Private

- (void)clearSelfView {
    
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}


#pragma mark - HotelConfigItemCellDelegate

- (void)hotelConfigItemCellTapImageDidSelectedIndex:(NSInteger)index
                                          configTpe:(HotelConfigType)configType
                                               view:(UIView *)view {
    
    NSMutableArray *imgUrls = [[NSMutableArray alloc] initWithCapacity:0];
    switch (configType) {
        case HotelConfigTypeAroma: {
            for (Aroma *aroma in _aromaList) {
                [imgUrls addObject:aroma.img];
            }
        }
            break;
        case HotelConfigTypeBreakfast: {
            for (Breakfast *breakfast in _breakfastList) {
                [imgUrls addObject:breakfast.img];
            }
        }
            break;
        case HotelConfigTypeFivePiece: {
            for (FivePiece *fivePiece in _fivePieceList) {
                [imgUrls addObject:fivePiece.img];
            }
        }
            break;
        case HotelConfigTypeRoomLayout: {
            for (RoomLayout *roomLayout in _roomLayoutList) {
                [imgUrls addObject:roomLayout.img];
            }
        }
            break;
        case HotelConfigTypeWine: {
            for (Wine *wine in _wineList) {
                [imgUrls addObject:wine.img];
            }
        }
            break;
            
        default:
            break;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotelConfigCollectionCellDidTapImage:selectedIndex:view:)]) {
        [self.delegate hotelConfigCollectionCellDidTapImage:imgUrls selectedIndex:index view:view];
    }
}


#pragma mark - Lazy init

- (NSMutableArray<Breakfast *> *)breakfasts {
    
    if (!_breakfasts) {
        _breakfasts = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _breakfasts;
}

- (NSMutableArray *)breakfastNums {
    if (!_breakfastNums) {
        _breakfastNums = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _breakfastNums;
}

- (NSMutableArray<Wine *> *)wines {
    if (!_wines) {
        _wines = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _wines;
}

- (NSMutableArray *)wineNums {
    if (!_wineNums) {
        _wineNums = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _wineNums;
}

@end
