//
//  ZZFoldCellModel.h
//  ZZFoldCell
//
//  Created by 郭旭赞 on 2017/7/6.
//  Copyright © 2017年 郭旭赞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayRoom.h"
#import "HourRoom.h"

@interface ZZFoldCellModel : NSObject

@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *level;
//...

@property(nonatomic,assign) NSUInteger belowCount;
@property(nullable,nonatomic) ZZFoldCellModel *supermodel;
@property(nonatomic,strong) NSMutableArray<__kindof ZZFoldCellModel *> *submodels;

@property (nonatomic, strong) DayRoom *dayRoom;
@property (nonatomic, strong) HourRoom *hourRoom;

+ (instancetype)modelWithDic:(NSDictionary *)dic;

+ (instancetype)modelWithDayRoom:(DayRoom *)dayRoom;
+ (instancetype)modelWithHourRoom:(HourRoom *)hourRoom;

- (NSArray *)open;
- (void)closeWithSubmodels:(NSArray *)submodels;

@end
