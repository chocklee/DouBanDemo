//
//  RegisterViewController.h
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendBlock)(NSString *userName,NSString *password);

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgain;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (copy,nonatomic) SendBlock block;

@end
