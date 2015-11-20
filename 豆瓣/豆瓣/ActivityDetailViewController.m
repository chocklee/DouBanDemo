//
//  ActivityDetailViewController.m
//  豆瓣
//
//  Created by chock on 15/10/31.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "LoginViewController.h"
#import "LoginStatus.h"
#import "DataBaseTool.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    left.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_nav_share.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.title = self.active.title;
    
    //label自适应高度
    NSString *str = self.active.content;
    CGSize size = CGSizeMake(self.labelContent.frame.size.width, 2000);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect labelFrame = self.labelContent.frame;
    labelFrame.size.height = rect.size.height;
    self.labelContent.frame = labelFrame;
    
    [self setValue];
}

- (void)setValue{
    self.labelTitle.text = self.active.title;
    self.labelTime.text = self.active.timeInterval;
    self.labelName.text = self.active.name;
    self.labelCategory.text = self.active.category_name;
    self.labelAddress.text = self.active.address;
    self.labelContent.text = self.active.content;
    self.imageView.image = self.active.imagePhoto;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
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
        NSString *title = self.active.title;
        NSInteger userId = [LoginStatus shareLogin].userId;
        
        NSArray *arr = [[DataBaseTool shareDataBaseTool] selectActivity:userId];
        
        for (Activity *a in arr) {
            if ([title isEqualToString:a.title]) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经收藏过了" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [ac addAction:aa];
                [self presentViewController:ac animated:YES completion:nil];
                return;
            }
        }
        
//        for (NSString *str in arr) {
//            if ([title isEqualToString:str]) {
//                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经收藏过了" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *aa = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//                [ac addAction:aa];
//                [self presentViewController:ac animated:YES completion:nil];
//                return;
//            }
//        }
//        [[DataBaseTool shareDataBaseTool] addActivityData:title andUserId:userId];
        [[DataBaseTool shareDataBaseTool] addActivity:self.active andUserId:userId];
        //归档
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
    [archiver encodeObject:self.active forKey:@"activity"];
    [archiver finishEncoding];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSInteger userId = [LoginStatus shareLogin].userId;
    NSString *fileName = [NSString stringWithFormat:@"/%ld_%@",userId,self.active.title];
    NSString *dataPath = [docPath stringByAppendingString:fileName];
    [data writeToFile:dataPath atomically:YES];
}

@end
