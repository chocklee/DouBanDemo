//
//  DataDownloadTool.m
//  UILesson17_HW
//
//  Created by chock on 15/10/29.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "DataDownloadTool.h"

@implementation DataDownloadTool

+ (void)dataDowloadToolWithURL:(NSString *)urlString andMethod:(NSString *)method andBody:(NSString *)body andBlock:(OptionBlock)block {
    //生成URL对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建request请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //如果method方法是POST,则设置request的method和body属性
    //因为GET属性是默认的,所以不需要判断
    if ([[method uppercaseString] isEqualToString:@"POST"]) {
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //解析数据
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        block(data);
    }];
}

@end
