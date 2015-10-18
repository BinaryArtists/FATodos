//
//  MainVC.m
//  FATodos
//
//  Created by 李杰 on 9/11/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <AddressBookUI/AddressBookUI.h>

#import "MainVC.h"
#import "UserBoxView.h"
#import "ScrollView.h"

@interface MainVC () <ScrollViewDelegate>

@property (weak, nonatomic) IBOutlet ScrollView *   scrollView;

@property (nonatomic, strong) UserBoxView *         pushupView;
@property (nonatomic, strong) UserBoxView *         dumbellView;
@property (nonatomic, strong) UserBoxView *         sitsupView;
@property (nonatomic, strong) UserBoxView *         memoView;
@property (nonatomic, strong) UserBoxView *         noteView;
@property (nonatomic, strong) UserBoxView *         fourQuadrantView;
@property (nonatomic, strong) UserBoxView *         pomodoroView;

@property (nonatomic, strong) AFViewShaker *        viewShaker;

@end

@implementation MainVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title                              = @"功能目录";
    self.edgesForExtendedLayout             = UIRectEdgeNone;
    
    [self.view setBackgroundColor:[UIColor bgGrayColor]];

    UIBarButtonItem *addContactBarButton    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickOnAddNewContact:)];
    self.navigationItem.rightBarButtonItem  = addContactBarButton;
    
    self.scrollView.scrollViewDelegate      = self;
    self.scrollView.backgroundColor         = [UIColor clearColor];

    self.pushupView = [[UserBoxView alloc] init];
    [self.pushupView.displayTextLabel setText:[s Pushup]];
    [self.pushupView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];

    [self.scrollView addUserView:self.pushupView];

    self.dumbellView = [[UserBoxView alloc] init];
    [self.dumbellView.displayTextLabel setText:[s Dumbell]];
    [self.dumbellView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.dumbellView];

    self.sitsupView = [[UserBoxView alloc] init];
    [self.sitsupView.displayTextLabel setText:[s SitsUp]];
    [self.sitsupView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.sitsupView];

    self.memoView = [[UserBoxView alloc] init];
    [self.memoView.displayTextLabel setText:[s Memo]];
    [self.memoView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.memoView];
    
    self.noteView = [[UserBoxView alloc] init];
    [self.noteView.displayTextLabel setText:[s Note]];
    [self.noteView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.noteView];
    
    self.fourQuadrantView = [[UserBoxView alloc] init];
    [self.fourQuadrantView.displayTextLabel setText:[s FourQuadrant]];
    [self.fourQuadrantView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.fourQuadrantView];
    
    self.pomodoroView = [[UserBoxView alloc] init];
    [self.pomodoroView.displayTextLabel setText:[s Pomodoro]];
    [self.pomodoroView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:self.pomodoroView];
    
    [self.scrollView bringViewAtIndexToFront:3 animated:YES];
    
    {
        // Init view shaker
        // fixme：应该再做一层封装，让动作的主体，直接表现，而不是通过动作行为，来包含主题，在执行动作。
        self.viewShaker     = [[AFViewShaker alloc] initWithView:self.noteView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handle

- (void)clickOnAddNewContact:(id)sender {
    // Add function.....
}

#pragma mark - ScrollViewDelegate

- (void)selectedView:(UserBoxView *)selectedview {
    if (selectedview == self.pushupView) {
        [[Routable sharedRouter] open:[AppDelegate PUSHUP_VC] animated:YES];
    } else if (selectedview == self.dumbellView) {
        [[Routable sharedRouter] open:[AppDelegate PUSHUP_VC] animated:YES];
    } else if (selectedview == self.sitsupView) {
        [[Routable sharedRouter] open:[AppDelegate PUSHUP_VC] animated:YES];
    } else if (selectedview == self.memoView) {
        [[Routable sharedRouter] open:[AppDelegate MEMO_VC] animated:YES];
    } else if (selectedview == self.noteView) {
        // bug: fixme，动画有问题！会先回到中间，然后震动.
        [self.viewShaker shakeWithDuration:0.6
                                completion:^{
                                    AMSmoothAlertView *alert    = [[AMSmoothAlertView alloc] initFadeAlertWithTitle:@"Notice!"
                                                                                                            andText:@"店铺还未开张!" andCancelButton:YES
                                                                                                       forAlertType:AlertInfo];
                                    [alert show];
                                }];
    } else {
        // fixme: 这个alert需要优化
        AMSmoothAlertView *alert    = [[AMSmoothAlertView alloc] initFadeAlertWithTitle:@"Notice!"
                                                                                andText:@"店铺还未开张!" andCancelButton:YES
                                                                           forAlertType:AlertInfo];
        [alert show];
    }
}

@end
