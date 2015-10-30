//
//  NSObject+LS_Extension.m
//  FATodos
//
//  Created by fallen.ink on 10/29/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "NSObject+LS_Extension.h"

@implementation NSObject (LS_Extension)

// types
+ (NSArray *)typesForProperties:(NSArray *)properties {
    NSAssert(properties, @"");
    
    NSMutableArray *types   = [NSMutableArray new];
    
    [properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        const char *cstrAttribute = [self attributesForProperty:obj]; // cstr: string type of 'C'
        
        [types addObject:@(cstrAttribute)];
    }];
    
    return types;
}

+ (NSArray *)types {
    return [self typesForProperties:[self properties]];
}

+ (NSArray *)typesUntilClass:(Class)baseClass {
    return [self typesForProperties:[self propertiesUntilClass:baseClass]];
}

// shorttypes
+ (NSArray *)shorttypesForProperties:(NSArray *)properties {
    NSAssert(properties, @"");
    
    NSMutableArray *shorttypes   = [NSMutableArray new];
    
    [properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        const char *cstrAttribute   = [self attributesForProperty:obj]; // cstr: string type of 'C'
        NSString *attribute         = @(cstrAttribute);
        NSArray *attributeSegments  = [attribute split:@","];
        
        [shorttypes addObject:[attributeSegments firstObject]];
    }];
    
    return shorttypes;
}

+ (NSArray *)shorttypes {
    return [self shorttypesForProperties:[self properties]];
}

+ (NSArray *)shorttypesUntilClass:(Class)baseClass {
    return [self shorttypesForProperties:[self propertiesUntilClass:baseClass]];
}

@end
