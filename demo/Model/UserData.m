//
//  UserData.m
//  demo
//
//  Created by Rex on 2021/8/8.
//

#import "UserData.h"

@implementation UserData


+(UserData *) setData:(NSDictionary *)dict {
    UserData *userData = [UserData new];
    userData.name = dict[@"name"];
    userData.kokoid = dict[@"kokoid"];
    
    return userData;
}

@end
