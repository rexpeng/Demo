//
//  UserData.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserData : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *kokoid;
@property (strong, nonatomic) UIImage *image;

+(UserData *) setData:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
