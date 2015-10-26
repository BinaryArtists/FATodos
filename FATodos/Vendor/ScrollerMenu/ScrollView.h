//
//  ScrollView.h
//  Scroller
//
//  Created by reefaq on 25/04/12.
//  Copyright (c) 2012 raw engineering. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserBoxView;
@protocol ScrollViewDelegate;

@interface ScrollView : UIScrollView <UIScrollViewDelegate> {

	NSMutableArray *views;

	CGSize coverSize;
	float spaceFromCurrent;
	
	int  currentIndex, totalViews;
	
	UIView *currentTouch;
	
	// SPEED
	int pos;
	long velocity;
	
    SystemSoundID soundID;
}

@property (nonatomic, unsafe_unretained) id <ScrollViewDelegate> scrollViewDelegate;

// 默认为屏幕大小
// 需要：实际的显示大小
@property (nonatomic, assign) CGSize currentSize;

- (void) bringViewAtIndexToFront:(int)index animated:(BOOL)animated;
- (void) addUserView:(UserBoxView*)userBoxView;
- (void) snapToAlbum:(BOOL)animated;
- (void) jumpToLast:(BOOL)animated;
@end

@protocol ScrollViewDelegate <NSObject>
@optional
- (void) selectedView:(UserBoxView*)selectedview;
@end
