//
//  Item_1_Cell.m
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Item_1_Cell.h"
#import "Item_1_Cache.h"

@interface Item_1_Cell ()

@property (nonatomic, weak) Item1 *item;

@end

@implementation Item_1_Cell

#pragma mark - Animate

- (void)pushCellWithAnimation:(BOOL)animated direction:(const NSString *)direction {
    [self pushCellWithAnimation:animated duration:kAnimateDuration direction:direction];
}

- (void)pushCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration direction:(const NSString *)direction {
    [self pushCellWithAnimation:animated duration:duration direction:direction completionBlock:nil];
}

- (void)pushCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration direction:(const NSString *)direction completionBlock:(Block)completionHandler {
    if ([direction isEqualToString:(NSString *)kAnimationDirectionUp]) {
        NSAssert(NO, @"未实现");
    } else if ([direction isEqualToString:(NSString *)kAnimationDirectionDown]) {
        NSAssert(NO, @"未实现");
    } else if ([direction isEqualToString:(NSString *)kAnimationDirectionLeft]) {
        self.animateHorizontalConstraint.constant   = kScreenWidth;
    } else if ([direction isEqualToString:(NSString *)kAnimationDirectionRight]) {
        self.animateHorizontalConstraint.constant   = -kScreenWidth;
    } else {
        NSAssert(NO, @"不支持");
    }
    
    if (!animated) duration = 0.f;
    
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:duration
                          delay:0.f
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.animateHorizontalConstraint.constant  = 0;

                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
                         if (finished && completionHandler) {
                             completionHandler();
                         }
                     }];
}

- (void)popCellWithAnimation:(BOOL)animated {
    [self popCellWithAnimation:animated duration:kAnimateDuration];
}

- (void)popCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration {
    [self popCellWithAnimation:animated duration:duration completionBlock:nil];
}

- (void)popCellWithAnimation:(BOOL)animated duration:(NSTimeInterval)duration completionBlock:(Block)comletionHandler {
    
    if (!animated) duration = 0.f;
    
    [UIView animateWithDuration:duration
                          delay:0.f
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.animateHorizontalConstraint.constant = kScreenWidth;
                         
                         [self setNeedsUpdateConstraints];
                     } completion:^(BOOL finished) {
                         if (finished && comletionHandler) {
                             comletionHandler();
                         }
                     }];
}

#pragma mark - Normal

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)awakeFromNib {
    self.round_1_titleLabel.textColor   = [UIColor fontGray001Color];
    self.round_2_titleLabel.textColor   = [UIColor fontGray001Color];
    self.round_3_titleLabel.textColor   = [UIColor fontGray001Color];
    
    self.round_1_valueLabel.textColor   = [UIColor lightGreenColor];
    self.round_2_valueLabel.textColor   = [UIColor lightYellowColor];
    self.round_3_valueLabel.textColor   = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model {
    [self setModel:model withAnimate:NO];
}

- (void)setModel:(id)model withAnimate:(BOOL)animate {
    Item1 *item         = model;
    
    if (animate) {
        self.animateHorizontalConstraint.constant   = -kScreenWidth;
    }
    
    self.nameLabel.text = item.name;
    
    if (!self.nameLabel.text) {
        self.nameLabel.text = [NSString stringWithFormat:@"空空如也"];
    }
    
    self.round_1_valueLabel.text    = [NSString stringWithFormat:@"%d", [item num_1]];
    self.round_2_valueLabel.text    = [NSString stringWithFormat:@"%d", [item num_2]];
    self.round_3_valueLabel.text    = [NSString stringWithFormat:@"%d", [item num_3]];
    
    @weakify(self)
    
    [[RACObserve(item, num_1) distinctUntilChanged] subscribeNext:^(id x) {
        NSNumber *value                 = x;
        
        @strongify(self)
        
        // 初始状态不更新，不然会产生死锁：addObject的completion中进行了insert
        if (!item.has_1) {
            return;
        }
        
        self.round_1_valueLabel.text    = [NSString stringWithFormat:@"%d", [value intValue]];
        
        [[Item_1_Cache sharedInstance] updateObject:item];
    }];
    
    [[RACObserve(item, num_2) distinctUntilChanged] subscribeNext:^(id x) {
        NSNumber *value                 = x;
        
        @strongify(self)
        
        if (!item.has_2) {
            return;
        }
        
        self.round_2_valueLabel.text    = [NSString stringWithFormat:@"%d", [value intValue]];
        
        [[Item_1_Cache sharedInstance] updateObject:item];
    }];
    
    [[RACObserve(item, num_3) distinctUntilChanged] subscribeNext:^(id x) {
        NSNumber *value                 = x;
        
        @strongify(self)
        
        if (!item.has_3) {
            return;
        }
        
        self.round_3_valueLabel.text    = [NSString stringWithFormat:@"%d", [value intValue]];
        
        [[Item_1_Cache sharedInstance] updateObject:item];
    }];
    
    self.item          = model;
}

- (CGFloat)cellHeight {
    return 60.f;
}

@end
