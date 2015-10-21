//
//  Item_1_Cell.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Item_1_Cell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_3_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_2_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_1_titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_3_valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_2_valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *round_1_valueLabel;

- (void)setModel:(id)model;

- (CGFloat)cellHeight;

@end
