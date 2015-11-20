//
//  LoginViewController.m
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "DataBaseTool.h"
#import "LoginStatus.h"

@interface LoginViewController () <UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户登陆";
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem = left;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 5;
    [self.registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.name.delegate = self;
    self.password.delegate = self;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)leftAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginAction:(UIButton *)button {
    User *u = [[DataBaseTool shareDataBaseTool] selectData:self.name.text];
    if ([self.password.text isEqualToString:u.userPassword]) {
        
        [LoginStatus shareLogin].islogin = YES;
        [LoginStatus shareLogin].userId = u.userId;
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名/密码不正确" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)registerAction:(UIButton *)button {
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    rvc.block = ^(NSString *userName,NSString *password) {
        self.name.text = userName;
        self.password.text = password;
        [self loginAction:button];
    };
    [self.navigationController pushViewController:rvc animated:YES];
}

//实现alert的代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
