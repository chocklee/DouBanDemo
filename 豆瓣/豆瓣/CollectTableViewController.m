//
//  CollectTableViewController.m
//  豆瓣
//
//  Created by chock on 15/11/3.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "CollectTableViewController.h"
#import "DataBaseTool.h"
#import "LoginStatus.h"
#import "DataBaseTool.h"
#import "ActivityDetailViewController.h"
#import "MovieDetailViewController.h"
#import "Activity.h"
#import "Movie.h"

@interface CollectTableViewController ()

@property (strong,nonatomic) NSMutableArray *arr;

@end

@implementation CollectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSInteger userId = [LoginStatus shareLogin].userId;
    if (self.indexPath.row == 0) {
        self.arr = [[DataBaseTool shareDataBaseTool] selectActivity:userId].mutableCopy;
        
    } else if (self.indexPath.row == 1){
        self.arr = [[DataBaseTool shareDataBaseTool] selectMovie:userId].mutableCopy;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    if (self.indexPath.row == 0) {
        Activity *a = [[Activity alloc] init];
        a = self.arr[indexPath.row];
        cell.textLabel.text = a.title;
    } 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.indexPath.row == 0) {
        ActivityDetailViewController *advc = [[ActivityDetailViewController alloc] init];
//        advc.active = [self unArchiverForActivity:indexPath];
        advc.active = self.arr[indexPath.row];
        
        [self.navigationController pushViewController:advc animated:YES];
    } else if (self.indexPath.row == 1){
        MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
        mdvc.m = [self unArchiverForMovie:indexPath];
        [self.navigationController pushViewController:mdvc animated:YES];
    }
}

//反归档
- (Activity *)unArchiverForActivity:(NSIndexPath *)indexPath {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSInteger userId = [LoginStatus shareLogin].userId;
    NSString *title = [self.arr[indexPath.row] title];
    NSString *fileName = [NSString stringWithFormat:@"/%ld_%@",userId,title];
    NSString *dataPath = [docPath stringByAppendingString:fileName];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Activity *a = [unArchiver decodeObjectForKey:@"activity"];
    [unArchiver finishDecoding];
    return a;
}

//反归档
- (Movie *)unArchiverForMovie:(NSIndexPath *)indexPath {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSInteger userId = [LoginStatus shareLogin].userId;
    NSString *title = self.arr[indexPath.row];
    NSString *fileName = [NSString stringWithFormat:@"/%ld_%@",userId,title];
    NSString *dataPath = [docPath stringByAppendingString:fileName];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    Movie *m = [unArchiver decodeObjectForKey:@"movie"];
    [unArchiver finishDecoding];
    return m;
}

//删除cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.indexPath.row == 0) {
            //第一步删除数据库中的数据
            [[DataBaseTool shareDataBaseTool] deleteActivity:self.arr[indexPath.row]];
            [self.arr removeObjectAtIndex:indexPath.row];
        } else {
            [[DataBaseTool shareDataBaseTool] deleteMovie:self.arr[indexPath.row]];
            [self.arr removeObjectAtIndex:indexPath.row];
        }
        //界面更新
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
