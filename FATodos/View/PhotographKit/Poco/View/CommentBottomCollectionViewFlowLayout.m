//
//  CommentBottomCollectionViewFlowLayout.m
//  FATodos
//
//  Created by qingqing on 16/1/29.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentBottomCollectionViewFlowLayout.h"

@implementation CommentBottomCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(screen_width/8-2, 60);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, PIXEL_2, 0, PIXEL_2);
    self.minimumLineSpacing = PIXEL_2;
}

@end
