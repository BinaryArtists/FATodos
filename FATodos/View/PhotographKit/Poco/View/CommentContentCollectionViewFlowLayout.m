//
//  CommentContentCollectionViewFlowLayout.m
//  FATodos
//
//  Created by qingqing on 16/1/29.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentContentCollectionViewFlowLayout.h"

@implementation CommentContentCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize   = CGSizeMake(screen_width-2*PIXEL_4, screen_height*420/iphone5_screen_height);
    
    self.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
    
    self.sectionInset       = UIEdgeInsetsMake(0, PIXEL_4, 0, PIXEL_4);
}

@end
