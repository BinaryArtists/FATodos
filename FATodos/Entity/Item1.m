//
//  Item1.m
//  FATodos
//
//  Created by fallen.ink on 9/8/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Item1.h"

@implementation Item1

#pragma mark - Property

- (void)setType:(int32_t)type {
    _type       = type;

    self.name   = [NSString forItemType:type];
}

- (void)setNum_1:(int32_t)num_1 {
    _num_1      = num_1;
    
    self.has_1  = YES;
    
    if (_num_1 <= 0) {
        self.has_1  = NO;
    }
}

- (void)setNum_2:(int32_t)num_2 {
    _num_2      = num_2;
    
    self.has_2  = YES;
    
    if (_num_2 <= 0) {
        self.has_2  = NO;
    }
}

- (void)setNum_3:(int32_t)num_3 {
    _num_3      = num_3;
    
    self.has_3  = YES;
    
    if (_num_3 <= 0) {
        self.has_3  = NO;
    }
}

@end

#pragma mark - Item1 ( Utility )

@implementation Item1 ( Utility )

- (BOOL)isInit {
    if (!self.date) {
        return NO;
    }
    
    return self.has_1 || self.has_2 || self.has_3 || self.name;
}

@end

