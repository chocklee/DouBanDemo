//
//  CinemaTableViewCell.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CinemaTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cinemaName;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *telephone;

@end
