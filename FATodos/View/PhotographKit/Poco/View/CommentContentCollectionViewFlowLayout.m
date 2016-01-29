//
//  CommentContentCollectionViewFlowLayout.m
//  FATodos
//
//  Created by qingqing on 16/1/29.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentContentCollectionViewFlowLayout.h"

#define     IPHONE5_WIDTH   320
#define     IPHONE5_HEIGHT  568

@implementation CommentContentCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize   = CGSizeMake(screen_width-2*PIXEL_4, screen_height*420/IPHONE5_HEIGHT);
    
    self.scrollDirection    = UICollectionViewScrollDirectionHorizontal;
    
    self.sectionInset       = UIEdgeInsetsMake(0, PIXEL_4, 0, PIXEL_4);
}

@end
