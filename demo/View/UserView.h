//
//  UserView.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum _BtnType {
    USERIMAGE, SETID
} BtnType;

@protocol UserViewDelegate <NSObject>

-(void)BtnClick:(BtnType) btnType;

@end

@interface UserView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *setID;
@property (weak, nonatomic) IBOutlet UIImageView *infoBack;


@property (weak, nonatomic) id<UserViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
