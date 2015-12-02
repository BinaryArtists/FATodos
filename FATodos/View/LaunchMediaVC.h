//
//  LaunchMediaVC.h
//  FATodos
//
//  Created by fallen.ink on 12/1/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>

@protocol LaunchMediaViewControllerDelegate;

@interface LaunchMediaVC : MPMoviePlayerViewController

/**
 *  启动的时候默认的屏方式
 */
@property (nonatomic, assign) UIInterfaceOrientationMask userInterfaceOrientationMask;

/**
 *  结束后，是否自动切换回初始的屏方式
 */
@property (nonatomic, assign) BOOL autoSwitchOrientationAfterFinish;

- (instancetype)initWithResourceMediaFile:(NSString *)filename;

- (instancetype)initWithResourceMediaFile:(NSString *)filename delegate:(id<LaunchMediaViewControllerDelegate>)delegate;

@end

@protocol LaunchMediaViewControllerDelegate <NSObject>

- (void)launchMediaViewController:(LaunchMediaVC *)viewController didMoviePlayerPlaybackDidFinish:(BOOL)finish;

@end

/**
 *  FAQ
 *  1. http://stackoverflow.com/questions/7051208/emulating-splash-video-in-ios-application/
 *  2. UBer的做法是：用视频的主色调为背景，展示几秒的动画，然后play video。
 */
