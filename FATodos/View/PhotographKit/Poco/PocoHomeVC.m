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

@interface PocoHomeVC () <PocoHomeMenuDelegate, PocoHomeHeaderDelegate>

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
    self.contentVC.delegate = self;
    
    [self addChildViewController:self.menuVC];
    [self addChildViewController:self.contentVC];
}

- (void)initView {
    self.menuVC.view.hidden = YES;
    [self.view addSubview:self.menuVC.view];
    
    [self.view addSubview:self.contentVC.view];
}

- (void)initAction {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoubleClicked:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = L(@"poco.comment.home.title");
    self.edgesForExtendedLayout         = UIRectEdgeAll; // fixme：加了这个，menu还是不剧中？？？？
    self.view.backgroundColor   = [UIColor randomFlatColor];
    
    [self initData];
    
    [self initViewController];
    
    [self initView];
    
    [self initAction];
    
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
    
    [self.contentVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
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

#pragma mark - Action handler

- (void)onDoubleClicked:(UIGestureRecognizer *)gesture {
    [self setNavigationBarShown:!self.navigationBarShown];
}

#pragma mark - PocoHomeHeaderDelegate

- (void)pocoHomeConent:(UIViewController *)viewController didClickedOnMenuButton:(id)sender {
    if (self.menuVC.view.hidden) {
        [self showMenuViewWithCompletionHandler:nil];
    } else {
        [self hideMenuViewWithCompletionHandler:nil];
    }
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
        // do when typeId changed
    }];
}

#pragma mark - View mode transite

/**
 *  Menu 与 content 之间的切换动画
 */

- (void)showMenuViewWithCompletionHandler:(Block)completionHandler {
    self.menuVC.view.hidden     = NO;
    self.menuVC.view.transform  = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.contentVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.leading.equalTo(self.view.mas_leading).offset(240.f);
                         }];
                         
                         [self.view layoutIfNeeded];
                         
                         self.menuVC.view.transform  = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished) {
                         if (completionHandler) completionHandler();
                     }];
}

- (void)hideMenuViewWithCompletionHandler:(Block)completionHandler {
    self.menuVC.view.transform  = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self.contentVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.leading.equalTo(self.view.mas_leading);
                         }];
                         
                         [self.view layoutIfNeeded];
                         
                         self.menuVC.view.transform  = CGAffineTransformMakeScale(0.5, 0.5);
                     } completion:^(BOOL finished) {
                         
                         self.menuVC.view.hidden     = YES;
                         
                         if (completionHandler) completionHandler();
                     }];
}


/**

func leftMenuShowAnimate() {
    UIView.animateWithDuration(animationDuration, animations: { [unowned self]() -> Void in
        self.centerController!.view.x = self.menuWith
        self.leftController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        self.cover.hidden = false
    })
}

func leftMenuHiddenAnimate () {
    
    UIView.animateWithDuration(animationDuration, animations: { [unowned self]() -> Void in
        self.centerController!.view.x = 0
        self.cover.hidden = true
    }) { (finish) -> Void in
        self.leftController.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }
}


 */

@end
