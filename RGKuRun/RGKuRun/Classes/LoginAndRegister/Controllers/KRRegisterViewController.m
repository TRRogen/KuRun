//
//  KRRegisterViewController.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/7.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "KRRegisterViewController.h"
#import "AFNetworking.h"
#import "KRUserInfo.h"
#import "KRXMPPTool.h"
#import "NSString+md5Encryption.h"
#import "MBProgressHUD+KR.h"

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

- (void)dealloc{
    
    
    NSLog(@"%@",self);
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtnclick:(id)sender {
    if (self.userNameTextField.text == 0 || self.passwordTextField.text == 0 ) {
        [MBProgressHUD showError:@"用户名或密码不能为空"];
    }
    [KRUserInfo sharedKRUserInfo].userRegisterName = self.userNameTextField.text;
    [KRUserInfo sharedKRUserInfo].userRegisterPassword = self.passwordTextField.text;
    [KRUserInfo sharedKRUserInfo].login = NO;
    
    [[KRXMPPTool sharedKRXMPPTool] beginRegister];
    
    [KRXMPPTool sharedKRXMPPTool].delegate = self;
    [MBProgressHUD showMessage:@"正在注册"];
    [self registerForWebServer];

}

- (IBAction)backBtnItemClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//web 的注册方法
- (void)registerForWebServer {
    NSString *url = @"http://172.16.9.14:8080/allRunServer/register.jsp";
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"username"] = [KRUserInfo sharedKRUserInfo].userRegisterName ;
    paramters[@"md5password"] = [[KRUserInfo sharedKRUserInfo].userRegisterPassword md5StrXor];
    
    //用AFNetworking上传文件操作
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //在此处写文件上传参数
        UIImage *image = [UIImage imageNamed:@"icon"];
        NSData *data = UIImagePNGRepresentation(image);
        //param1. 上传文件的二进制数据
        //param2. 服务器要求的文件参数名字
        //param3. 服务器上存储的文件名字
        //param4. 说明数据的类型
        [formData appendPartWithFileData:data name:@"pic" fileName:@"headImage.png" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //代表响应成功,不代表注册成功
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark- KRXMPPToolDelegate
- (void)KRXMPPTool:(KRXMPPTool *)xmppTool registerState:(KRXMPPToolRegisterState)state{
    switch (state) {
        case REGISTERSUCESS:{
            NSLog(@"register controller loginsucess");
            self.registerCompleteHandle(self.userNameTextField.text,self.passwordTextField.text);
            
            [self backBtnItemClick:nil];
            break;
        }
        case REGISTERFAIL:
            NSLog(@"register controller loginfail");
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败"];
            break;
            
        case REGISTERNETERROR:
            NSLog(@"register controller logineterror");
            [MBProgressHUD showError:@"网络失败" toView:self.view];
            break;
    }
}



@end
