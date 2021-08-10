//
//  MainTabViewController.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "MainTabViewController.h"
#import "DemoViewController.h"
#import "Helper.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface MainTabViewController () <UITabBarControllerDelegate>

@end

@implementation MainTabViewController

-(id) initWithType:(ITEMTYPE) itemType {
    self = [super init];
    if(self) {
        self.itemType = itemType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupTabBar];
}

-(void) setupTabBar {
    self.tabBar.translucent = NO;
    [[UITabBar appearance]setBackgroundColor:[UIColor colorWithWhite:1 alpha:1.0]];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIViewController *vc1 = [UIViewController new];
    DemoViewController *vc2 = [DemoViewController new];
    UIViewController *vc3 = [UIViewController new];
    UIViewController *vc4 = [UIViewController new];
    UIViewController *vc5 = [UIViewController new];
    
    UIImage *img1 = [[UIImage imageNamed:@"icTabbarProductsOff"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img2 = [[UIImage imageNamed:@"icTabbarFriendsOn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img3 = [[UIImage imageNamed:@"icTabbarHomeOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img4 = [[UIImage imageNamed:@"icTabbarManageOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img5 = [[UIImage imageNamed:@"icTabbarSettingOff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:img1 tag:0];
    [vc1.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:img2 tag:1];
    [vc2.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:img3 tag:2];
    [vc3.tabBarItem setImageInsets:UIEdgeInsetsMake(-5, 0, 5, 0)];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:img4 tag:3];
    [vc4.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    vc5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:img5 tag:4];
    [vc5.tabBarItem setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];

    NSMutableArray *vcs = [NSMutableArray new];
    [vcs addObject:vc1];
    [vcs addObject:vc2];
    [vcs addObject:vc3];
    [vcs addObject:vc4];
    [vcs addObject:vc5];

    [self setViewControllers:vcs];
    
    [self setSelectedViewController:vcs[1]];
    
    [self setDelegate:self];
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    NSInteger idx = [tabBarController.viewControllers indexOfObject:viewController];
    
    if(idx == 0) {
        ViewController *vc = [ViewController new];
        AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
        appDelegate.window.rootViewController = vc;
        [appDelegate.window makeKeyAndVisible];
        return YES;
    }
    
    if(idx != 1) {
        
        return NO;
    }
    
    
    return YES;
}

@end
