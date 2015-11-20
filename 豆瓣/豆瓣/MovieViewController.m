//
//  MovieViewController.m
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "DataDownloadTool.h"
#import "Movie.h"
#import "MovieDetailViewController.h"
#import "MovieCollectionViewController.h"

@interface MovieViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation MovieViewController

- (void)loadView {
    [super loadView];
    self.mv = [[MovieView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"电影";
    //设置navigationBar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_collection.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    self.mv.tv.dataSource = self;
    self.mv.tv.delegate = self;
    [self.mv.tv registerNib:[UINib nibWithNibName:@"MovieTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_id"];
    
    [self loadData];
    
    }

- (void)loadData {
    [DataDownloadTool dataDowloadToolWithURL:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php" andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"result"];
        self.data = [NSMutableArray array];
        for (NSDictionary *dics in arr) {
            Movie *m = [[Movie alloc] init];
            [m setValuesForKeysWithDictionary:dics];
            [self.data addObject:m];
        }
        [self.mv.tv reloadData];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    
    Movie *m = self.data[indexPath.row];
    cell.movieName.text = m.movieName;
//    if ((m.imagePhoto == nil) && (m.isLoading == NO)) {
//        [m loadImage];
//        [m addObserver:self forKeyPath:@"imagePhoto" options:NSKeyValueObservingOptionNew context:(__bridge void *)(indexPath)];
//    } else {
//        if (m.imagePhoto == nil) {
//            NSLog(@"未下载到图片");
//        } else {
//            cell.imagePhoto.image = m.imagePhoto;
//        }
//    }
    dispatch_queue_t main = dispatch_get_main_queue();
    dispatch_async(main, ^{
        [DataDownloadTool dataDowloadToolWithURL:m.pic_url andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
            m.imagePhoto = [UIImage imageWithData:data];
            cell.imagePhoto.image = m.imagePhoto;
        }];
    });
    return cell;
}

//实现观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIImage *image = change[NSKeyValueChangeNewKey];
    if (image == nil) {
        return;
    }
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    NSArray *indexArr = [self.mv.tv indexPathsForVisibleRows];
    if ([indexArr containsObject:indexPath]) {
        MovieTableViewCell *cell = (MovieTableViewCell *)[self.mv.tv cellForRowAtIndexPath:indexPath];
        cell.imagePhoto.image = image;
        [self.mv.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //移除观察者
        [object removeObserver:self forKeyPath:@"imagePhoto"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.m = self.data[indexPath.row];
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (void)rightAction:(UIBarButtonItem *)sender {
    MovieCollectionViewController *mcvc = [[MovieCollectionViewController alloc] init];
    [self.navigationController pushViewController:mcvc animated:NO];
}

@end
