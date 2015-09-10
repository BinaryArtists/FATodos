//
//  NSDictionary+Params.h
//  FATodos
//
//  Created by 李杰 on 9/10/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Params)

@string( TYPE )

// =========================
// demux
// =========================

/**
 *
 */
- (NSObject *)objectForType;

@end


@interface NSMutableDictionary (Params)

// =========================
// mux
// =========================

- (void)typeEncode:(NSObject *)object;

@end