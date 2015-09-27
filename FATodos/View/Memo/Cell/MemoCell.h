//
//  MemoCell.h
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *container;

+ (CGFloat)cellHeightWithModel:(id)model;

@end
