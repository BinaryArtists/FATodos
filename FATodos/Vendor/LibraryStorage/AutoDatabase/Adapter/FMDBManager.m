//
//  FMDBManager.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"
#import "DatabaseTable.h"
#import "DatabaseSentence.h"

@interface FMDBManager ()

@end

@implementation FMDBManager

@def_singleton( FMDBManager )

#pragma mark - AutoDatabaseProxyProtocol

#pragma mark - db

- (BOOL)set:(Class)entityClass withDatabaseName:(NSString *)databaseName {
    return YES;
}

- (BOOL)set:(Class)entityClass withTableName:(NSString *)tableName {
    return YES;
}

- (BOOL)createTable:(Class)entityClass {
    return YES;
}

#pragma mark - add

- (BOOL)saveEntity:(id)entity {
    return YES;
}

- (BOOL)saveOrUpdateEntity:(id)entity {
    return YES;
}

- (BOOL)saveEntities:(NSArray *)entities {
    return YES;
}

- (BOOL)clearTable:(Class)entityClass {
    return YES;
}

#pragma mark - delete

- (BOOL)deleteEntity:(id)entity {
    return YES;
}

- (BOOL)deleteEntities:(NSArray *)entities {
    return YES;
}

- (BOOL)deleteEntitiesByCriteria:(NSString *)criteria {
    return YES;
}

#pragma mark - query

- (NSArray *)findAll:(Class)entityClass {
    return nil;
}

- (instancetype)findByPrimiryKey:(int)primiryKey {
    return nil;
}

- (instancetype)findFirstByCriteria:(NSString *)criteria {
    return nil;
}

- (NSArray *)findByCriteria:(NSString *)criteria {
    return nil;
}

@end
