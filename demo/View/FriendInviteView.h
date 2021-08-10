//
//  FriendInviteView.h
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import "FriendData.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    AGREE, DELETE
} InviteType;

@protocol FriendInviteViewDelegate <NSObject>

-(void)ItemClick:(InviteType) inviteType withData:(FriendData *)data;

@end

@interface FriendInviteView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *agreeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *deleteBtn;

@property (strong, nonatomic) FriendData *friendData;
@property (weak, nonatomic) id<FriendInviteViewDelegate> delegate;

-(void)setData:(FriendData *)data;

@end

NS_ASSUME_NONNULL_END
