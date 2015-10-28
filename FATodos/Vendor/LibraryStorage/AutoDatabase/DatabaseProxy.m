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
    
    return YES;
}

- (BOOL)ad_createTable {
    return YES;
}

/////////////////////// 增

- (BOOL)ad_save {
    return YES;
}

- (BOOL)ad_saveObjects:(NSArray *)array {
    return YES;
}

/////////////////////// 删

- (BOOL)ad_deleteObject {
    return YES;
}

- (BOOL)ad_deleteObjects:(NSArray *)array {
    return YES;
}

- (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria {
    return YES;
}

- (BOOL)ad_clearTable {
    return YES;
}

/////////////////////// 改

- (BOOL)ad_saveOrUpdate {
    return YES;
}

/////////////////////// 查

- (NSArray *)ad_findAll {
    return nil;
}

- (instancetype)ad_findByMajorKey:(int)majorKey {
    return nil;
}

- (instancetype)ad_findFirstByCriteria:(NSString *)criteria {
    return nil;
}

- (NSArray *)ad_findByCriteria:(NSString *)criteria {
    return nil;
}

@end
