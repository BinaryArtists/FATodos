//
//  DatabaseProxy.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "DatabaseProxy.h"
#import "FMDBManager.h"

@interface DatabaseProxy ()

@property (nonatomic, weak) id<AutoDatabaseProxyProtocol> delegate;

@end

@implementation DatabaseProxy

@def_singleton( DatabaseProxy )

#pragma mark - Initialize

+ (void)initialize {
    // 在代理中
    // 设置实际的处理对象
    [[DatabaseProxy sharedInstance] setDelegate:[FMDBManager sharedInstance]];
}

#pragma mark - AutoDatabaseProtocol

/////////////////////// db

- (BOOL)set:(Class)entityClass withDatabaseName:(NSString *)databaseName {
    return [self.delegate set:entityClass withDatabaseName:databaseName];
}

- (BOOL)set:(Class)entityClass withTableName:(NSString *)tableName {
    return [self.delegate set:entityClass withTableName:tableName];
}

- (BOOL)createTable:(Class)entityClass {
    return [self.delegate createTable:entityClass];
}

/////////////////////// 增

- (BOOL)saveOrUpdateEntity:(id)entity {
    return [self.delegate saveOrUpdateEntity:entity];
}

- (BOOL)saveEntity:(id)entity {
    return [self saveEntity:entity];
}

- (BOOL)saveEntities:(NSArray *)entities {
    return [self.delegate saveEntities:entities];
}

/////////////////////// 删

- (BOOL)deleteEntity:(id)entity {
    return [self.delegate deleteEntity:entity];
}

- (BOOL)deleteEntities:(NSArray *)entities {
    return [self.delegate deleteEntities:entities];
}

- (BOOL)deleteEntitiesByCriteria:(NSString *)criteria {
    return [self.delegate deleteEntitiesByCriteria:criteria];
}

- (BOOL)clearTable:(Class)entityClass {
    return [self.delegate clearTable:entityClass];
}

/////////////////////// 查

- (NSArray *)findAll:(Class)entityClass {
    return [self.delegate findAll:entityClass];
}

- (instancetype)findByPrimiryKey:(int)primiryKey {
    return [self.delegate findByPrimiryKey:primiryKey];
}

- (instancetype)findFirstByCriteria:(NSString *)criteria {
    return [self.delegate findFirstByCriteria:criteria];
}

- (NSArray *)findByCriteria:(NSString *)criteria {
    return [self.delegate findByCriteria:criteria];
}

@end
