//
//  FriendInviteListView.h
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import "FriendInviteView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FriendInviteListViewDelegate <NSObject>

-(void)inviteClick:(InviteType) inviteType withData:(FriendData *)data;
-(void)hidenInviteList:(BOOL)isHiden;

@end

@interface FriendInviteListView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *inviteHeaderLabel;

@property (weak, nonatomic) id<FriendInviteListViewDelegate> delegate;

@property (strong, nonatomic) NSArray *friendItems;

-(void)setData:(NSArray *) friendItems;
-(BOOL)isInviteListHidden;

@end

NS_ASSUME_NONNULL_END
