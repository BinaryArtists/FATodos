//
//  Item_1_Cell.m
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Item_1_Cell.h"

@interface Item_1_Cell ()

@property (nonatomic, weak) Item1 *item;

@end

@implementation Item_1_Cell

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)awakeFromNib {
    self.round_1_titleLabel.textColor   = [UIColor fontGray001Color];
    self.round_2_titleLabel.textColor   = [UIColor fontGray001Color];
    self.round_3_titleLabel.textColor   = [UIColor fontGray001Color];
    
    self.round_1_valueLabel.textColor   = [UIColor lightGreenColor];
    self.round_2_valueLabel.textColor   = [UIColor lightYellowColor];
    self.round_3_valueLabel.textColor   = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model {
    Item1 *item         = model;
    
    self.nameLabel.text = item.name;
    
    if (!self.nameLabel.text) {
        self.nameLabel.text = [NSString stringWithFormat:@"空空如也"];
    }

    self.item          = model;
}

- (CGFloat)cellHeight {
    return 60.f;
}

@end
