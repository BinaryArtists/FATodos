//
//  FAPopup.m
//  FATodos
//
//  Created by fallen.ink on 9/25/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "FAPopup.h"

static const NSUInteger kCoverViewTag = 99999;

@interface FAPopup () <UIGestureRecognizerDelegate>

@end

@implementation FAPopup

@def_singleton( FAPopup )

#pragma mark - 弹出框

+ (UIImage *)screenshotForView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    imageData = nil;
    
    return image;
}

- (void)handleCloseAction:(id)sender {
    [FAPopup dismissPopup];
}

+ (void)showPopup:(UIView *)contentView {
    [FAPopup showPopup:contentView touchBackgroundHide:YES];
}

+ (void)showPopup:(UIView *)contentView touchBackgroundHide:(BOOL)hide {
    if (!contentView) return;
    
    FAPopup *fapopup = [FAPopup sharedInstance];
    
    if (fapopup.popup) return;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    // 圆角
    contentView.layer.cornerRadius = 4.f;
    contentView.layer.masksToBounds = YES;
    
    // 内容图之下
    fapopup.contentHolder = [[UIView alloc] initWithFrame:contentView.frame];
    fapopup.contentHolder.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    [fapopup.contentHolder addSubview:contentView];
    
    // fa:
    // 配合KeyboardManager，这里使用ScrollView，会被自动识别为 遮挡的位移调整。
    fapopup.popup = [[UIScrollView alloc] initWithFrame:window.rootViewController.view.bounds];
    fapopup.popup.contentSize = CGSizeMake([UIUtils screenWidth], [UIUtils screenHeight]);
    fapopup.popup.showsHorizontalScrollIndicator = NO;
    fapopup.popup.showsVerticalScrollIndicator = NO;
    fapopup.popup.bounces = NO;
    fapopup.popup.scrollEnabled = NO;
    
    {
        // 获取截屏图，并高斯模糊
        //    UIImage *image = [Utils screenshotForView:window.rootViewController.view];
        //    image = [image boxblurImageWithBlur:0.1];
        //    utils.blurView = [[UIImageView alloc] initWithImage:image];
        //    utils.blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //    utils.blurView.alpha = 0;
        //    [[Utils sharedUtils].popup addSubview:utils.blurView];
    }
    
    // coverView
    fapopup.coverView = [[UIView alloc] initWithFrame:window.rootViewController.view.bounds];
    fapopup.coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    fapopup.coverView.backgroundColor = [UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:0.5];
    fapopup.coverView.tag = kCoverViewTag;
    [[FAPopup sharedInstance].popup addSubview:fapopup.coverView];
    
    // 点触事件
    if (hide) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:[FAPopup sharedInstance] action:@selector(handleCloseAction:)];
        tapGesture.delegate = [FAPopup sharedInstance];
        [fapopup.coverView addGestureRecognizer:tapGesture];
    }
    
    [fapopup.coverView addSubview:fapopup.contentHolder];
    fapopup.contentHolder.center = CGPointMake(fapopup.coverView.bounds.size.width/2,
                                             fapopup.coverView.bounds.size.height/2);
    fapopup.coverView.alpha = 0;
    
    fapopup.popup.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [window.rootViewController.view addSubview:fapopup.popup];
    [fapopup.popup bringToFront];
    
    fapopup.contentHolder.transform = CGAffineTransformMakeScale(0.8, 0.8);
    fapopup.initialPopupTransform = fapopup.contentHolder.transform;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         fapopup.coverView.alpha = 1;
                         fapopup.blurView.alpha = 1;
                         
                         fapopup.contentHolder.transform = CGAffineTransformIdentity;
                     }];
}

+ (void)showPopupVC:(UIViewController *)popupVC {
    [FAPopup showPopupVC:popupVC touchBackgroundHide:YES];
}

+ (void)showPopupVC:(UIViewController *)popupVC touchBackgroundHide:(BOOL)hide {
    [FAPopup sharedInstance].popupVC = popupVC;
    [FAPopup showPopup:popupVC.view touchBackgroundHide:hide];
}


+ (void)dismissPopup {
    FAPopup *utils = [FAPopup sharedInstance];
    if (utils.dismissCompletionBlock) {
        utils.dismissCompletionBlock();
        utils.dismissCompletionBlock = nil;
    }
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         utils.coverView.alpha = 0;
                         utils.contentHolder.transform = utils.initialPopupTransform;
                         utils.blurView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [utils.popup removeFromSuperview];
                         utils.popup = nil;
                         utils.blurView = nil;
                         utils.contentHolder = nil;
                         utils.coverView = nil;
                         if (utils.popupVC) {
                             utils.popupVC = nil;
                         }
                     }];
}

+ (void)setShowedPopupOriginY:(CGFloat)originY {
    FAPopup *util = [FAPopup sharedInstance]; // fixme: 修改局部变量
    if (util.contentHolder) {
        util.contentHolder.y = originY;
    }
}

+ (void)resetShowedPopupOriginY {
    FAPopup *util = [FAPopup sharedInstance];
    if (util.contentHolder && util.coverView) {
        util.contentHolder.center = CGPointMake(util.coverView.bounds.size.width/2,
                                                util.coverView.bounds.size.height/2);
    }
}

+ (void)setDismissCompletionBlock:(void (^)())complectionBlock {
    FAPopup *util = [FAPopup sharedInstance];
    util.dismissCompletionBlock = complectionBlock;
}

@end
