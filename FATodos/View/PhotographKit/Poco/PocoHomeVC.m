//
//  PocoHomeVC.m
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeVC.h"

@interface PocoHomeVC ()

@property (nonatomic, strong) NSArray *commentTitles; // 点评下的各个系列

@end

@implementation PocoHomeVC

#pragma mark - Initialize

- (void)initData {
    self.commentTitles  = @[@"人像", @"风景", @"生态", @"纪实", @"Lomo", @"观念", @"商业", @"其他"];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
