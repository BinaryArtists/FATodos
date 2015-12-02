//
//  LaunchMediaVC.m
//  FATodos
//
//  Created by fallen.ink on 12/1/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "LaunchMediaVC.h"

@interface LaunchMediaVC ()

@property (nonatomic, weak) id<LaunchMediaViewControllerDelegate> delegate;

@end

@implementation LaunchMediaVC

#pragma mark - Life cycle

- (instancetype)initWithResourceMediaFile:(NSString *)filename {
    return [self initWithResourceMediaFile:filename delegate:nil];
}

- (instancetype)initWithResourceMediaFile:(NSString *)filename delegate:(id)delegate {
    if (self = [super initWithContentURL:[self URLWithResourceMediaFile:filename]]) {
        self.delegate   = delegate;
        
        [self initDefault];
        
        [self initObserver];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor   = [UIColor blackColor];
    
    [self.moviePlayer play];
}

- (void)dealloc {
    [self uinitObserver];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.userInterfaceOrientationMask;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - Initialize

- (void)initDefault {
    self.userInterfaceOrientationMask   = UIInterfaceOrientationMaskPortrait;
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    self.moviePlayer.scalingMode = MPMovieScalingModeFill;
    
    [self.moviePlayer setFullscreen:YES animated:NO];
}

- (void)initObserver {
    [self observeNotification:MPMoviePlayerPlaybackDidFinishNotification];
}

- (void)uinitObserver {
    [self unobserveAllNotifications];
}

#pragma mark - 

- (void)handleNotification:(SamuraiNotification *)notification {
    if ([notification is:MPMoviePlayerPlaybackDidFinishNotification]) {
        if ([self.delegate respondsToSelector:@selector(launchMediaViewController:didMoviePlayerPlaybackDidFinish:)]) {
            [self notify:UIDeviceOrientationDidChangeNotification];
            
            [self.delegate launchMediaViewController:self didMoviePlayerPlaybackDidFinish:YES];
        }
    }
}

#pragma mark - 

- (NSURL *)URLWithResourceMediaFile:(NSString *)filename {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *videoPath = [resourcePath stringByAppendingPathComponent:filename];
    
    // 或者将filename split一下
    // NSString *moviePath = [bundle pathForResource:@"intro" ofType:@"mp4"];
    
    return [NSURL fileURLWithPath:videoPath];
}

@end
