//
//  KRSinanLoginViewController.m
//  RGKuRun
//
//  Created by TRRogen on 16/6/8.
//  Copyright © 2016年 TRRogen. All rights reserved.
//

#import "KRSinanLoginViewController.h"

#define  APPKEY       @"2075708624"
#define  REDIRECT_URI @"http://www.tedu.cn"
#define  APPSECRET    @"36a3d3dec55af644cd94a316fdd8bfd8"

@interface KRSinanLoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation KRSinanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    NSString  *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@"                         ,APPKEY,REDIRECT_URI];
    NSURL  *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];


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

@end
