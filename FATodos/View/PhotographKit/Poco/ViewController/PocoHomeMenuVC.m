//
//  PocoHomeMenuVC.m
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeMenuVC.h"

@interface PocoHomeMenuVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopSpaceConstaint;

@property (nonatomic, strong) NSArray<NSString *> * titles;

@end

@implementation PocoHomeMenuVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.delegate, @"delegate nil");
    NSAssert([self.delegate respondsToSelector:@selector(titlesOfPocoHomeMenu:)], @"titlesOfPocoHomeMenu: not implemented");
    NSAssert([self.delegate respondsToSelector:@selector(pocoHomeMenu:didClickAtIndex:)], @"pocoHomeMenu:didClickAtIndex: not implemented");
    NSAssert([self.delegate respondsToSelector:@selector(pocoHomeMenu:didCancel:)], @"pocoHomeMenu:didCancel: not implemented");
    
    // 根据datasource，计算tableview的上高度
    {
        
    }
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
