//
//  NSObject+AutoDatabase.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "NSObject+AutoDatabase.h"

#import "DatabaseProxy.h"

@implementation NSObject (AutoDatabase)

#pragma mark - support

+ (BOOL)ad_enabled {
    return NO;
}

+ (NSArray *)transientField {
    return nil;
}

+ (Class)transientClass {
    return [NSObject class];
}

#pragma mark - db

- (BOOL)ad_setDatabaseName:(NSString *)databaseName {
    return [self.class ad_setDatabaseName:databaseName];
}

- (BOOL)ad_setTableName:(NSString *)tableName {
    return YES;
}

- (BOOL)ad_createTable {
    return [self.class ad_createTable];
}

+ (BOOL)ad_setDatabaseName:(NSString *)databaseName {
    return YES;
}

+ (BOOL)ad_createTable {
    return YES;
}

#pragma mark - add

- (BOOL)ad_saveOrUpdate {
    return YES;
}

- (BOOL)ad_save {
    return YES;
}

- (BOOL)ad_saveObjects:(NSArray *)array {
    return [self.class ad_saveObjects:array];
}

+ (BOOL)ad_saveObjects:(NSArray *)array {
    return YES;
}

#pragma mark - delete

- (BOOL)ad_deleteObject {
    return YES;
}

- (BOOL)ad_deleteObjects:(NSArray *)array {
    return [self.class ad_deleteObjects:array];
}

- (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria {
    return [self.class ad_deleteObjectsByCriteria:criteria];
}

- (BOOL)ad_clearTable {
    return [self.class ad_clearTable];
}

+ (BOOL)ad_deleteObjects:(NSArray *)array {
    return YES;
}

+ (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria {
    return YES;
}

+ (BOOL)ad_clearTable {
    return YES;
}

#pragma mark - query

- (NSArray *)ad_findAll {
    return [self.class ad_findAll];
}

- (instancetype)ad_findByMajorKey:(int)majorKey {
    return [self.class ad_findByMajorKey:majorKey];
}

- (instancetype)ad_findFirstByCriteria:(NSString *)criteria {
    return [self.class ad_findFirstByCriteria:criteria];
}

- (NSArray *)ad_findByCriteria:(NSString *)criteria {
    return [self.class ad_findByCriteria:criteria];
}

+ (NSArray *)ad_findAll {
    return nil;
}

+ (instancetype)ad_findByMajorKey:(int)majorKey {
    return nil;
}

+ (instancetype)ad_findFirstByCriteria:(NSString *)criteria {
    return nil;
}

+ (NSArray *)ad_findByCriteria:(NSString *)criteria {
    return nil;
}

@end
