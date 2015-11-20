//
//  Activity.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "Activity.h"
#import "DataDownloadTool.h"

@implementation Activity

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

- (void)loadImage {
    self.isLoading = YES;
    [DataDownloadTool dataDowloadToolWithURL:self.image andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        self.imagePhoto = [UIImage imageWithData:data];
        self.isLoading = NO;
    }];
}

//归档反归档第二步:实现协议里的两个方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"a_title"];
    [aCoder encodeObject:self.address forKey:@"a_address"];
    [aCoder encodeObject:self.category_name forKey:@"a_category_name"];
    [aCoder encodeObject:self.name forKey:@"a_name"];
    [aCoder encodeObject:self.content forKey:@"a_content"];
    [aCoder encodeObject:self.timeInterval forKey:@"a_timeInterval"];
    [aCoder encodeObject:self.imagePhoto forKey:@"a_imagePhoto"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"a_title"];
        self.address = [aDecoder decodeObjectForKey:@"a_address"];
        self.category_name = [aDecoder decodeObjectForKey:@"a_category_name"];
        self.name = [aDecoder decodeObjectForKey:@"a_name"];
        self.content = [aDecoder decodeObjectForKey:@"a_content"];
        self.timeInterval = [aDecoder decodeObjectForKey:@"a_timeInterval"];
        self.imagePhoto = [aDecoder decodeObjectForKey:@"a_imagePhoto"];
    }
    return self;
}

@end
