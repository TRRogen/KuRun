//
//  KRRegisterViewController.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "KRRegisterViewController.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"

@interface KRRegisterViewController ()<KRXMPPToolDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation KRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = self.userNameTextField.bounds.size.height;
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    leftImageView.contentMode = UIViewContentModeCenter;
    leftImageView.image = [UIImage imageNamed:@"icon"];
    self.userNameTextField.leftView = leftImageView;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    leftImageView.contentMode = UIViewContentModeCenter;
    leftImageView.image = [UIImage imageNamed:@"lock"];
    self.passwordTextField.leftView = leftImageView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
}



- (void)setXmppStream{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtnclick:(id)sender {
    
    [KRUserInfo sharedKRUserInfo].userRegisterName = self.userNameTextField.text;
    [KRUserInfo sharedKRUserInfo].userRegisterPassword = self.passwordTextField.text;
    [KRUserInfo sharedKRUserInfo].login = NO;
    
    [[KRXMPPTool sharedKRXMPPTool] beginRegister];
    [KRXMPPTool sharedKRXMPPTool].delegate = self;
}

- (IBAction)backBtnItemClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- KRXMPPToolDelegate
- (void)KRXMPPTool:(KRXMPPTool *)xmppTool registerState:(KRXMPPToolRegisterState)state{
    switch (state) {
        case REGISTERSUCESS:{
            NSLog(@"register controller loginsucess");
            [self backBtnItemClick:nil];
            break;
        }
        case REGISTERFAIL:
            NSLog(@"register controller loginfail");
            
            break;
            
        case REGISTERNETERROR:
            NSLog(@"register controller logineterror");
            
            break;
    }
}



@end
