//
//  MovieCollectionViewController.m
//  
//
//  Created by chock on 15/11/5.
//
//

#import "MovieCollectionViewController.h"
#import "MovieCollectionViewCell.h"
#import "DataDownloadTool.h"
#import "Movie.h"
#import "MovieDetailViewController.h"

@interface MovieCollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UICollectionView *collection;

@end

@implementation MovieCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"电影";
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_list.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 180);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    self.collection = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    
    //注册
    [self.collection registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collection];
    
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
        [self.collection reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    Movie *m = self.data[indexPath.row];
    cell.label.text = m.movieName;
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        [DataDownloadTool dataDowloadToolWithURL:m.pic_url andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
            m.imagePhoto = [UIImage imageWithData:data];
            cell.imageView.image = m.imagePhoto;
        }];
    });
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.m = self.data[indexPath.row];
    [self.navigationController pushViewController:mdvc animated:YES];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:NO];
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

@end
