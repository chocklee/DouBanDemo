//
//  LoginStatus.m
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "LoginStatus.h"

static LoginStatus *handler = nil;

@implementation LoginStatus

+ (LoginStatus *)shareLogin {
    if (handler == nil) {
        handler = [[LoginStatus alloc] init];
    }
    return handler;
}

@end
