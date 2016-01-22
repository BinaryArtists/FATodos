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
    
    self.title  = [s PhotoComment];
    
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
    
    {
        NSURL *url  = [[NSURL alloc] initWithString:@"http://photo.poco.cn/dianping/"];
//        NSURL *url  = [[NSURL alloc] initWithString:@"http://www.baidu.com"];
        NSURLRequest *request   = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    
    [self loadHtml];
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

#pragma mark - Network

- (void)loadHtml {
    MKNetworkHost *host = [[MKNetworkHost alloc] initWithHostName:@"photo.poco.cn"];
    MKNetworkRequest *request   = [host requestWithURLString:@"http://photo.poco.cn/dianping/"];
    [request addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        NSLog(@"%@", completedRequest.responseAsString);
    }];
    
    [host startRequest:request];
}

@end
