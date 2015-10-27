//
//  ScrollView.m
//  Scroller
//
//  Created by reefaq on 25/04/12.
//  Copyright (c) 2012 raw engineering. All rights reserved.
//

#import "ScrollView.h"
#import "UserBoxView.h"

#define USERBOX_WIDTH 250
#define USERBOX_HEIGHT 50

@interface ScrollView (hidden)

- (void) animateToIndex:(int)index  animated:(BOOL)animated;
- (void) load;
- (void) setup;
- (void) playSound;
@end


@implementation ScrollView

@synthesize scrollViewDelegate;
@synthesize currentSize;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self load];
        currentSize = [[UIScreen mainScreen] bounds].size;
        
        super.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self setBounces:NO];
        
        //initalize soundfile
        NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/Tock.wav"];
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRecentChat:) name:@"ReceivedChatMessage" object:nil];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		[self load];
		currentSize = frame.size;
		
		super.delegate = self;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
        [self setBounces:NO];
        
        //initalize soundfile
        NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/Tock.wav"];
        NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
        
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRecentChat:) name:@"ReceivedChatMessage" object:nil];
		
    }
    return self;
}

- (void) load {
	self.backgroundColor = [UIColor blackColor];
	
	views = [[NSMutableArray alloc] init];
	
	currentIndex = -1;
	coverSize = CGSizeMake(250, 50);
	spaceFromCurrent = (coverSize.width/2) - 45;
	[self setup];
}

- (void) setup {
	
	for(UIView *v in views) [v removeFromSuperview];
	[views removeAllObjects];
	
	currentSize = self.frame.size;
	currentIndex = -1;
	self.contentOffset = CGPointZero;
	
}

- (void) animateToIndex:(int)index animated:(BOOL)animated {
	
//	NSString *string = @"";
    float speed = 0;
	if(velocity> 200) animated = NO;
	
	if(animated){
		speed = 0.20;
		if(velocity>80)speed=0.05;
/*		[UIView beginAnimations:string context:nil];
		[UIView setAnimationDuration:speed];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationBeginsFromCurrentState:NO]; */
	}
    
    int currentViewIndex = 0;
	for(UIView *v in views){
		//v.alpha = 0;
		if (currentViewIndex == index) {
            v.alpha = 1;
            [v setBackgroundColor:rgba_color(255,255,255,1)];
            [UIView animateWithDuration:speed delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                v.layer.transform = CATransform3DMakeTranslation(-(spaceFromCurrent-30), 0, -300);
            } completion:^(BOOL finished) {
                //
            }];
		}else {
			[v setBackgroundColor:rgba_color(255,255,255,0.8)];
			if (currentViewIndex == index-1 || currentViewIndex == index + 1) {
                [UIView animateWithDuration:speed delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.alpha = 0.9;
                    v.layer.transform = CATransform3DConcat(CATransform3DMakeScale(0.8, 0.8, 1),CATransform3DMakeTranslation(-(spaceFromCurrent-70), 0, -300));
                } completion:^(BOOL finished) {
                    //
                }];
			}else if (currentViewIndex == index-2 || currentViewIndex == index + 2) {
                [UIView animateWithDuration:speed delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.alpha = 0.7;
                    v.layer.transform = CATransform3DConcat(CATransform3DMakeScale(0.7, 0.7, 1),CATransform3DMakeTranslation(-(spaceFromCurrent-90), (currentViewIndex > index? -8:8), -300));
                } completion:^(BOOL finished) {
                    //
                }];

			}else if (currentViewIndex == index-3 || currentViewIndex == index + 3) {

                [UIView animateWithDuration:speed delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.alpha = 0.5;
                    v.layer.transform = CATransform3DConcat(CATransform3DMakeScale(0.6, 0.6, 1),CATransform3DMakeTranslation(-(spaceFromCurrent-110), (currentViewIndex > index? -22:22), -300));
                } completion:^(BOOL finished) {
                    //
                }];

				
			}else {

                [UIView animateWithDuration:speed delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    v.alpha = 0;
                    v.layer.transform = CATransform3DConcat(CATransform3DMakeScale(0.6, 0.6, 1),CATransform3DMakeTranslation(-(spaceFromCurrent-130), (currentViewIndex > index? -38:38), -300));
                } completion:^(BOOL finished) {
                    //
                }];

				
			}
		}
        currentViewIndex++;
	}
