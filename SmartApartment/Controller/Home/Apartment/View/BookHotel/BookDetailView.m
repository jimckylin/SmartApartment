//
//  BookDetailView.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/27.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "BookDetailView.h"
#import "BookConsumeListCell.h"

@interface BookDetailView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BookDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initData {
    _dataArray = [[NSMutableArray alloc] initWithCapacity:1];
}

- (void)initView {
    self.backgroundColor = RGBA(0, 0, 0, 0.5);
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = self.bounds;
    [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeTop];
    [_tableView registerClass:[BookConsumeListCell class] forCellReuseIdentifier:@"BookConsumeListCell"];
    
    // header
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _bgView;
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.text = @"明细";
    [_bgView addSubview:detailLabel];
    
    [detailLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [detailLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_bgView addSubview:line];
}


- (void)setCheckInTime:(NSString *)checkInTime
          checkOutTime:(NSString *)checkOutTime
             roomPrice:(NSString *)price
           roomDeposit:(NSString *)deposit
         roomRisePrice:(NSString *)risePrice
             breakfast:(Breakfast *)breakfast
          breakfastNum:(NSString *)breakfastNum
             fivePiece:(FivePiece *)fivePiece
                 aroma:(Aroma *)aroma
            roomLayout:(RoomLayout *)roomLayout
                  wine:(Wine *)wine {
    
    NSMutableArray *arr = [NSMutableArray array];
    if (price) {
        NSDate *checkinDate = [NSDate sia_dateFromString:checkInTime withFormat:@"yyyy-MM-dd"];
        NSDate *checkoutDate = [NSDate sia_dateFromString:checkOutTime withFormat:@"yyyy-MM-dd"];
        NSInteger days = [checkinDate daysBeforeDate:checkoutDate];
        NSDictionary *dic = @{[NSString stringWithFormat:@"%@至%@(%zd晚)", checkInTime, checkOutTime, days]
                              : [NSString stringWithFormat:@"￥%@ x %zd", price, days]};
        [arr addObject:dic];
    }
    if (deposit) {
        NSDictionary *dic = @{@"押金" : [NSString stringWithFormat:@"￥%@", deposit]};
        [arr addObject:dic];
    }
    if (risePrice) {
        NSDictionary *dic = @{@"涨价" : [NSString stringWithFormat:@"￥%@", risePrice]};
        [arr addObject:dic];
    }
    if (breakfast) {
        NSDictionary *dic = @{breakfast.name : [NSString stringWithFormat:@"￥%@ x %@份", breakfast.price, breakfastNum]};
        [arr addObject:dic];
    }
    if (fivePiece) {
        NSDictionary *dic = @{fivePiece.name : [NSString stringWithFormat:@"￥%@", fivePiece.price]};
        [arr addObject:dic];
    }
    if (aroma) {
        NSDictionary *dic = @{aroma.name : [NSString stringWithFormat:@"￥%@", aroma.price]};
        [arr addObject:dic];
    }
    if (roomLayout) {
        NSDictionary *dic = @{roomLayout.name : [NSString stringWithFormat:@"￥%@", roomLayout.price]};
        [arr addObject:dic];
    }
    if (wine) {
        NSDictionary *dic = @{wine.name : [NSString stringWithFormat:@"￥%@", wine.price]};
        [arr addObject:dic];
    }
    
    _dataArray = arr;
    
    CGFloat height = 35 + 44 + ([arr count]- 1)*28;
    [_tableView autoSetDimension:ALDimensionHeight toSize:height];
    [_tableView reloadData];
}




#pragma mark - UIButton Action

- (void)bgBtnClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44;
    }
    return 28;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookConsumeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookConsumeListCell" forIndexPath:indexPath];
    NSDictionary *consumeDic = self.dataArray[indexPath.row];
    cell.consumeDic = consumeDic;
    //[cell addLineWithType:BMLineTypeCustomDefault color:nil position:BMLinePostionCustomBottom];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
