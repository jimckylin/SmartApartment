#import "YZTabBarController.h"

#import "HomeViewController.h"
#import "MineViewController.h"
#import "ActivityViewController.h"
#import "TripHelperViewController.h"


@interface RootTabBarController : YZTabBarController

@property (nonatomic, strong) HomeViewController        *homeVC;
@property (nonatomic, strong) MineViewController        *mineVC;
@property (nonatomic, strong) ActivityViewController    *actVC;
@property (nonatomic, strong) TripHelperViewController  *tripVC;

@end
