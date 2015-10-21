//
//  BaseViewController.m
//  FATodos
//
//  Created by fallen.ink on 9/23/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

#pragma mark - Initialize UInitialize

- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        [self initObserver];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initObserver];
    }
    
    return self;
}

- (void)initObserver {
    [self observeNotification:UIApplicationDidEnterBackgroundNotification];
}

- (void)uinitObserver {
    [self unobserveAllNotifications];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout         = UIRectEdgeNone;
    
    // todo: load cache
    NSMutableDictionary *bundle    = [NSMutableDictionary new];
    [self onLoadInstanceState:bundle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self uinitObserver];
}

#pragma mark - Notification handler

- (void)handleNotification:(NSNotification *)notification {
    if ([notification is:UIApplicationDidEnterBackgroundNotification]) {
        // todo: NSKeyedArchiver
        NSMutableDictionary *bundle = [NSMutableDictionary new];
        
        [self onSaveInstanceState:bundle];
    }
}

#pragma mark - BaseViewProtocol

/**
 *
 */

/**
 *  备忘录
 */
- (void)onSaveInstanceState:(NSMutableDictionary *)bundle {
    
}

- (void)onLoadInstanceState:(NSDictionary *)bundle {
    
}

@end
