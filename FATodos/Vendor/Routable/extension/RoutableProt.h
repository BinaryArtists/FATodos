//
//  RoutableProt.h
//  FATodos
//
//  Created by fallen.ink on 9/6/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RoutableProt <NSObject>

@required
- (id)initWithRouterParams:(NSDictionary *)params;

@end
