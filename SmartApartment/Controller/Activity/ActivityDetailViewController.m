//
//  ActivityDetailViewController.m
//  SmartApartment
//
//  Created by Jimcky Lin on 2017/8/12.
//  Copyright © 2017年 Jimcky Lin. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _naviLabel.text = NSLocalizedString(@"活动详情", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end