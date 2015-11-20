//
//  User.h
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (assign,nonatomic) NSInteger userId;

@property (copy,nonatomic) NSString *userName;

@property (copy,nonatomic) NSString *userPassword;

@property (copy,nonatomic) NSString *userEmail;

@property (copy,nonatomic) NSString *userPhone;


+ (instancetype)userWithName:(NSString *)userName andPassword:(NSString *)userPassword andEmail:(NSString *)userEmail andPhone:(NSString *)userPhone;


@end
