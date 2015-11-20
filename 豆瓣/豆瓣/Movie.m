//
//  Movie.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "Movie.h"
#import "DataDownloadTool.h"

@implementation Movie

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)loadImage {
    self.isLoading = YES;
    [DataDownloadTool dataDowloadToolWithURL:self.pic_url andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        self.imagePhoto = [UIImage imageWithData:data];
        self.isLoading = NO;
    }];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.movieName forKey:@"movieName"];
    [aCoder encodeObject:self.imagePhoto forKey:@"imagePhoto"];
    [aCoder encodeObject:self.rating forKey:@"rating"];
    [aCoder encodeObject:self.rating_count forKey:@"rating_count"];
    [aCoder encodeObject:self.release_date forKey:@"release_date"];
    [aCoder encodeObject:self.runtime forKey:@"runtime"];
    [aCoder encodeObject:self.genres forKey:@"genres"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.actors forKey:@"actors"];
    [aCoder encodeObject:self.plot_simple forKey:@"plot_simple"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.movieName = [aDecoder decodeObjectForKey:@"movieName"];
        self.imagePhoto = [aDecoder decodeObjectForKey:@"imagePhoto"];
        self.rating = [aDecoder decodeObjectForKey:@"rating"];
        self.rating_count = [aDecoder decodeObjectForKey:@"rating_count"];
        self.release_date = [aDecoder decodeObjectForKey:@"release_date"];
        self.runtime = [aDecoder decodeObjectForKey:@"runtime"];
        self.genres = [aDecoder decodeObjectForKey:@"genres"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.actors = [aDecoder decodeObjectForKey:@"actors"];
        self.plot_simple = [aDecoder decodeObjectForKey:@"plot_simple"];
    }
    return self;
}

@end
