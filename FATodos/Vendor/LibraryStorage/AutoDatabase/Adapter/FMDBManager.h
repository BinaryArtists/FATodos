//
//  FMDBManager.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AutoDatabaseProtocol.h"

@interface FMDBManager : NSObject <AutoDatabaseProxyProtocol>

@singleton( FMDBManager )

// db
- (BOOL)setEntity:(id)entity withDatabaseName:(NSString *)databaseName;
- (BOOL)setEntity:(id)entity withTableName:(NSString *)tableName;
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
