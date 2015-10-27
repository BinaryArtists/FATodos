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
static CGFloat kQuadrantMinorWidth    = 44.f;
const
static CGFloat kQuadrantMinorHeight   = 44.f;
static CGFloat kQuadrantMajorWidth    = 0.f;
static CGFloat kQuadrantMajorHeight   = 0.f;

@interface FourQuadrantVC ()

@property (weak, nonatomic) IBOutlet UIView *firstQuadrantView;     // left up
@property (weak, nonatomic) IBOutlet UIView *secondQuadrantView;    // right up
@property (weak, nonatomic) IBOutlet UIView *thirdQuadrantView;     // left down
@property (weak, nonatomic) IBOutlet UIView *forthQuadrantView;     // right down

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstQuadrantWidthConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstQuadrantHeightConstrait;

@end

@implementation FourQuadrantVC

#pragma mark - Initialize

- (void)initQuadrantStyle {
    kQuadrantMajorWidth = kScreenWidth - kQuadrantMinorWidth;
    kQuadrantMajorHeight= kScreenHeight-kNavigationHeight-kStatusHeight-kQuadrantMinorHeight;
    
    //
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
        self.firstQuadrantWidthConstrait.constant   = kQuadrantMajorWidth;
        self.firstQuadrantHeightConstrait.constant  = kQuadrantMajorHeight;
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
}

@end
