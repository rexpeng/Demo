//
//  FriendData.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "FriendData.h"

@implementation FriendData

+(FriendData *) setData:(NSDictionary *) dict {
    FriendData *data = [FriendData new];
    
    data.name = dict[@"name"];
    data.status = [dict[@"status"] integerValue];
    data.isTop = dict[@"isTop"];
    data.fid = dict[@"fid"];
    data.updateDate = dict[@"updateDate"];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [dateFormatter dateFromString:data.updateDate];
    if(date == nil) {
        [dateFormatter setDateFormat:@"yyyyMMdd"];
        date = [dateFormatter dateFromString:data.updateDate];
    }
    data.upDate = date;
    
    return data;
}

@end
