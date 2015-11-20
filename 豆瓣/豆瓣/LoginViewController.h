//
//  LoginViewController.h
//  豆瓣
//
//  Created by chock on 15/10/30.
//  Copyright (c) 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"



@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
