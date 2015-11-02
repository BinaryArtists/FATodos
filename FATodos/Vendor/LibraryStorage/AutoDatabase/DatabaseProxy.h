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

@interface DatabaseProxy : NSObject <AutoDatabaseProxyProtocol>

@singleton( DatabaseProxy )

// db
- (BOOL)set:(Class)entityClass withDatabaseName:(NSString *)databaseName;
- (BOOL)set:(Class)entityClass withTableName:(NSString *)tableName;
- (BOOL)createTable:(Class)entityClass;

// add
- (BOOL)saveOrUpdateEntity:(id)entity;
- (BOOL)saveEntity:(id)entity;
- (BOOL)saveEntities:(NSArray *)entities;

// delete
- (BOOL)deleteEntity:(id)entity;
- (BOOL)deleteEntities:(NSArray *)entities;
- (BOOL)deleteEntitiesByCriteria:(NSString *)criteria;
- (BOOL)clearTable:(Class)entityClass;

// query
- (NSArray *)findAll:(Class)entityClass;
- (instancetype)findByPrimiryKey:(int)primiryKey;
- (instancetype)findFirstByCriteria:(NSString *)criteria;
- (NSArray *)findByCriteria:(NSString *)criteria;


@end
