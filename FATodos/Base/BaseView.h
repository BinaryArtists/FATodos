//
//  BaseViewController.h
//  FATodos
//
//  Created by fallen.ink on 9/23/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIViewController <BaseViewProtocol>

// onLoadInstanceState 提供数据恢复

#pragma mark - Virtual method: Need to be overrided

/**
 *  Make constraints by code! Masonry is suggest.
 
 *  Call it at viewDidLoad 's end.
 */
- (void)applyViewConstraints;

/**
 *  Update Xib's constraints when needed.
 
 *  Call it where needed.
 */
- (void)updateVCviewsConstraints;

/**
 *  Just override api's method here.
 */
- (void)updateViewConstraints;

@end
