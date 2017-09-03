//
//  ZZFoldCellModel.m
//  ZZFoldCell
//
//  Created by 郭旭赞 on 2017/7/6.
//  Copyright © 2017年 郭旭赞. All rights reserved.
//

#import "ZZFoldCellModel.h"

@implementation ZZFoldCellModel

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    ZZFoldCellModel *foldCellModel = [ZZFoldCellModel new];
    foldCellModel.text = dic[@"text"];
    foldCellModel.level = dic[@"level"];
    foldCellModel.belowCount = 0;
    
    foldCellModel.submodels = [NSMutableArray new];
    NSArray *submodels = dic[@"submodels"];
    for (int i = 0; i < submodels.count; i++) {
        ZZFoldCellModel *submodel = [ZZFoldCellModel modelWithDic:(NSDictionary *)submodels[i]];
        submodel.supermodel = foldCellModel;
        [foldCellModel.submodels addObject:submodel];
    }
    
    return foldCellModel;
}

+ (instancetype)modelWithDayRoom:(DayRoom *)dayRoom {
    
    ZZFoldCellModel *foldModel = [ZZFoldCellModel new];
    foldModel.dayRoom = dayRoom;
    foldModel.level = @"0";
    foldModel.belowCount = 0;
    
    
    ZZFoldCellModel *subFoldModel = [ZZFoldCellModel new];
    subFoldModel.dayRoom = dayRoom;
    subFoldModel.level = @"1";
    subFoldModel.belowCount = 0;
    subFoldModel.supermodel = foldModel;
    
    foldModel.submodels = [NSMutableArray new];
    [foldModel.submodels addObject:subFoldModel];
    
    return foldModel;
}

+ (instancetype)modelWithHourRoom:(HourRoom *)hourRoom {
    
    ZZFoldCellModel *foldModel = [ZZFoldCellModel new];
    foldModel.hourRoom = hourRoom;
    foldModel.level = @"0";
    foldModel.belowCount = 0;
    
    
    ZZFoldCellModel *subFoldModel = [ZZFoldCellModel new];
    subFoldModel.hourRoom = hourRoom;
    subFoldModel.level = @"1";
    subFoldModel.belowCount = 0;
    subFoldModel.supermodel = foldModel;
    
    foldModel.submodels = [NSMutableArray new];
    [foldModel.submodels addObject:subFoldModel];
    
    return foldModel;
}


- (NSArray *)open {
    NSArray *submodels = self.submodels;
    self.submodels = nil;
    self.belowCount = submodels.count;
    return submodels;
}

- (void)closeWithSubmodels:(NSArray *)submodels {
    self.submodels = [NSMutableArray arrayWithArray:submodels];
    self.belowCount = 0;
}

- (void)setBelowCount:(NSUInteger)belowCount {
    self.supermodel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

@end
