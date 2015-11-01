//
//  NSObject+LS_Entity.m
//  FATodos
//
//  Created by fallen.ink on 10/30/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <objc/runtime.h>

#import "NSObject+LS_Entity.h"
#import "NSObject+AutoDatabase.h"

@implementation NSObject (LS_Entity)

#pragma mark - Property

//  primiryKey
- (int)primiryKey {
    NSNumber *number = objc_getAssociatedObject(self, @selector(primiryKey));
    
    return [number intValue];
}

- (void)setPrimiryKey:(int)primiryKey {
    objc_setAssociatedObject(self, @selector(primiryKey), @(primiryKey), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//  columeNames
- (NSArray *)columeNames {
    return objc_getAssociatedObject(self, @selector(columeNames));
}

- (void)setColumeNames:(NSArray *)columeNames {
    objc_setAssociatedObject(self, @selector(columeNames), columeNames, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//  columeObjctypes
- (NSArray *)columeObjctypes {
    return objc_getAssociatedObject(self, @selector(columeObjctypes));
}

- (void)setColumeObjctypes:(NSArray *)columeObjctypes {
    objc_setAssociatedObject(self, @selector(columeObjctypes), columeObjctypes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//  columeSqltypes
- (NSArray *)columeSqltypes {
    return objc_getAssociatedObject(self, @selector(columeSqltypes));
}

- (void)setColumeSqltypes:(NSArray *)columeSqltypes {
    objc_setAssociatedObject(self, @selector(columeSqltypes), columeSqltypes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
