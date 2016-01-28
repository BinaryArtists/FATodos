//
//  PocoHomeVC.m
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoHomeVC.h"
#import "PocoHomeContentVC.h"
#import "PocoHomeMenuVC.h"

/**
 1. 大图模式
 参考：http://code4app.com/ios/%E9%AB%98%E4%BB%BF%E6%9C%80%E7%BE%8E%E5%BA%94%E7%94%A8%EF%BC%BB%E6%8C%81%E7%BB%AD%E6%9B%B4%E6%96%B0%E4%B8%AD%EF%BC%BD/567aa793594b907e7a8b4a5b
 
 
 2. 评论模式
 参考：微信的看图，切换评论
 */

@interface PocoHomeVC () <PocoHomeMenuDelegate>

@property (nonatomic, strong) PocoHomeMenuVC *menuVC;
@property (nonatomic, strong) PocoHomeContentVC *contentVC;

@property (nonatomic, strong) NSArray *commentTitles; //
@property (nonatomic, strong) NSArray *commentImages;

@property (nonatomic, assign) eTypeId commentTypeId;

@end

@implementation PocoHomeVC

#pragma mark - Initialize

- (void)initData {
    self.commentTitles  = @[L(@"poco.comment.subject.portrait"),
                            L(@"poco.comment.subject.scenery"),
                            L(@"poco.comment.subject.ecology"),
                            L(@"poco.comment.subject.documentary"),
                            L(@"poco.comment.subject.lomo"),
                            L(@"poco.comment.subject.conception"),
                            L(@"poco.comment.subject.commercy"),
                            L(@"poco.comment.subject.other")];
    self.commentImages  = @[@"menu_icon",@"menu_icon",@"menu_icon",@"menu_icon",
                            @"menu_icon",@"menu_icon",@"menu_icon",@"menu_icon"];
    
    self.commentTypeId      = type_id_portrait;
}

- (void)initViewController {
    self.menuVC = [[PocoHomeMenuVC alloc] _initWithNib];
    self.contentVC  = [[PocoHomeContentVC alloc] _initWithNib];
    
    self.menuVC.delegate    = self;
    
    [self addChildViewController:self.menuVC];
    [self addChildViewController:self.contentVC];
}

- (void)initView {
    [self.view addSubview:self.menuVC.view];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = L(@"poco.comment.home.title");
    
    self.view.backgroundColor   = [UIColor randomFlatColor];
    
    [self initData];
    
    [self initViewController];
    
    [self initView];
    
    [self applyViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden   = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden   = NO;
}

- (void)applyViewConstraints {
    [super applyViewConstraints];
    
    [self.menuVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.leading.equalTo(self.view.mas_leading);
        make.bottom.equalTo(self.view.mas_bottom);
        make.trailing.equalTo(self.view.mas_trailing);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data accesser

- (void)loadListWithCommentTypeId:(eTypeId)typeId {
    [[PocoApi sharedInstance] commentListWithTypeId:typeId
                                     successHandler:^(id obj) {
                                         //
                                     } failureHandler:^(NSError *error) {
                                         //
                                     }];
}

#pragma mark - PocoHomeMenuDelegate

- (NSArray<NSString *> *)titlesOfPocoHomeMenu:(PocoHomeMenuVC *)viewController {
    return self.commentTitles;
}

- (NSArray<NSString *> *)imagesOfPocoHomeMenu:(PocoHomeMenuVC *)viewController {
    return self.commentImages;
}

- (void)pocoHomeMenu:(PocoHomeMenuVC *)viewController didCancel:(BOOL)cancel {
    // 恢复为 content 模式
    [self hideMenuViewWithCompletionHandler:nil];
}

- (void)pocoHomeMenu:(PocoHomeMenuVC *)viewController didClickAtIndex:(int32_t)index {
    self.commentTypeId  = !is_type_id_valid(index) ? : index; // ...
    
    [self hideMenuViewWithCompletionHandler:^{
        [self loadListWithCommentTypeId:self.commentTypeId];
    }];
}

#pragma mark - View mode transite

- (void)showMenuViewWithCompletionHandler:(Block)completionHandler {
    NSAssert(completionHandler, @"");
}

- (void)hideMenuViewWithCompletionHandler:(Block)completionHandler {
    NSAssert(completionHandler, @"");
}

@end
