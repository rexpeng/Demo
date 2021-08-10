//
//  NavigateView.h
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum _NaviType {
    TRANSFER, WITHDRAW, SCAN
} NaviType;

@protocol NavigateViewDelegate <NSObject>

-(void)naviBtnClick:(NaviType) btnType;

@end

@interface NavigateView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) id<NavigateViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *withdrawBtn;
@property (weak, nonatomic) IBOutlet UIImageView *transferBtn;
@property (weak, nonatomic) IBOutlet UIImageView *scanBtn;


@end

NS_ASSUME_NONNULL_END
