//
//  IflyComponent.h
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Samurai_Package.h"

@interface IflyComponent : SamuraiComponent

@singleton( IflyComponent )

#pragma mark - setup

+ (void)powerOn;

+ (void)powerOff;

#pragma mark - 

- (void)process:(id)data;

@end
