//
//  QuadrantView.m
//  FATodos
//
//  Created by fallen.ink on 10/27/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "QuadrantView.h"
#import "QuadrantCell.h"

@interface QuadrantView ()

@end

@implementation QuadrantView

- (void)awakeFromNib {
    self.tableView.tableFooterView  = [UIView new];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Property

- (void)setDelegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate {
    _delegate   = delegate;
    
    {
        
    }
}

@end
