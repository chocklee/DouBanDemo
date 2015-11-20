//
//  MovieViewController.h
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieView.h"

@interface MovieViewController : UIViewController

@property (strong,nonatomic) MovieView *mv;

@property (strong,nonatomic) NSMutableArray *data;



@end
