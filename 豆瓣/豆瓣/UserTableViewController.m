//
//  UserTableViewController.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "UserTableViewController.h"
#import "LoginViewController.h"
#import "DataBaseTool.h"
#import "LoginStatus.h"
#import "CollectTableViewController.h"

@interface UserTableViewController () <UIAlertViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) NSArray *cellsTitle;

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"我的";
    //设置navigationBar的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav.png"] forBarMetrics:UIBarMetricsDefault];
    
    if ([LoginStatus shareLogin].islogin) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
        self.navigationItem.rightBarButtonItem = right;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    } else {
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
        self.navigationItem.rightBarButtonItem = right;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    }

    self.cellsTitle = @[@"我的活动",@"我的电影",@"清除缓存"];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    if ([LoginStatus shareLogin].islogin) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
        [alert show];
    } else {
        self.navigationItem.rightBarButtonItem.title = @"注销";
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *lnvc = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self presentViewController:lnvc animated:YES completion:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [LoginStatus shareLogin].islogin = NO;
        self.navigationItem.rightBarButtonItem.title = @"登录";
    } else {
        NSLog(@"取消注销");
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
    return self.cellsTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
    }
    cell.textLabel.text = self.cellsTitle[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![LoginStatus shareLogin].islogin) {
        [self rightAction:nil];
    } else {
        if (indexPath.row != 2) {
            CollectTableViewController *ctvc = [[CollectTableViewController alloc] init];
            ctvc.indexPath = indexPath;
            [self.navigationController pushViewController:ctvc animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认注销" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            [alert show];
        }
    }
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
