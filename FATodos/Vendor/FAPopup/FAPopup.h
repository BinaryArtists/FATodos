//
//  FAPopup.h
//  FATodos
//
//  Created by fallen.ink on 9/25/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPopup : NSObject

@singleton( FAPopup )

// 弹出框
@property (nonatomic, strong) UIScrollView *popup;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIView *contentHolder;
@property (nonatomic, assign) CGAffineTransform initialPopupTransform; // contentHolder
@property (nonatomic, strong) UIViewController *popupVC;
@property (nonatomic, strong) void (^dismissCompletionBlock) ();

+ (void)showPopup:(UIView *)contentView;
+ (void)showPopup:(UIView *)contentView touchBackgroundHide:(BOOL)hide;
+ (void)showPopupVC:(UIViewController *)popupVC;
+ (void)showPopupVC:(UIViewController *)popupVC touchBackgroundHide:(BOOL)hide;
+ (void)dismissPopup;
+ (void)setShowedPopupOriginY:(CGFloat)originY;
+ (void)resetShowedPopupOriginY;
+ (void)setDismissCompletionBlock:(void (^) ())complectionBlock;

@end
