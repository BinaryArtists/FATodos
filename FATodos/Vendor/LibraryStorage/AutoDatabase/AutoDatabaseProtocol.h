//
//  AutoDatabaseProtocol.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

//  @required 可以放心使用
//  @optional 需要看准使用的前置条件

/**
 *  ST  single thread 单线程，阻塞型的
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
- (BOOL)ad_setDatabaseName:(NSString *)databaseName;

/**
 * 设置数据表名称，默认：string from class
 */
- (BOOL)ad_setTableName:(NSString *)tableName;

/**
 *  创建表
 *  如果已经创建，返回YES
 */
- (BOOL)ad_createTable;

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
- (BOOL)ad_saveObjects:(NSArray *)array;

/**
 *  删除单个数据
 */
- (BOOL)ad_deleteObject;

/**
 *  批量删除数据
 */
- (BOOL)ad_deleteObjects:(NSArray *)array;

/**
 *  通过条件删除数据
 
 *  fixme: 换做使用谓词
 */
- (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria;

/**
 *  清空表
 */
- (BOOL)ad_clearTable;

/**
 *  查询所有数据
 */
- (NSArray *)ad_findAll;

/**
 *  通过主键查询
 */
- (instancetype)ad_findByMajorKey:(int)majorKey;

/**
 *  查询某条数据
 
 *  fixme: 换做使用谓词
 */
- (instancetype)ad_findFirstByCriteria:(NSString *)criteria;

/** 
 *  通过条件查找数据
 *  这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 
 *  fixme: 换做使用谓词
 */
- (NSArray *)ad_findByCriteria:(NSString *)criteria;

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

+ (BOOL)ad_setDatabaseName:(NSString *)databaseName;
+ (BOOL)ad_createTable;

+ (BOOL)ad_saveObjects:(NSArray *)array;

+ (BOOL)ad_deleteObjects:(NSArray *)array;
+ (BOOL)ad_deleteObjectsByCriteria:(NSString *)criteria;
+ (BOOL)ad_clearTable;

+ (NSArray *)ad_findAll;
+ (instancetype)ad_findByMajorKey:(int)majorKey;
+ (instancetype)ad_findFirstByCriteria:(NSString *)criteria;
+ (NSArray *)ad_findByCriteria:(NSString *)criteria;

@end

/**
 *  MT  multi thread 多线程，异步
 */

@protocol AutoDatabaseMTProtocol <NSObject>



@end

