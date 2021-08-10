//
//  FriendData.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendData : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) NSString *isTop;
@property (strong, nonatomic) NSString *fid;
@property (strong, nonatomic) NSString *updateDate;
@property (assign, nonatomic) NSDate *upDate;

+(FriendData *) setData:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
