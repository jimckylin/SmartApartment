//
//  HomeViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/6.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "BannerDetailViewController.h"

#import "HotelSelectView.h"


@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
//    self.barView = [self mainNavBarWithtitle:@"WisdomApartment"
//                                  RightImage:nil
//                                   leftImage:nil
//                                 rightBtnSEL:nil
//                                  leftBtnSEL:nil];
//    self.barView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.barView];

    //[self setDefaultNavTitle:NSLocalizedString(@"WisdomApartment", nil) rightBtnTitle:nil];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    [self.view addSubview:bgView];
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    SDCycleScrollView *bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 500, kScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"snapshot"]];
    bannerView.imageURLStringsGroup = imagesURLStrings;
    bannerView.autoScrollTimeInterval = 5;

    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [bgView addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _tableView.tableHeaderView = bannerView;
}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 290;
    }else {
        return 150;
    }
}


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdetifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifier];
        
        if (indexPath.row == 0) {
            HotelSelectView *selectView = [[HotelSelectView alloc] init];
            [cell addSubview:selectView];
        }
        
    }
    
    return cell;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long)index);
    BannerDetailViewController *bannerDetail = [BannerDetailViewController new];
    [[NavManager shareInstance] showViewController:bannerDetail isAnimated:YES];
}

@end
