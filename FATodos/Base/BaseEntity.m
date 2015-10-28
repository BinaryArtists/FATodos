//
//  BaseEntity.m
//  FATodos
//
//  Created by fallen.ink on 9/23/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

@def_string( SQL_TABLE_ELEMENT_NAME_ID, @"id" )

@def_string( str_DateFormat, @"yyyy-MM-dd" )
@def_string( str_TimeFormat, @"yyyy-MM-dd HH-mm-ss" )

#pragma mark - Initialize

- (instancetype)init {
    if (self = [super init]) {
        [self setDates:[NSDate new]];
        [self setTimes:[NSDate new]];
    }
    
    return self;
}

#pragma mark - BaseEntityProtocol

- (void)update {
    
}

- (void)remove {
    
}

- (void)purge {
    
}

#pragma mark - Template method

- (BOOL)isInit {
    return YES;
}

- (BOOL)isComplete {
    return YES;
}

@end

#pragma mark - BaseEntity ( Database )

#pragma mark - BaseEntity ( Utility )

@implementation BaseEntity ( Utility )

- (NSDate *)dates {
    return [NSDate dateWithString:self.date
                     formatString:self.str_DateFormat];
}

- (void)setDates:(NSDate *)dates {
    self.date   = [dates formattedDateWithFormat:self.str_DateFormat];
}

- (NSDate *)times {
    return [NSDate dateWithString:self.time
                     formatString:self.str_TimeFormat];
}

- (void)setTimes:(NSDate *)times {
    self.time   = [times formattedDateWithFormat:self.str_TimeFormat];
}

- (BOOL)isBorn:(NSDate *)date {
    return [[self dates] isSameDay:date];
}

@end

