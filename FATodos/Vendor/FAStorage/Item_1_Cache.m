//
//  Item_1_Cache.m
//  FATodos
//
//  Created by fallen.ink on 9/24/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "CacheProtocol.h"
#import "Item_1_Cache.h"
#import "Item1.h"

@interface Item_1_Cache ()

@string( SQL_TABLE_NAME_ITEM1 )
@string( SQL_TABLE_ELEMENT_NAME_TYPE )
@string( SQL_TABLE_ELEMENT_NAME_NUM1 )
@string( SQL_TABLE_ELEMENT_NAME_NUM2 )
@string( SQL_TABLE_ELEMENT_NAME_NUM3 )

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@property (nonatomic, strong) NSMutableArray *item1Array;

@end

@implementation Item_1_Cache

@def_string( SQL_TABLE_NAME_ITEM1, @"table.item1" )
@def_string( SQL_TABLE_ELEMENT_NAME_TYPE, @"table.element.type" )
@def_string( SQL_TABLE_ELEMENT_NAME_NUM1, @"table.element.num1" )
@def_string( SQL_TABLE_ELEMENT_NAME_NUM2, @"table.element.num2" )
@def_string( SQL_TABLE_ELEMENT_NAME_NUM3, @"table.element.num3" )

@def_singleton( Item_1_Cache )

#pragma mark - Initialize

- (instancetype)init {
    if (self = [super init]) {
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        if ([fileManager fileExistsAtPath:[self.class dbPath]]) { // db do exist
//            
//            (void)[self dbQueue];
//            
//        } else
        {
            
            [self.dbQueue inDatabase:^(FMDatabase *db) {
                // create item1 table
                
                NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                                 @"id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                 @"type INTEGER,"
                                 @"num_1 INTEGER,"
                                 @"num_2 INTEGER,"
                                 @"num_3 INTEGER"
                                 @")",
                                 [self SQL_TABLE_NAME_ITEM1]];
                
                BOOL res = [db executeUpdate:sql];
                if (res) {
                    NSLog(@"db[%@] create table[%@] success.", [self.class dbPath], [self SQL_TABLE_NAME_ITEM1]);
                } else {
                    NSLog(@"db[%@] create table[%@] failed.", [self.class dbPath], [self SQL_TABLE_NAME_ITEM1]);
                }

            }];
        }
        
        // construct message list
        [self initSysMessageList];
    }
    
    return self;
}

#pragma mark - Basic

+ (NSString *)dbPath {
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [doc stringByAppendingPathComponent:@"item_1_cache.sqlite"];
    
    return path;
}

#pragma mark - CacheProtocol

- (void)addObject:(id)obj withCompletionBlock:(void (^)(BOOL isSucceed, id inserted))completionHandler {
    Item1 *item = obj;
    
    NSAssert(completionHandler, @"- (void)addObject:(id)obj withCompletionBlock:(void (^)(BOOL))completionHandler");
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql   = [NSString stringWithFormat:@"INSERT INTO %@ ("
                           @"type,"
                           @"num_1,"
                           @"num_2,"
                           @"num_3"
                           @") values (?, ?, ?)", [self SQL_TABLE_NAME_ITEM1]];
        BOOL ret        = [db executeUpdate:sql, @(item.type), @(item.num_1), @(item.num_2), @(item.num_3)];
        
        if (ret) {
            // todo: 需要优化
            // select
            sql         = [NSString stringWithFormat:@"SELECT * FROM SQLITE_SEQUENCE WHERE name=%@", [self SQL_TABLE_NAME_ITEM1]];
            FMResultSet *ret = [db executeQuery:sql];
            item.id     = [ret intForColumnIndex:0];
            
            [self.item1Array addObject:item];
        }
        
        completionHandler(ret, item);
    }];
}

- (void)updateObject:(id)obj {
    Item1 *item = obj;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql   = [NSString stringWithFormat:@"UPDATE %@ SET "
                           @"type=? "
                           @"num_1=? "
                           @"num_2=? "
                           @"num_3=? "
                           @"WHERE %@=?", [self SQL_TABLE_NAME_ITEM1], [BaseEntity SQL_TABLE_ELEMENT_NAME_ID]];
        BOOL ret        = [db executeUpdate:sql, @(item.type), @(item.num_1), @(item.num_2), @(item.num_3)];
        
        if (!ret) {
            NSLog(@"- (void)removeObjectById:(int64_t)id_");
        }
        
//        completionHandler(ret);
    }];
}

- (void)allObjectsUsingBlock:(void (^)(NSArray *))handler {
    
    NSAssert(handler, @"- (void)allObjectsUsingBlock:(void (^)(NSArray *))handler");
    
    if (!self.item1Array) {
        [self initSysMessageListWithCompletionBlock:^{
            handler(self.item1Array);
        }];
    } else {
        [[GCDQueue mainQueue] queueBlock:^{
            handler(self.item1Array);
        }];
    }
}

- (void)removeObjectById:(int64_t)id_ {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql   = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@=?", [self SQL_TABLE_NAME_ITEM1], [BaseEntity SQL_TABLE_ELEMENT_NAME_ID]];
        BOOL ret        = [db executeUpdate:sql, @(id_)];
        
        if (!ret) {
            NSLog(@"- (void)removeObjectById:(int64_t)id_");
        }
    }];
}

- (void)removeAllObjects {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql   = [NSString stringWithFormat:@"DELETE FROM %@", [self SQL_TABLE_NAME_ITEM1]];
        BOOL ret        = [db executeUpdate:sql];
        
        if (!ret) {
            NSLog(@"- (void)removeObjectById:(int64_t)id_");
        }
        
        // 自增清零
        sql             = [NSString stringWithFormat:@"UPDATE SQLITE_SEQUENCE SET seq=0 WHERE name='%@'", [self SQL_TABLE_NAME_ITEM1]];
        ret             = [db executeUpdate:sql];
        
        if (!ret) {
            NSLog(@"- (void)removeObjecdddtById:(int64_t)id_");
        }
    }];
}

#pragma mark - Private method

- (void)initSysMessageList {
    [self initSysMessageListWithCompletionBlock:nil];
}

- (void)initSysMessageListWithCompletionBlock:(void (^) ())completionHandler {
    if (!self.item1Array) {
        self.item1Array = [[NSMutableArray alloc] init];
    } else {
        [self.item1Array removeAllObjects];
    }
    
    // 按用户筛选
    //    long long userid = [[Cache sharedCache] userID];
    
    // Get all
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs     = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", [self SQL_TABLE_NAME_ITEM1]]];
        
        while ([rs next]) {
            Item1 *item     = [Item1 new];
            
            item.type       = [rs intForColumn:[self SQL_TABLE_ELEMENT_NAME_TYPE]];
            item.num_1      = [rs intForColumn:[self SQL_TABLE_ELEMENT_NAME_NUM1]];
            item.num_2      = [rs intForColumn:[self SQL_TABLE_ELEMENT_NAME_NUM2]];
            item.num_3      = [rs intForColumn:[self SQL_TABLE_ELEMENT_NAME_NUM3]];
            
            [self.item1Array addObject:item];
        }
        
        if (completionHandler) {
            completionHandler();
        }
    }];
}

- (FMDatabaseQueue *)dbQueue {
    if (!_dbQueue) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self.class dbPath]];
    }
    
    return _dbQueue;
}


@end
