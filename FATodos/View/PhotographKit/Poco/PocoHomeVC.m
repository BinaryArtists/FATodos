//
//  PocoHomeVC.m
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeVC.h"

/**
 1. 大图模式
 参考：http://code4app.com/ios/%E9%AB%98%E4%BB%BF%E6%9C%80%E7%BE%8E%E5%BA%94%E7%94%A8%EF%BC%BB%E6%8C%81%E7%BB%AD%E6%9B%B4%E6%96%B0%E4%B8%AD%EF%BC%BD/567aa793594b907e7a8b4a5b
 
 
 2. 评论模式
 参考：微信的看图，切换评论
 */

@interface PocoHomeVC ()

@end

@implementation PocoHomeVC

#pragma mark - Initialize

- (void)initData {
   
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [[PocoApi sharedInstance] portraitListWithSuccessHandler:^(id obj) {
        //
    } failureHandler:^(NSError *error) {
        //
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden   = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden   = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
