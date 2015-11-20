//
//  DataDownloadTool.h
//  UILesson17_HW
//
//  Created by chock on 15/10/29.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OptionBlock)(NSData *data);

@interface DataDownloadTool : NSObject

//创建类方法
+ (void)dataDowloadToolWithURL:(NSString *)urlString andMethod:(NSString *)method andBody:(NSString *)body andBlock:(OptionBlock)block;

@end
