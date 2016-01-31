//
//  CommentBottomCell.m
//  FATodos
//
//  Created by qingqing on 16/1/29.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentBottomCell.h"

@implementation CommentBottomCell

- (void)awakeFromNib {
    self.layer.cornerRadius = PIXEL_8;
    self.layer.masksToBounds= YES;
    
    self.imageView.layer.cornerRadius = PIXEL_8;
    self.imageView.layer.masksToBounds= YES;
}

@end
