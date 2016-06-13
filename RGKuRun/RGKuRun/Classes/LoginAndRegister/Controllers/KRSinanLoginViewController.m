//
//  KRSinanLoginViewController.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/8.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "KRSinanLoginViewController.h"
#import "AFNetworking.h"
#define  APPKEY       @"2075708624"
#define  REDIRECT_URI @"http://www.tedu.cn"
#define  APPSECRET    @"36a3d3dec55af644cd94a316fdd8bfd8"

@interface KRSinanLoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KRSinanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.delegate = self;
    NSString  *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@"                         ,APPKEY,REDIRECT_URI];
    NSURL  *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (IBAction)backTo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil   ];
}

#pragma mark- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlParth = request.URL.absoluteString;
    NSLog(@"%@",urlParth);
    NSRange range = [urlParth rangeOfString:[NSString stringWithFormat:@"%@%@",REDIRECT_URI,@"/?code="]];
    NSString *code;
    if (range.length>0) {
        code = [urlParth substringFromIndex:range.length];
        [self accessTokenWithCode:code];
    }
    

    return YES;
}


- (void) accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
}
@end
