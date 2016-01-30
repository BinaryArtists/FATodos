//
//  CommentContentCell.m
//  FATodos
//
//  Created by qingqing on 16/1/29.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentContentCell.h"

@implementation CommentContentCell

- (void)awakeFromNib {
    self.layer.cornerRadius = PIXEL_8;
    self.layer.masksToBounds= YES;
}

@end
