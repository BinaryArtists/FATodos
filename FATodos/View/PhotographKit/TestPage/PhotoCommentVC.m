//
//  PhotoCommentVC.m
//  FATodos
//
//  Created by qingqing on 16/1/22.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PhotoCommentVC.h"

@interface PhotoCommentVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PhotoCommentVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title  = L(@"test.zhenguo.title");
    
    {
        /**
         App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.
         
         在info.plist 加入key
         
         <key>NSAppTransportSecurity</key>
         <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
         </dict>
         
         http://blog.csdn.net/chenyong05314/article/details/46721205
         */
    }
    
    /**
     * html parser
     
     https://github.com/topfunky/hpple/tree/master/Example
     */
    
    /**
     相约佳人
     
     {
        http://oa.shhyy.net/admin/weixin/
     
        网页登录进入的是后台
        微信里进入的OA
     
        网页中，微信登录，进入是后台
        再次load，是oa
     }
     
     {
        http://oa.shhyy.net/admin/app/
     }
     
     */
    
    {
        NSURL *url  = [[NSURL alloc] initWithString:@"http://oa.shhyy.net/admin/app/"];
        NSURLRequest *request   = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
