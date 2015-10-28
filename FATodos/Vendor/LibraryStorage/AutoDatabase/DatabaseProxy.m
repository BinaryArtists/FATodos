//
//  DatabaseProxy.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "DatabaseProxy.h"
#import "AutoDatabaseProtocol.h"

@implementation DatabaseProxy

@def_singleton( DatabaseProxy )

#pragma mark - AutoDatabaseProtocol

///////////////////////

+ (BOOL)ad_setDatabaseName:(NSString *)databaseName {
    
    return YES;
}

+ (BOOL)ad_createTable {
    return YES;
}

/////////////////////// 增



@end
