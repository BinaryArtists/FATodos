//
//  PhotoCommentListVC.m
//  FATodos
//
//  Created by qingqing on 16/1/22.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PhotoCommentListVC.h"

@interface PhotoCommentListVC ()

@property (nonatomic, strong) NSArray *commentTitles; // 点评下的各个系列

@end

@implementation PhotoCommentListVC

#pragma mark - Initialize

- (void)initData {
    self.commentTitles  = @[@"人像", @"风景", @"生态", @"纪实", @"Lomo", @"观念", @"商业", @"其他"];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    {
        UIBarButtonItem *addContactBarButton    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onMenu)];
        self.navigationItem.rightBarButtonItem  = addContactBarButton;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handler

- (void)onMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[0]
                                                iconName:@"post_type_bubble_flickr" glowColor:[UIColor grayColor] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[1]
                                      iconName:@"post_type_bubble_googleplus" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[2]
                                      iconName:@"post_type_bubble_instagram" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[3]
                                      iconName:@"post_type_bubble_twitter" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[4]
                                      iconName:@"post_type_bubble_youtube" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[5]
                                      iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[6]
                                      iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:self.commentTitles[7]
                                      iconName:@"post_type_bubble_facebook" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:0];
    [items addObject:menuItem];
    
    [FAPopup showPopMenuWithItems:items
             didSelectedItemBlock:^(MenuItem *selectedItem) {
                 ///
             }];
}


@end
