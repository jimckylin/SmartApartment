//
//  HotelDescrViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/18.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HotelDescrViewController.h"
#import "MapViewController.h"

#import "HotelConfigCell.h"
#import "HotelDetailMapCell.h"
#import "HotelDescrCell.h"
#import "BlankCell.h"
#import "Hotel.h"

@interface HotelDescrViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation HotelDescrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubView];
}

- (void)initSubView {
    
    _naviLabel.text = @"酒店介绍";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[HotelDescrCell class] forCellReuseIdentifier:@"HotelDescrCell"];
    [_tableView registerClass:[BlankCell class] forCellReuseIdentifier:@"BlankCell"];
    [_tableView registerClass:[HotelConfigCell class] forCellReuseIdentifier:@"HotelConfigCell"];
    [_tableView registerClass:[HotelDetailMapCell class] forCellReuseIdentifier:@"HotelDetailMapCell"];
    [self.view addSubview:_tableView];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 0) {
        return [HotelConfigCell getCellHeight:self.hotel];
    }else if (section == 1) {
        return 40;
    }else if (section == 2) {
        return 101;
    }
    return [HotelDescrCell getDescrCellHeight:self.hotel];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section == 0) {
        HotelConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelConfigCell"];
        cell.hotel = self.hotel;
        return cell;
        
    }else if (section == 1) {
        BlankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlankCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.imageView.image = kImage(@"detail_phone_iciphone");
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.text = [NSString stringWithFormat:@"酒店电话(%@)", @"135608065986"];
        return cell;
        
    }else if (section == 2) {
        HotelDetailMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDetailMapCell"];
        cell.hotel = self.hotel;
        cell.mapViewDidClickBlock = ^{
            MapViewController *map = [MapViewController new];
            map.hotel = self.hotel;
            [[NavManager shareInstance] showViewController:map isAnimated:YES];
        };
        return cell;
        
    }else if (section == 3) {
        HotelDescrCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDescrCell"];
        cell.hotel = self.hotel;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-4154-451"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}



#pragma mark - UIButton Action






@end
