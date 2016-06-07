//
//  KRLogInViewController.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "KRLogInViewController.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"

@interface KRLogInViewController ()<KRXMPPToolDelegate>

//登入的名字
@property (weak, nonatomic) IBOutlet UITextField *accoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;



@end

@implementation KRLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = self.accoutTextField.frame.size.height;
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    leftImage.contentMode = UIViewContentModeCenter;
    leftImage.image = [UIImage imageNamed:@"icon"];
    self.accoutTextField.leftViewMode = UITextFieldViewModeAlways;
    self.accoutTextField.leftView = leftImage;
    
    leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    leftImage.contentMode = UIViewContentModeCenter;
    leftImage.image = [UIImage imageNamed:@"lock"];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = leftImage;
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClick:(id)sender {
    [KRUserInfo sharedKRUserInfo].userName = self.accoutTextField.text;
    [KRUserInfo sharedKRUserInfo].userPasswrod = self.passwordTextField.text;
    //调用XMPPFramework的API完成登录
    [KRUserInfo sharedKRUserInfo].login = YES;
    [KRXMPPTool sharedKRXMPPTool].delegate = self;
    [[KRXMPPTool sharedKRXMPPTool] userLogin];
    
}

#pragma mark- KRXMPPToolDelegate
- (void)KRXMPPTool:(KRXMPPTool *)xmppTool loginState:(KRXMPPToolLogInState)state{
    switch (state) {
        case LOGINSUCESS:{
            NSLog(@"login controller loginsucess");
            //切换界面
            UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController =
            mainStoryBoard.instantiateInitialViewController;
            
            break;
        }
        case LOGINFAIL:
            NSLog(@"login controller loginfail");

            break;
            
        case LOGINNETERROR:
            NSLog(@"login controller logineterror");

            break;
    }
}

@end
