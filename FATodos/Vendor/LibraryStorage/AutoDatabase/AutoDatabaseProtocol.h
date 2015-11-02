//
//  AutoDatabaseProtocol.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

/**
 *  Entity's interface protocol
 
 *  ST  single thread 单线程，同步
 */

@protocol AutoDatabaseProtocol <NSObject>

/**
 *  是否启用支持AutoDatabase
 */
@required
+ (BOOL)ad_enabled;

#pragma mark - 数据库文件操作

/** 
 *  设置数据库文件名，默认：在一起 ad.stroage.sqlite
 */
@required
+ (BOOL)ad_setDatabaseName:(NSString *)databaseName;

/**
 * 设置数据表名称，默认：string from class
 */
+ (BOOL)ad_setTableName:(NSString *)tableName;

/**
 *  创建表
 *  如果已经创建，返回YES
 */
+ (BOOL)ad_createTable;

#pragma mark - 通过实体，对数据库操作

/**
 *  保存 或 更新
 
 *  如果不存在主键，保存
 *  如果存在，更新
 */
- (BOOL)ad_saveOrUpdate;

/**
 *  保存单个数据
 */
- (BOOL)ad_save;

/**
 *  批量保存数据
 */
+ (BOOL)ad_saveObjects:(NSArray *)array;

/**
 *  删除单个数据
 */
- (BOOL)ad_deleteObject;

/**
 *  批量删除数据
 */
+ (BOOL)ad_deleteObjects:(NSArray *)array;

/**
 *  通过条件删除数据
 
 *  fixme: 换做使用谓词
 */
+ (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria;

/**
 *  清空表
 */
+ (BOOL)ad_clearTable;

/**
 *  查询所有数据
 */
+ (NSArray *)ad_findAll;

/**
 *  通过主键查询
 */
+ (instancetype)ad_findByMajorKey:(int)majorKey;

/**
 *  查询某条数据
 
 *  fixme: 换做使用谓词
 */
+ (instancetype)ad_findFirstByCriteria:(NSString *)criteria;

/** 
 *  通过条件查找数据
 *  这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 
 *  fixme: 换做使用谓词
 */
+ (NSArray *)ad_findByCriteria:(NSString *)criteria;

@optional

#pragma mark - must be override method

/**
 *  如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 
 *  穿透的字段
 */
+ (NSArray *)transientField;

/**
 *  穿透的类
 */
+ (Class)transientClass;

@end

/**
 *  MT  multi thread 多线程，异步
 */

@protocol AutoDatabaseMTProtocol <NSObject>

//
+ (void)ad_createTableWithCompletion:(void (^)(BOOL succeed))handler;

//
- (BOOL)ad_saveOrUpdateWithCompletion:(void (^)(BOOL succeed))handler;

- (BOOL)ad_saveWithComletion:(void (^)(BOOL succeed))handler;

+ (BOOL)ad_saveObjects:(NSArray *)array withCompletion:(void (^)(BOOL succeed))handler;

//
- (BOOL)ad_deleteObjectWithCompletion:(void (^)(BOOL succeed))handler;
+ (BOOL)ad_deleteObjects:(NSArray *)array withCompletion:(void (^)(BOOL succeed))handler;
+ (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria withCompletion:(void (^)(BOOL succeed))handler;

//
+ (void)ad_findAllWithCompletion:(void (^)(BOOL succeed, NSArray *objects))handler;

/**
 *  通过主键查询
 */
+ (void)ad_findByMajorKey:(int)majorKey withCompletion:(void (^)(BOOL succeed, id object))handler;

/**
 *  查询某条数据
 
 *  fixme: 换做使用谓词
 */
+ (void)ad_findFirstByCriteria:(NSString *)criteria withCompletion:(void (^)(BOOL succeed, id object))handler;

/**
 *  通过条件查找数据
 *  这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 
 *  fixme: 换做使用谓词
 */
+ (void)ad_findByCriteria:(NSString *)criteria withCompletion:(void (^)(BOOL succeed, NSArray *object))handler;

@end

/**
 *  Proxy Protocol of auto-entity's implementaion
 */
@protocol AutoDatabaseProxyProtocol <NSObject>

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

@protocol AutoDatabaseProxyMTProtocol <NSObject>



@end
