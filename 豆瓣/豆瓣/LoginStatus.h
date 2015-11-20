//
//  LoginStatus.h
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginStatus : NSObject

@property (assign,nonatomic) BOOL islogin;
@property (assign,nonatomic) NSInteger userId;

+ (LoginStatus *)shareLogin;

@end
