//
//  ActivityViewController.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "DataDownloadTool.h"
#import "Activity.h"
#import "ActivityDetailViewController.h"

@interface ActivityViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ActivityViewController

- (void)loadView {
    [super loadView];
    self.av = [[ActivityView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.av;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"活动";
    //设置navigationBar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    //指定tableView的代理
    self.av.tv.dataSource = self;
    self.av.tv.delegate = self;
    //注册xib
    [self.av.tv registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell_id"];
    //加载数据
    [self loadData];
    
}

- (void)loadData {
    [DataDownloadTool dataDowloadToolWithURL:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php" andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        //解析下载下来的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = dic[@"events"];
        self.data = [NSMutableArray array];
        for (NSDictionary *dics in arr) {
            Activity *a = [[Activity alloc] init];
            [a setValuesForKeysWithDictionary:dics];
            NSDictionary *dicss = dics[@"owner"];
            a.name = dicss[@"name"];
            [self.data addObject:a];
        }
        //刷新tableView
        [self.av.tv reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    Activity *a = self.data[indexPath.row];
    cell.title.text = a.title;
    NSString *beingTime = [[a.begin_time substringWithRange:NSMakeRange(5, 11)] stringByAppendingString:@" -- "];
    NSString *endTime = [a.end_time substringWithRange:NSMakeRange(5, 11)];
    a.timeInterval = [beingTime stringByAppendingString:endTime];
    cell.timeInterval.text = [beingTime stringByAppendingString:endTime];
    cell.address.text = a.address;
    cell.categoryName.text = a.category_name;
    cell.wisherCount.text = [NSString stringWithFormat:@"%ld",a.wisher_count];
    cell.participantCount.text = [NSString stringWithFormat:@"%ld",a.participant_count];
    
    if ((nil == a.imagePhoto) && (a.isLoading == NO)) {
        //添加观察者
        [a addObserver:self forKeyPath:@"imagePhoto" options:NSKeyValueObservingOptionNew context:(__bridge void *)(indexPath)];
        [a loadImage];
    } else {
        if (a.imagePhoto ==nil) {
            NSLog(@"下载不了图片");
        } else {
            cell.imagePhoto.image = a.imagePhoto;
        }
    }
    
    //主线程串行执行
//    dispatch_queue_t main = dispatch_get_main_queue();
//    dispatch_async(main, ^{
//        [DataDownloadTool dataDowloadToolWithURL:a.image andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
//            a.imagePhoto = [UIImage imageWithData:data];
//            cell.imagePhoto.image = a.imagePhoto;
//        }];
//        NSLog(@"%@,%@",a.title,[NSThread currentThread]);
//    });
    
    //并行
//    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(global, ^{
//        [DataDownloadTool dataDowloadToolWithURL:a.image andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
//            a.imagePhoto = [UIImage imageWithData:data];
//            cell.imagePhoto.image = a.imagePhoto;
//        }];
//        NSLog(@"%@,%@",a.title,[NSThread currentThread]);
//    });
    
    return cell;
}

//实现观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIImage *image = change[NSKeyValueChangeNewKey];
    if (image == nil) {
        return;
    }
    NSIndexPath *indexPath = (__bridge NSIndexPath *)(context);
    NSArray *indexArr = [self.av.tv indexPathsForVisibleRows];
    if ([indexArr containsObject:indexPath]) {
        ActivityTableViewCell *cell = (ActivityTableViewCell *)[self.av.tv cellForRowAtIndexPath:indexPath];
        cell.imagePhoto.image = image;
        [self.av.tv reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //移除观察者
        [object removeObserver:self forKeyPath:@"imagePhoto"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailViewController *advc = [[ActivityDetailViewController alloc] init];
    [self.navigationController pushViewController:advc animated:YES];
    advc.active = self.data[indexPath.row];
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
