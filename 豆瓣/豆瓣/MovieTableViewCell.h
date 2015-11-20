//
//  MovieTableViewCell.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *movieName;

@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;

@end
