//
//  PocoHomeContentVC.h
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "BaseView.h"

@protocol PocoHomeHeaderDelegate;

@interface PocoHomeContentVC : BaseView

@property (nonatomic, assign, readonly) eTypeId typeId;

@property (nonatomic, weak) id<PocoHomeHeaderDelegate> delegate;

/**
 *  @desc typeid有效，且变化了，才reload
 
 *  @desc 加载更多，在PocoHomeContentVC中产生
 */
- (void)reloadWithTypeId:(eTypeId)typeId;

@end

@protocol PocoHomeHeaderDelegate <NSObject>

- (void)pocoHomeConent:(UIViewController *)viewController didClickedOnMenuButton:(id)sender;

@end