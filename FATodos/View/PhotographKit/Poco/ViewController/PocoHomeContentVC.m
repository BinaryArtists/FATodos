//
//  PocoHomeContentVC.m
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeContentVC.h"
#import "CommentBottomCollectionView.h"
#import "CommentItemView.h"
#import "CommentBottomCollectionViewFlowLayout.h"
#import "CommentContentCollectionViewFlowLayout.h"

@interface PocoHomeContentVC ()

@property (nonatomic, assign, readonly) eTypeId typeId;

@property (weak, nonatomic) IBOutlet UICollectionView *contentCollectionView;
@property (weak, nonatomic) IBOutlet CommentBottomCollectionView *bottomCollectionView;

- (void)loadMore;

@end

@implementation PocoHomeContentVC

#pragma mark - Initialize

- (void)initData {
    
}

- (void)initView {
    // init header
    {
        
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data accessor

- (void)loadListWithCommentTypeId:(eTypeId)typeId {
    {
        _typeId = typeId;
    }
}

- (void)loadMore {
    
}

@end
