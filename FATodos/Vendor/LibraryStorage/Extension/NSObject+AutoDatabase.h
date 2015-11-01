//
//  NSObject+AutoDatabase.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AutoDatabaseProtocol.h"

// 占用当前线程

@interface NSObject (AutoDatabase) <AutoDatabaseProtocol>

// support
+ (BOOL)ad_enabled;
+ (NSArray *)transientField;
+ (Class)transientClass;

// db
- (BOOL)ad_setDatabaseName:(NSString *)databaseName;
- (BOOL)ad_setTableName:(NSString *)tableName;
- (BOOL)ad_createTable;

+ (BOOL)ad_setDatabaseName:(NSString *)databaseName;
+ (BOOL)ad_createTable;

// add
- (BOOL)ad_saveOrUpdate;
- (BOOL)ad_save;
- (BOOL)ad_saveObjects:(NSArray *)array;

+ (BOOL)ad_saveObjects:(NSArray *)array;

// delete
- (BOOL)ad_deleteObject;
- (BOOL)ad_deleteObjects:(NSArray *)array;
- (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria;
- (BOOL)ad_clearTable;

+ (BOOL)ad_deleteObjects:(NSArray *)array;
+ (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria;
+ (BOOL)ad_clearTable;

// query
- (NSArray *)ad_findAll;
- (instancetype)ad_findByMajorKey:(int)majorKey;
- (instancetype)ad_findFirstByCriteria:(NSString *)criteria;
- (NSArray *)ad_findByCriteria:(NSString *)criteria;

+ (NSArray *)ad_findAll;
+ (instancetype)ad_findByMajorKey:(int)majorKey;
+ (instancetype)ad_findFirstByCriteria:(NSString *)criteria;
+ (NSArray *)ad_findByCriteria:(NSString *)criteria;

@end

// 线程分发，回调在主线程

@interface NSObject ( AutoDatabaseMT ) <AutoDatabaseMTProtocol>

// add


// delete


// query



@end
