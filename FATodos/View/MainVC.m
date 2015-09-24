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

@end

@implementation MainVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title                              = @"功能目录";
    self.edgesForExtendedLayout             = UIRectEdgeNone;
    
    [self.view setBackgroundColor:[UIColor bgGrayColor]];

    UIBarButtonItem *addContactBarButton    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewContact:)];
    self.navigationItem.rightBarButtonItem  = addContactBarButton;
    
    self.scrollView.scrollViewDelegate      = self;
    self.scrollView.backgroundColor         = [UIColor clearColor];

    UserBoxView *boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[s Pushup]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];

    [self.scrollView addUserView:boxView];

    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[s Dumbell]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];

    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[s SitsUp]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];

    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[s Memo]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];
    
    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[s Note]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];
    
    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[NSString stringWithFormat:@"啦啦啦啦啦"]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];
    
    boxView = [[UserBoxView alloc] init];
    [boxView.displayTextLabel setText:[NSString stringWithFormat:@"啦啦啦啦啦"]];
    [boxView.userImageView setImage:[UIImage imageNamed:@"userdefault.jpg"]];
    
    [self.scrollView addUserView:boxView];
    
    [self.scrollView bringViewAtIndexToFront:3 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handle

- (void)addNewContact:(id)sender {
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
        [[Routable sharedRouter] open:[AppDelegate PUSHUP_VC] animated:YES];
    } else if (selectedview == self.noteView) {
        [[Routable sharedRouter] open:[AppDelegate PUSHUP_VC] animated:YES];
    }
}

@end
