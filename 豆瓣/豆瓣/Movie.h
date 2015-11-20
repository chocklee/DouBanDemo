//
//  Movie.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject <NSCoding>

@property (copy,nonatomic) NSString *movieName;
@property (copy,nonatomic) NSString *pic_url;
@property (copy,nonatomic) NSString *movieId;

//详情属性
@property (copy,nonatomic) NSString *rating;
@property (copy,nonatomic) NSString *plot_simple;
@property (copy,nonatomic) NSString *release_date;
@property (copy,nonatomic) NSString *actors;
@property (copy,nonatomic) NSString *runtime;
@property (copy,nonatomic) NSString *genres;
@property (copy,nonatomic) NSString *country;
@property (copy,nonatomic) NSString *rating_count;

//接受图片
@property (strong,nonatomic) UIImage *imagePhoto;

//判断是否正在加载
@property (assign,nonatomic) BOOL isLoading;

//加载图片方法
- (void)loadImage;

@end
