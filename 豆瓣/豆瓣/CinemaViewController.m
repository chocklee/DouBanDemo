//
//  CinemaViewController.m
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaTableViewCell.h"
#import "DataDownloadTool.h"
#import "Cinema.h"

@interface CinemaViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation CinemaViewController

- (void)loadView {
    [super loadView];
    self.cv = [[CinemaView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.cv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"影院";
    //设置navigationBar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.cv.tv.dataSource = self;
    self.cv.tv.delegate = self;
    [self.cv.tv registerNib:[UINib nibWithNibName:@"CinemaTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_id"];
    
    [self loadData];
}

- (void)loadData {
    [DataDownloadTool dataDowloadToolWithURL:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php" andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *reDic = dic[@"result"];
        NSArray *arr = reDic[@"data"];
        self.data = [NSMutableArray array];
        for (NSDictionary *dics in arr) {
            Cinema *c = [[Cinema alloc] init];
            [c setValuesForKeysWithDictionary:dics];
            [self.data addObject:c];
        }
        [self.cv.tv reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[CinemaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    Cinema *c = self.data[indexPath.row];
    cell.cinemaName.text = c.cinemaName;
    cell.address.text = c.address;
    cell.telephone.text = c.telephone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
