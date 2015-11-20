//
//  ActivityViewController.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityView.h"

@interface ActivityViewController : UIViewController

@property (strong,nonatomic) ActivityView *av;

@property (strong,nonatomic) NSMutableArray *data;

@end
