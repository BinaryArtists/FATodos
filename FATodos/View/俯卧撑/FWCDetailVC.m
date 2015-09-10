//
//  FWCDetailVC.m
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "FWCDetailVC.h"
#import "JDFPeekabooCoordinator.h"

@interface FWCDetailVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  fixme
 
 *  不起作用
 */
@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;

@end

@implementation FWCDetailVC

#pragma mark - Initialize

- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        self.title = @"Detail";
    }
    return self;
}

#pragma mark - Life cycle

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.scrollCoordinator disable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.scrollCoordinator enable];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    {
        self.scrollCoordinator                  = [[JDFPeekabooCoordinator alloc] init];
        self.scrollCoordinator.scrollView       = self.tableView;
//        self.scrollCoordinator.containingView   = self.navigationCont;
        self.scrollCoordinator.topView          = self.navigationController.navigationBar;
        self.scrollCoordinator.topViewMinimisedHeight = 20.0f;
        self.scrollCoordinator.bottomView       = self.navigationController.toolbar;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
