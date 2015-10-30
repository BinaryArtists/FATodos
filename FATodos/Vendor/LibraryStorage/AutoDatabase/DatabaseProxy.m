//
//  DatabaseProxy.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "DatabaseProxy.h"
#import "FMDBManager.h"
#import "AutoDatabaseProtocol.h"

@interface DatabaseProxy () <AutoDatabaseProtocol>

@property (nonatomic, weak) id<AutoDatabaseProtocol> delegate;

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

- (BOOL)ad_setDatabaseName:(NSString *)databaseName {
    
    return [self.delegate ad_setDatabaseName:databaseName];
}

- (BOOL)ad_setTableName:(NSString *)tableName {
    
    return [self.delegate ad_setTableName:tableName];
}

- (BOOL)ad_createTable {
    
    return [self.delegate ad_createTable];
}

/////////////////////// 增

- (BOOL)ad_save {
    
    return [self.delegate ad_save];
}

- (BOOL)ad_saveObjects:(NSArray *)array {
    
    return [self.delegate ad_saveObjects:array];
}

/////////////////////// 删

- (BOOL)ad_deleteObject {
    
    return [self.delegate ad_deleteObject];
}

- (BOOL)ad_deleteObjects:(NSArray *)array {
    
    return [self.delegate ad_deleteObjects:array];
}

- (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria {
    
    return [self.delegate ad_deleteObjectsByCriteria:criteria];
}

- (BOOL)ad_clearTable {
    
    return [self.delegate ad_clearTable];
}

/////////////////////// 改

- (BOOL)ad_saveOrUpdate {
    
    return [self.delegate ad_saveOrUpdate];
}

/////////////////////// 查

- (NSArray *)ad_findAll {
    
    return [self.delegate ad_findAll];
}

- (instancetype)ad_findByMajorKey:(int)majorKey {
    
    return [self.delegate ad_findByMajorKey:majorKey];
}

- (instancetype)ad_findFirstByCriteria:(NSString *)criteria {
    
    return [self.delegate ad_findFirstByCriteria:criteria];
}

- (NSArray *)ad_findByCriteria:(NSString *)criteria {
    return [self ad_findByCriteria:criteria];
}

@end
