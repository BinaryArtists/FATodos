//
//  UITableViewCellProtocol.h
//  FATodos
//
//  Created by 李杰 on 9/12/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewCellProtocol <NSObject>

+ (NSString *)identifier;
+ (UINib *)nib;

- (CGFloat)cellHeight;
- (void)setModel:(id)model;

@end
