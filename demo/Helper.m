//
//  Helper.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "Helper.h"

@implementation Helper

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (void) HttpRequest:(NSString *)urlstr params:(NSDictionary * __nullable) params complete:(void (^)(NSArray * result)) complete {
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    if(params == nil) {
        [request setHTTPMethod:@"GET"];
    } else {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[NSKeyedArchiver archivedDataWithRootObject:params requiringSecureCoding:NO error:nil]];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSArray *result;
        
        if(error == nil) {
            //NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            result = json[@"response"];
        } else {
            result = nil;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(result);
        });
    }];
    
    [task resume];
}

@end
