//
//  MainTabViewController.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <UIKit/UIKit.h>
#import "DemoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTabViewController : UITabBarController

@property (assign, nonatomic) ITEMTYPE itemType;

-(id)initWithType:(ITEMTYPE) itemType;

@end

NS_ASSUME_NONNULL_END
