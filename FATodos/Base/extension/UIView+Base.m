//
//  UIView+Base.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "UIView+Base.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation UIView (Base)

- (id) _initWithNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
}

@end

#pragma clang diagnostic pop