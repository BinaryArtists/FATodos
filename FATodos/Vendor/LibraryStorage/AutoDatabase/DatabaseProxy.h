//
//  DatabaseProxy.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AutoDatabaseProtocol.h"

/**
 *  这一层，会额外创建一些表，存储用户的自定制信息
 */

@interface DatabaseProxy : NSObject

@singleton( DatabaseProxy )

#pragma mark -

@end
