//
//  CinemaViewController.h
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaView.h"

@interface CinemaViewController : UIViewController

@property (strong,nonatomic) CinemaView *cv;

@property (strong,nonatomic) NSMutableArray *data;

@end
