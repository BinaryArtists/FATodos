//
//  PocoHomeContentVC.m
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeContentVC.h"
#import "CommentBottomCollectionView.h"
#import "CommentContentCell.h"
#import "CommentBottomCollectionViewFlowLayout.h"
#import "CommentContentCollectionViewFlowLayout.h"

@interface PocoHomeContentVC () <
    UICollectionViewDataSource,
    UICollectionViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet CommentBottomCollectionView *bottomCollectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) int64_t loadTag;

- (void)loadMore;

@end

@implementation PocoHomeContentVC

#pragma mark - Initialize

- (void)initData {
    if (!self.loadTag) {
        self.loadTag    = [[NSDate new] timeIntervalSince1970];
    }
    
    self.dataSource     = [NSMutableArray new];
}

- (void)initView {
    // init header
    {
        self.loadTag    = [[NSDate new] timeIntervalSince1970];
    }
    
    // init content collection view
    {
        self.contentCollectionView.collectionViewLayout = [CommentContentCollectionViewFlowLayout new];
    }
    
    // init bottom collection  view
    {
        self.bottomCollectionView.collectionViewLayout = [CommentBottomCollectionViewFlowLayout new];
    }
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI data

- (void)reloadContentCollectionView:(NSArray *)array {
    self.dataSource = [array mutableCopy];
    
    [self.contentCollectionView reloadData];
}

- (void)loadMoreContentCollectionView:(NSArray *)appendArray {
    [self.dataSource addObjectsFromArray:appendArray];
}

#pragma mark - Data accessor

- (void)reloadWithTypeId:(eTypeId)typeId {
    
    {
        _typeId = typeId;
    }
    
    { // 获取最新时间的列表
        self.loadTag    = [[NSDate new] timeIntervalSince1970];
    }
    
    [[PocoApi sharedInstance] commentListWithTypeId:typeId
                                     successHandler:^(id obj) {
                                         //
                                         
                                         [self reloadContentCollectionView:nil];
                                         
                                         // record loadTag
                                         
                                     } failureHandler:^(NSError *error) {
                                         //
                                     }];
}

- (void)loadMore {
    
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.contentCollectionView == collectionView) {
        
    } else if (self.bottomCollectionView == collectionView) {
        
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.contentCollectionView == collectionView) {
        
    } else if (self.bottomCollectionView == collectionView) {
        
    }
}

@end
