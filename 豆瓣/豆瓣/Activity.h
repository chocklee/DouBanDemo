//
//  Activity.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//归档反归档第一步,遵守<NSCoding>协议
@interface Activity : NSObject <NSCoding>

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *begin_time;
@property (copy,nonatomic) NSString *end_time;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *category_name;
@property (assign,nonatomic) NSInteger participant_count;
@property (assign,nonatomic) NSInteger wisher_count;
@property (copy,nonatomic) NSString *image;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *content;
@property (copy,nonatomic) NSString *timeInterval;


//接受图片
@property (strong,nonatomic) UIImage *imagePhoto;

//判断是否正在加载
@property (assign,nonatomic) BOOL isLoading;

//加载图片方法
- (void)loadImage;

@end
