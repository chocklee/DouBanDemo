//
//  DataBaseTool.h
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "User.h"
#import "Activity.h"
#import "Movie.h"

@interface DataBaseTool : NSObject

+ (DataBaseTool *)shareDataBaseTool;

//打开数据库
- (void)openDataBase;

//关闭数据库
- (void)closeDataBase;

//创建数据库表
- (void)createTable:(NSString *)sql;

//添加数据
- (void)addData:(User *)user;

//根据用户名查询数据
- (User *)selectData:(NSString *)username;

//查询所有数据
- (NSArray *)selectAllData;

//添加收藏
- (void)addActivityData:(NSString *)title andUserId:(NSInteger)userId;
- (void)addMovieData:(NSString *)title andUserId:(NSInteger)userId;

- (void)addActivity:(Activity *)activity andUserId:(NSInteger)userId;
- (void)addMovie:(Movie *)movie andUserId:(NSInteger)userId;

//查找所有收藏
- (NSArray *)selectActivity:(NSInteger)userId;
- (NSArray *)selectMovie:(NSInteger)userId;

//删除收藏的数据
- (BOOL)deleteActivity:(NSString *)title;
- (BOOL)deleteMovie:(NSString *)title;

@end
