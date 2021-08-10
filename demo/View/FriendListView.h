//
//  FriendListView.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <UIKit/UIKit.h>
#import "FriendData.h"
#import "FriendViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FriendListViewDelegate <NSObject>

-(void) friendClick:(ActionType) actionType withData:(FriendData *) data;
-(void) refreshFriendList;
-(void) searchAddClick;
-(void) searchShouldBeginEdit;
-(void) searchDidEndEdit;

@end

@interface FriendListView : UIView

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UITextField *searchField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *searchAddBtn;

@property (strong, nonatomic) NSArray *friendItems;

@property (weak, nonatomic) id<FriendListViewDelegate> delegate;

-(void)setItems:(NSArray *)friendItems;

-(void)refreshStart;
-(void)refreshEnd;

@end

NS_ASSUME_NONNULL_END
