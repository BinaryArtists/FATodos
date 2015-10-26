//
//  Item_1_Cell.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

// 常量定义
const static NSString *kAnimationDirectionLeft  = @"left"; // 向左
const static NSString *kAnimationDirectionRight  = @"right"; // 向右
const static NSString *kAnimationDirectionUp  = @"up";
const static NSString *kAnimationDirectionDown  = @"down";

const static NSTimeInterval kAnimateDuration    = 0.7f;

@interface Item_1_Cell : MGSwipeTableCell

// Animation
@property (weak, nonatomic) IBOutlet UIView *animateHolderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animateHorizontalConstraint;

- (void)pushCellWithAnimation:(BOOL)animated direction:(const NSString *)direction;
- (void)pushCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration direction:(const NSString *)direction;
- (void)pushCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration direction:(const NSString *)direction completionBlock:(Block)completionHandler;

- (void)popCellWithAnimation:(BOOL)animated; // 默认：向右
- (void)popCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)popCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration completionBlock:(Block)comletionHandler;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_3_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_2_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_1_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_3_valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_2_valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_1_valueLabel;

- (void)setModel:(id)model;

- (CGFloat)cellHeight;

@end
