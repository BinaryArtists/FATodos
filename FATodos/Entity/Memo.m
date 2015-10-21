//
//  Memo.m
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Memo.h"

@implementation Memo

@end

#pragma mark - Item1 ( Utility )

@implementation Memo ( Utility )

- (NSDate *)dates {
    return [NSDate dateWithString:self.date
                     formatString:self.str_DateFormat];
}

- (void)setDates:(NSDate *)dates {
    self.date   = [dates formattedDateWithFormat:self.str_DateFormat];
}

@end
