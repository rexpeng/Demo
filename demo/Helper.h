//
//  Helper.h
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface Helper : NSObject

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (void) HttpRequest:(NSString *)urlstr params:(NSDictionary * __nullable) params complete:(void (^)(NSArray * result)) complete;

@end

NS_ASSUME_NONNULL_END
