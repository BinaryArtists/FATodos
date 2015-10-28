//
//  DatabaseProxy.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AutoDatabaseProtocol;

@interface DatabaseProxy : NSObject <AutoDatabaseProtocol>

@singleton( DatabaseProxy )

@property (nonatomic, weak) id<AutoDatabaseProtocol> delegate;

#pragma mark -

@end
