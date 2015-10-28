//
//  DatabaseTable.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - DatabaseTable

@interface DatabaseTable : NSObject

@end

#pragma mark -

@interface NSObject ( DatabaseTable )

// 表的名字
+ (NSString *)tableName;
- (NSString *)tableName;

//

@end