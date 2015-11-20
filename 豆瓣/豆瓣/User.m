//
//  User.m
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "User.h"

static User *handler = nil;

@implementation User

+ (instancetype)userWithName:(NSString *)userName andPassword:(NSString *)userPassword andEmail:(NSString *)userEmail andPhone:(NSString *)userPhone {
    User *u = [[User alloc] init];
    u.userName = userName;
    u.userPassword = userPassword;
    u.userEmail = userEmail;
    u.userPhone = userPhone;
    return u;
}

@end
