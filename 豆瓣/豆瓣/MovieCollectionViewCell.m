//
//  MovieCollectionViewCell.m
//  豆瓣
//
//  Created by chock on 15/11/4.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "MovieCollectionViewCell.h"

@implementation MovieCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40)];
    [self.contentView addSubview:self.imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.frame.size.height, self.frame.size.width, 40)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}

@end
