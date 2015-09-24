//
//  Item_1_Cache.h
//  FATodos
//
//  Created by fallen.ink on 9/24/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CacheProtocol;

@interface Item_1_Cache : NSObject <CacheProtocol>

@singleton( Item_1_Cache )

@end
