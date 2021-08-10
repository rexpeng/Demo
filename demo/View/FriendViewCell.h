//
//  FriendViewCell.h
//  demo
//
//  Created by Rex on 2021/8/9.
//

#import <UIKit/UIKit.h>
#import "FriendData.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _ActionType {
    TRANSFERACTION, INVITEACTION, MOREACTION, ITEMACTION
} ActionType;

#define ActionTypeValue(operation) [[[NSArray alloc] initWithObjects: @"forTransfer", @"forInvite", @"forMore", @"forItem", nil] objectAtIndex: operation];

@protocol FriendViewCellDelegate <NSObject>

-(void) friendClick:(ActionType) actionType withData:(FriendData *) data;

@end

@interface FriendViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *star;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *transfer;
@property (weak, nonatomic) IBOutlet UIView *invite;
@property (weak, nonatomic) IBOutlet UIImageView *friendMore;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *space;

@property (strong, nonatomic) FriendData *friendData;

@property (weak, nonatomic) id<FriendViewCellDelegate> delegate;

-(void)setView:(FriendData *)data;

@end

NS_ASSUME_NONNULL_END
