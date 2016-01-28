//
//  PocoHomeMenuVC.m
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeMenuVC.h"

static const CGFloat kCellDefaultHeight = 50.f;

@interface PocoHomeMenuVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopSpaceConstaint;

@property (nonatomic, strong) NSArray<NSString *> * titles;
@property (nonatomic, strong) NSArray<NSString *> * images;

@end

@implementation PocoHomeMenuVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.delegate, @"delegate nil");
    NSAssert([self.delegate respondsToSelector:@selector(titlesOfPocoHomeMenu:)], @"titlesOfPocoHomeMenu: not implemented");
    NSAssert([self.delegate respondsToSelector:@selector(imagesOfPocoHomeMenu:)], @"imagesOfPocoHomeMenu: not implemented");
    NSAssert([self.delegate respondsToSelector:@selector(pocoHomeMenu:didClickAtIndex:)], @"pocoHomeMenu:didClickAtIndex: not implemented");
    NSAssert([self.delegate respondsToSelector:@selector(pocoHomeMenu:didCancel:)], @"pocoHomeMenu:didCancel: not implemented");
    
    {
        self.titles = [self.delegate titlesOfPocoHomeMenu:self];
        self.images = [self.delegate imagesOfPocoHomeMenu:self];
    }
    
    {
        [self.tableView registerClass:[UITableViewCell class]
               forCellReuseIdentifier:[UITableViewCell identifier]];
        self.tableView.tableFooterView  = [UIView new];
    }
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // 根据datasource，计算tableview的上高度
    {
        CGFloat tableViewHeight = self.titles.count * kCellDefaultHeight;
        self.tableViewTopSpaceConstaint.constant    = (screen_height - tableViewHeight)/2;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellDefaultHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell identifier] forIndexPath:indexPath];
    
    cell.imageView.image    = [UIImage imageNamed:self.images[indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.backgroundColor    = [UIColor clearColor];
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pocoHomeMenu:self didClickAtIndex:(int32_t)indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
