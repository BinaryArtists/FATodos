//
//  Samurai_Package.m
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Samurai_Package.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation NSObject(AutoLoading)

+ (BOOL)autoLoad
{
    return YES;
}

@end

#pragma mark - 

SamuraiComponent *component = nil;

#pragma mark -

@implementation SamuraiComponent

@def_singleton( SamuraiComponent )

- (instancetype)init {
    if (self = [super init]) {
        component = self;
    }
    
    return self;
}

+ (void)powerOn {
    
}

+ (void)powerOff {
    
}

#pragma mark -

+ (void)load {
    [SamuraiComponent sharedInstance];
}

@end
