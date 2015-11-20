//
//  MovieDetailViewController.h
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property (strong,nonatomic) Movie *m;

@property (strong,nonatomic) NSMutableArray *data;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *labelRating;

@property (weak, nonatomic) IBOutlet UILabel *labelRatingCount;

@property (weak, nonatomic) IBOutlet UILabel *labelReleaseData;

@property (weak, nonatomic) IBOutlet UILabel *labelRuntime;

@property (weak, nonatomic) IBOutlet UILabel *labelGenres;

@property (weak, nonatomic) IBOutlet UILabel *labelCountry;

@property (weak, nonatomic) IBOutlet UILabel *labelActors;

@property (weak, nonatomic) IBOutlet UILabel *labelPlotSimple;

@end
