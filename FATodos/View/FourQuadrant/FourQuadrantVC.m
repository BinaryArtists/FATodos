//
//  FourQuadrantVC.m
//  FATodos
//
//  Created by fallen.ink on 10/18/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "QuadrantView.h"
#import "FourQuadrantVC.h"

const
static CGFloat kQuadrantMinorWidth    = 56.f;
const
static CGFloat kQuadrantMinorHeight   = 56.f;
static CGFloat kQuadrantMajorWidth    = 0.f;
static CGFloat kQuadrantMajorHeight   = 0.f;

@interface FourQuadrantVC () <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UIView *firstQuadrantView;     // left up
@property (weak, nonatomic) IBOutlet UIView *secondQuadrantView;    // right up
@property (weak, nonatomic) IBOutlet UIView *thirdQuadrantView;     // left down
@property (weak, nonatomic) IBOutlet UIView *forthQuadrantView;     // right down

@property (weak, nonatomic) UIView *firstQuadrantContentView;     // left up
@property (weak, nonatomic) UIView *secondQuadrantContentView;    // right up
@property (weak, nonatomic) UIView *thirdQuadrantContentView;     // left down
@property (weak, nonatomic) UIView *forthQuadrantContentView;     // right down

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstQuadrantWidthConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstQuadrantHeightConstrait;

@property (weak, nonatomic) UIView *selectedQuadrantView;

@property (nonatomic, assign) BOOL firstQuadrantEnabled;
@property (nonatomic, assign) BOOL secondQuadrantEnabled;
@property (nonatomic, assign) BOOL thirdQuadrantEnabled;
@property (nonatomic, assign) BOOL forthQuadrantEnabled;

@end

@implementation FourQuadrantVC

#pragma mark - Initialize

- (void)initQuadrantStyle {
    kQuadrantMajorWidth = kScreenWidth - kQuadrantMinorWidth;
    kQuadrantMajorHeight= kScreenHeight-kNavigationHeight-kStatusHeight-kQuadrantMinorHeight;
    
    [self.firstQuadrantView circular:PIXEL_4];
    [self.secondQuadrantView circular:PIXEL_4];
    [self.thirdQuadrantView circular:PIXEL_4];
    [self.forthQuadrantView circular:PIXEL_4];
    
    
}

- (void)initQuadrantGestures {
    UITapGestureRecognizer *firstTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onQuadrantSelected:)];
    [self.firstQuadrantView addGestureRecognizer:firstTap];
    
    UITapGestureRecognizer *secondTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onQuadrantSelected:)];
    [self.secondQuadrantView addGestureRecognizer:secondTap];
    
    UITapGestureRecognizer *thirdTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onQuadrantSelected:)];
    [self.thirdQuadrantView addGestureRecognizer:thirdTap];
    
    UITapGestureRecognizer *forthTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onQuadrantSelected:)];
    [self.forthQuadrantView addGestureRecognizer:forthTap];
    
    self.selectedQuadrantView   = self.firstQuadrantView;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initQuadrantStyle];
    
    [self initQuadrantGestures];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // 根据状态，来调整约束
    {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action handler

- (void)onQuadrantSelected:(UITapGestureRecognizer *)sender {
    if (sender.view == self.firstQuadrantView) {
        
    } else if (sender.view == self.secondQuadrantView) {
        
    } else if (sender.view == self.thirdQuadrantView) {
        
    } else if (sender.view == self.forthQuadrantView) {
        
    }
    
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.selectedQuadrantView   = sender.view;
                         
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         //
                     }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate



#pragma mark - Property

- (void)setSelectedQuadrantView:(UIView *)selectedQuadrantView {
    _selectedQuadrantView = selectedQuadrantView;
    
    if (selectedQuadrantView == self.firstQuadrantView) {
        self.firstQuadrantWidthConstrait.constant   = kQuadrantMajorWidth;
        self.firstQuadrantHeightConstrait.constant  = kQuadrantMajorHeight;
    } else if (selectedQuadrantView == self.secondQuadrantView) {
        self.firstQuadrantWidthConstrait.constant   = kQuadrantMinorWidth;
        self.firstQuadrantHeightConstrait.constant  = kQuadrantMajorHeight;
    } else if (selectedQuadrantView == self.thirdQuadrantView) {
        self.firstQuadrantWidthConstrait.constant   = kQuadrantMajorWidth;
        self.firstQuadrantHeightConstrait.constant  = kQuadrantMinorHeight;
    } else if (selectedQuadrantView == self.forthQuadrantView) {
        self.firstQuadrantWidthConstrait.constant   = kQuadrantMinorWidth;
        self.firstQuadrantHeightConstrait.constant  = kQuadrantMinorHeight;
    }
}

@end