//	if(animated) [UIView commitAnimations];
    
    [self playSound];
	
}

-(void)playSound {
	AudioServicesPlaySystemSound(soundID);
}

#pragma mark UIScrollView Delegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    	
	float yOffset = scrollView.contentOffset.y;
    
	velocity = abs(pos - yOffset);
	pos = yOffset;
	
	CGFloat num = totalViews;
    // fallenink: 需要计算，当前第几个条目，在ScrollView有效显示区域的中央
	CGFloat per = (scrollView.contentOffset.y) / (self.contentSize.height - (currentSize.height));
	CGFloat ind = num * per;
	CGFloat mi = ind / (totalViews/2);
	
	mi = 1 - mi;
	mi = mi / 2;
	int index = (int)(ind+mi);

	index = MIN(MAX(0,index),totalViews-1);
	
	if(index == currentIndex) return;

	currentIndex = index;
	
	if(velocity < 180) {
		[self animateToIndex:index animated:YES];
    }

}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	if(!scrollView.tracking && !scrollView.decelerating){
		[self snapToAlbum:YES];
	} 
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if(!scrollView.decelerating && !decelerate){
		[self snapToAlbum:YES];
	}
}

#pragma mark Touch Events
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	
	if(touch.view != self &&  [touch locationInView:touch.view].y < coverSize.height){
		currentTouch = touch.view;
	}
	
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if(touch.view == currentTouch){
		if(touch.tapCount == 1 && currentIndex == [views indexOfObject:currentTouch]){
            if ([self.scrollViewDelegate respondsToSelector:@selector(selectedView:)]) {
                [self.scrollViewDelegate selectedView:(UserBoxView*)currentTouch];
            }
		}
	}
	
	currentTouch = nil;
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	if(currentTouch!= nil) currentTouch = nil;
}

#pragma mark Public Methods
- (void) bringViewAtIndexToFront:(int)index animated:(BOOL)animated{
    if(index == currentIndex) return;

	if (index < totalViews) {

		currentIndex = index;
		
		[self snapToAlbum:animated];
		[self animateToIndex:index animated:animated];
	}else {
		return;
	}
	
}

- (void) snapToAlbum:(BOOL)animated{
	
	if (currentIndex < totalViews) {
		UIView *v = [views objectAtIndex:currentIndex];
		
		if((NSObject*)v!=[NSNull null]) {
			[self setContentOffset:CGPointMake(0, (v.center.y  - (currentSize.height/2.2))) animated:animated];
            
            [self playSound];
		}
	}
	
}

- (void)addUserView:(UserBoxView *)userBoxView {
	float ypos = 0;
	
	ypos = currentSize.height /2.4;
	
	if (totalViews > 0) {
		ypos  += totalViews * 50 ;
	}
    
    [userBoxView setFrame:CGRectMake(70, ypos, USERBOX_WIDTH, USERBOX_HEIGHT)];
    [userBoxView arrangeViews];
     
	[views addObject:userBoxView];
	
	[self addSubview:userBoxView];
	ypos  = ypos + 50 + (currentSize.height/2.2);

	totalViews = [views count];
	self.contentSize = CGSizeMake(currentSize.width, ypos);

}

-(void)jumpToLast:(BOOL)animated {
    int lastIndex = totalViews - 1 ;
    [self bringViewAtIndexToFront:lastIndex animated:animated];
}

- (void) dealloc {	
    AudioServicesDisposeSystemSoundID(soundID);
    self.scrollViewDelegate = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
