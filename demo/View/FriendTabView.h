//
//  FriendTabView.h
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import "CountLabel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _TabType {
    FRIEND, TALK
} TabType;

@protocol FriendTabViewDelegate <NSObject>

-(void)tabBtnClick:(TabType) btnType;

@end
@interface FriendTabView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *friendTab;
@property (weak, nonatomic) IBOutlet UILabel *talkTab;
@property (weak, nonatomic) IBOutlet UIView *friendInd;
@property (weak, nonatomic) IBOutlet UIView *talkInd;

@property (strong, nonatomic) IBOutlet CountLabel *friendCountView;
@property (strong, nonatomic) IBOutlet CountLabel *talkCountView;

@property (weak, nonatomic) id<FriendTabViewDelegate> delegate;

-(void)setFriendCountValue:(NSInteger) count;
-(void)setTalkCountValue:(NSInteger) count;

@end

NS_ASSUME_NONNULL_END
