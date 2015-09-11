//
//  UserBoxView.m
//  Scroller
//
//  Created by reefaq on 25/04/12.
//  Copyright (c) 2012 raw engineering. All rights reserved.
//

#import "UserBoxView.h"

@implementation UserBoxView

@synthesize userImageView = _userImageView, displayTextLabel = _displayTextLabel, badgeLabel = _badgeLabel;

- (id)init{
    
    self = [super init];
    if (self) {
        // Initialization code.
		
		self.layer.cornerRadius = 5;
		[self setBackgroundColor:RGBACOLOR(255,255,255,1)];
		
		_userImageView = [[UIImageView alloc] init];
		[_userImageView setBackgroundColor:[UIColor clearColor]];
		_userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
		_userImageView.layer.borderWidth = 2;
		[_userImageView setImage:[UIImage imageNamed:@"defaultPersonImage.png"]];
		[self addSubview:_userImageView];
		
		
		_displayTextLabel = [[UILabel alloc] init];
		[_displayTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
		[_displayTextLabel setLineBreakMode:UILineBreakModeTailTruncation];
        [_displayTextLabel setContentMode:UIViewContentModeCenter];
		[_displayTextLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:_displayTextLabel];
		
		
		_badgeLabel = [[UILabel alloc] init];
		[_badgeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
		[_badgeLabel setContentMode:UIViewContentModeCenter];
		[_badgeLabel setTextAlignment:UITextAlignmentCenter];
		[_badgeLabel setBackgroundColor:RGBCOLOR(182,224,13)];
		_badgeLabel.layer.cornerRadius = 3;
		[self addSubview:_badgeLabel];
		
    }
    return self;
}

-(void)arrangeViews {
    
    [_userImageView setFrame:CGRectMake(1, 1, 46, 47)];
    
    if (_badgeLabel.text.length > 0) {
        [_displayTextLabel setFrame:CGRectMake(50, 0, self.frame.size.width - 75, self.frame.size.height)];
        [_badgeLabel setFrame:CGRectMake(self.frame.size.width - 25, (self.frame.size.height/2) -10, 20, 20)];
    }else {
        [_displayTextLabel setFrame:CGRectMake(50, 0, self.frame.size.width - 50, self.frame.size.height)];
        [_badgeLabel setFrame:CGRectZero];
    }
    
}

@end
