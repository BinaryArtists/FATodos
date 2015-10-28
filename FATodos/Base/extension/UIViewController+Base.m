//
//  UIViewController+Base.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)

- (id) _initWithNib {
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
