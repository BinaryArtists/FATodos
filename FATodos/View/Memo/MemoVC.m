//
//  MemoVC.m
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "MemoVC.h"
#import "Memo.h"
#import "MemoCell.h"

@interface MemoVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *      tableData;

@end

@implementation MemoVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Self attribute
    {
        self.title      = @"便签";
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // NavigationBar attribute
    {
        [self setNavRightItemWithName:@"新增"
                               target:self
                               action:@selector(clickOnAddNewMemo:)];
        
        // todo: 添加一个右侧按钮 语音输入, 仅仅是尝试，并且扩展setNavRightItemWithName，让他能添加多个
        
        // todo: 用类似微信的方式，下拉列表去，弹出 语音输入
    }
    
    // Table data source
    {
        self.tableData  = [NSMutableArray new];
        
        [self.tableData addObject:[Memo new]];
        [self.tableData addObject:[Memo new]];
        [self.tableData addObject:[Memo new]];
        [self.tableData addObject:[Memo new]];
        [self.tableData addObject:[Memo new]];
        
    }
    
    // TableView setting
    {
        [MemoCell registerOn:self.tableView];
        
        self.tableView.tableFooterView  = [UIView new];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handler

- (void)clickOnAddNewMemo:(id)sender {
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MemoCell cellHeightWithModel:[self.tableData objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoCell *cell      = [tableView dequeueReusableCellWithIdentifier:[MemoCell identifier]
                                                          forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
}

@end
