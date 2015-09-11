//
//  UserBoxView.h
//  Scroller
//
//  Created by reefaq on 25/04/12.
//  Copyright (c) 2012 raw engineering. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UserBoxView : UIView {

	UIImageView* _userImageView;
	UILabel* _displayTextLabel;
	UILabel* _badgeLabel;
	
}

@property (nonatomic,retain) UIImageView* userImageView;
@property (nonatomic,retain) UILabel* displayTextLabel;
@property (nonatomic,retain) UILabel* badgeLabel;

-(void)arrangeViews;

@end
