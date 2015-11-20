//
//  MovieDetailViewController.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "DataDownloadTool.h"
#import "LoginViewController.h"
#import "LoginStatus.h"
#import "DataBaseTool.h"

@interface MovieDetailViewController ()

@property (assign,nonatomic) BOOL flag;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.title = self.m.movieName;
    self.imageView.image = self.m.imagePhoto;    
    
    [self loadData];
}

- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php?movieId=%@",self.m.movieId];
    [DataDownloadTool dataDowloadToolWithURL:url andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *reDic = dic[@"result"];
        [self.m setValuesForKeysWithDictionary:reDic];
        self.labelRating.text = self.m.rating;
        self.labelRatingCount.text = self.m.rating_count;
        self.labelReleaseData.text = self.m.release_date;
        self.labelRuntime.text = self.m.runtime;
        self.labelGenres.text = self.m.genres;
        self.labelCountry.text = self.m.country;
        self.labelActors.text = self.m.actors;
        self.labelPlotSimple.text = self.m.plot_simple;
    }];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)leftAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    if ([LoginStatus shareLogin].islogin) {
        NSString *title = self.m.movieName;
        NSInteger userId = [LoginStatus shareLogin].userId;
        
        NSArray *arr = [[DataBaseTool shareDataBaseTool] selectMovie:userId];
        for (NSString *str in arr) {
            if ([title isEqualToString:str]) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经收藏过了" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [ac addAction:aa];
                [self presentViewController:ac animated:YES completion:nil];
                return;
            }
        }
        
        [[DataBaseTool shareDataBaseTool] addMovieData:title andUserId:userId];
        [self archiver];
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:aa];
        [self presentViewController:ac animated:YES completion:nil];
    } else {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *lnvc = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self presentViewController:lnvc animated:YES completion:nil];
    }
}

//归档
- (void)archiver {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.m forKey:@"movie"];
    [archiver finishEncoding];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSInteger userId = [LoginStatus shareLogin].userId;
    NSString *fileName = [NSString stringWithFormat:@"/%ld_%@",userId,self.m.movieName];
    NSString *dataPath = [docPath stringByAppendingString:fileName];
    [data writeToFile:dataPath atomically:YES];
}


@end
