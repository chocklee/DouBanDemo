//
//  RegisterViewController.m
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import "RegisterViewController.h"
#import "DataBaseTool.h"

@interface RegisterViewController () <UITextFieldDelegate>



@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.userName.delegate = self;
    self.password.delegate = self;
    self.passwordAgain.delegate = self;
    self.email.delegate = self;
    self.phone.delegate = self;
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


- (void)rightAction:(UIBarButtonItem *)sender {
    //加判断
    if (![self.userName.text isEqualToString:@""] && ![self.password.text isEqualToString:@""] && ![self.passwordAgain.text isEqualToString:@""] && [self.password.text isEqualToString:self.passwordAgain.text]) {
        User *u = [User userWithName:self.userName.text andPassword:self.password.text andEmail:self.email.text andPhone:self.phone.text];
        [[DataBaseTool shareDataBaseTool] addData:u];
        self.block(self.userName.text,self.password.text);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名不能为空/两次密码输入不匹配" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
