//
//  DataBaseTool.m
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "DataBaseTool.h"

static DataBaseTool *handler = nil;
static sqlite3 *db;

@implementation DataBaseTool

+ (DataBaseTool *)shareDataBaseTool {
    if (handler == nil) {
        handler = [[DataBaseTool alloc] init];
    }
    return handler;
}

//打开数据库
- (void)openDataBase {
    if (db != nil) {
        NSLog(@"数据库已打开");
        return;
    }
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    NSString *dataPath = [docPath stringByAppendingString:@"/database.sqlite"];
    int res = sqlite3_open(dataPath.UTF8String, &db);
    if (res == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"打开数据库失败,失败信息:%d",res);
    }
}

//关闭数据库
- (void)closeDataBase {
    int res = sqlite3_close(db);
    if (res == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭数据库成功");
    } else {
        NSLog(@"关闭数据库失败,失败信息:%d",res);
    }
}

//创建数据库表
- (void)createTable:(NSString *)sql {
    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (res == SQLITE_OK) {
        NSLog(@"创建数据库表成功");
    } else {
        NSLog(@"创建数据库表失败,失败信息:%d",res);
    }
}

//添加数据
- (void)addData:(User *)user {
    NSString *sql = [NSString stringWithFormat:@"insert into user (user_name,user_password,user_email,user_phone) values ('%@','%@','%@','%@')",user.userName,user.userPassword,user.userEmail,user.userPhone];
    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (res == SQLITE_OK) {
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败,失败信息:%d",res);
    }
}

//- (void)addActivityData:(NSString *)title andUserId:(NSInteger)userId; {
//    NSString *sql = [NSString stringWithFormat:@"insert into activity (a_content,user_id) values ('%@','%ld')",title,userId];
//    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
//    if (res == SQLITE_OK) {
//        NSLog(@"添加数据成功");
//    } else {
//        NSLog(@"添加数据失败,失败信息:%d",res);
//    }
//}
//
//- (void)addMovieData:(NSString *)title andUserId:(NSInteger)userId {
//    NSString *sql = [NSString stringWithFormat:@"insert into movie (m_content,user_id) values ('%@','%ld')",title,userId];
//    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
//    if (res == SQLITE_OK) {
//        NSLog(@"添加数据成功");
//    } else {
//        NSLog(@"添加数据失败,失败信息:%d",res);
//    }
//}

- (void)addActivity:(Activity *)activity andUserId:(NSInteger)userId {
    
    NSData *imageData = UIImagePNGRepresentation(activity.imagePhoto);
    
    NSString *sql = [NSString stringWithFormat:@"insert into activity (a_title,a_time,a_name,a_category,a_address,a_content,a_imagePhoto,user_id) values ('%@','%@','%@','%@','%@','%@','%@','%ld')",activity.title,activity.timeInterval,activity.name,activity.category_name,activity.address,activity.content,imageData,userId];
    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (res == SQLITE_OK) {
        NSLog(@"添加数据成功");
    } else {
        NSLog(@"添加数据失败,失败信息:%d",res);
    }

}
- (void)addMovie:(Movie *)movie andUserId:(NSInteger)userId {
    
}

//查询所有数据
- (NSArray *)selectAllData {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *sql = @"select * from user";
    sqlite3_stmt *stmt = nil;
    int res = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (res == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSInteger userId = sqlite3_column_int(stmt, 0);
            NSString *userName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *userPassword = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *userEmail = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            NSString *userPhone = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            User *u = [User userWithName:userName andPassword:userPassword andEmail:userEmail andPhone:userPhone];
            u.userId = userId;
            [arr addObject:u];
        }
        sqlite3_finalize(stmt);
    }
    return arr;
}

//根据用户名查询数据
- (User *)selectData:(NSString *)username; {
    User *user = [[User alloc] init];
    NSArray *arr = [self selectAllData];
    for (User *u in arr) {
        if ([u.userName isEqualToString:username]) {
            user = u;
        }
    }
    return user;
}

//- (NSArray *)selectActivity:(NSInteger)userId {
//    NSMutableArray *arr = [NSMutableArray array];
//    NSString *sql = [NSString stringWithFormat:@"select a_content from activity where user_id = '%ld'",userId];
//    sqlite3_stmt *stmt = nil;
//    int res = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
//    if (res == SQLITE_OK) {
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//            [arr addObject:title];
//        }
//        sqlite3_finalize(stmt);
//    }
//    return arr;
//}
//
//- (NSArray *)selectMovie:(NSInteger)userId {
//    NSMutableArray *arr = [NSMutableArray array];
//    NSString *sql = [NSString stringWithFormat:@"select * from movie where user_id = '%ld'",userId];
//    sqlite3_stmt *stmt = nil;
//    int res = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
//    if (res == SQLITE_OK) {
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
//            [arr addObject:title];
//        }
//        sqlite3_finalize(stmt);
//    }
//    return arr;
//}

- (NSArray *)selectActivity:(NSInteger)userId {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"select * from activity where user_id = '%ld'",userId];
    sqlite3_stmt *stmt = nil;
    int res = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    if (res == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Activity *a = [[Activity alloc] init];
            a.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            a.timeInterval = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            a.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            a.category_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            a.address = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            a.content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
            int length = sqlite3_column_bytes(stmt, 6);
            a.imagePhoto = [UIImage imageWithData:[NSData dataWithBytes:sqlite3_column_blob(stmt, 7) length:length]];
            [arr addObject:a];
        }
        sqlite3_finalize(stmt);
    }
    return arr;
}





- (BOOL)deleteActivity:(NSString *)title {
    BOOL flag = NO;
    NSString *sql = [NSString stringWithFormat:@"delete from activity where a_content = '%@'",title];
    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (res == SQLITE_OK) {
        flag = YES;
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败,失败信息:%d",res);
    }
    return flag;
}
- (BOOL)deleteMovie:(NSString *)title {
    BOOL flag = NO;
    NSString *sql = [NSString stringWithFormat:@"delete from movie where m_content = '%@'",title];
    int res = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    if (res == SQLITE_OK) {
        flag = YES;
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败,失败信息:%d",res);
    }
    return flag;
}

@end
