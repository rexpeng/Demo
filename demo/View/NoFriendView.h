//
//  NoFriendView.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NoFriendViewDelegate <NSObject>

-(void) addFriendClick;
-(void) setIDClick;

@end

@interface NoFriendView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *button;

@property (weak, nonatomic) IBOutlet UILabel *attrLabel;

@property (weak, nonatomic) id<NoFriendViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
