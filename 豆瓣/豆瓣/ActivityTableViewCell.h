//
//  ActivityTableViewCell.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *timeInterval;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *categoryName;

@property (weak, nonatomic) IBOutlet UILabel *wisherCount;

@property (weak, nonatomic) IBOutlet UILabel *participantCount;

@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;


@end
