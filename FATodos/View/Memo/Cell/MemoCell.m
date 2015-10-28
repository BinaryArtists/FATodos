//
//  MemoCell.m
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "MemoCell.h"
#import "Memo.h"

@implementation MemoCell

- (void)awakeFromNib {
    [self.container circular:PIXEL_4];
    [self.container setBackgroundColor:[UIColor randomColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithModel:(id)model {
    Memo *memo          = model;
    CGSize screenSize   = [[UIScreen mainScreen] bounds].size;
    CGFloat preferHeight= [memo.content sizeWithFont:[UIFont systemFontOfSize:18.f]
                                                size:CGSizeMake(screenSize.width-PIXEL_16, screenSize.height)];
    
    return preferHeight+PIXEL_16+72;
}

@end
