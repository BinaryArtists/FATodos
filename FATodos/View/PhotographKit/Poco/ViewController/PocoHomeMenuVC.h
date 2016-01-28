//
//  PocoHomeMenuVC.h
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "BaseView.h"

@protocol PocoHomeMenuDelegate;

@interface PocoHomeMenuVC : BaseView

@property (nonatomic, weak) id<PocoHomeMenuDelegate> delegate;

@end

/**
 *  
 */
@protocol PocoHomeMenuDelegate <NSObject>

- (NSArray<NSString *> *)titlesOfPocoHomeMenu:(PocoHomeMenuVC *)viewController;

- (NSArray<NSString *> *)imagesOfPocoHomeMenu:(PocoHomeMenuVC *)viewController;

- (void)pocoHomeMenu:(PocoHomeMenuVC *)viewController didClickAtIndex:(int32_t)index;

- (void)pocoHomeMenu:(PocoHomeMenuVC *)viewController didCancel:(BOOL)cancel;

@end