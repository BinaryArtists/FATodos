//
//  MemoCell.m
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "MemoCell.h"

@implementation MemoCell

- (void)awakeFromNib {
    [self.container circular:PIXEL_4];
    [self.container setBackgroundColor:[UIColor red_1_color]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 92.f;
}

@end
