//
//  NSObject+AutoDatabase.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "NSObject+AutoDatabase.h"

#import "DatabaseProxy.h"

@implementation NSObject (AutoDatabase)

#pragma mark - support

+ (BOOL)ad_enabled {
    return NO;
}

+ (NSArray *)transientField {
    return nil;
}

+ (Class)transientClass {
    return [NSObject class];
}

#pragma mark - add


#pragma mark - delete


#pragma mark - query

@end
