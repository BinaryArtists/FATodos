//
//  NSDictionary+Params.m
//  FATodos
//
//  Created by 李杰 on 9/10/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "NSDictionary+Params.h"

@implementation NSDictionary (Params)

@def_string( TYPE, @"route.type" )

#pragma mark -

- (NSObject *)objectForType {
    return [self objectForKey:[self TYPE]];
}

@end


@implementation NSMutableDictionary (Params)

- (void)typeEncode:(NSObject *)object {
    NSAssert(object, nil);
    
    [self setObject:object forKey:[self TYPE]];
}

@end