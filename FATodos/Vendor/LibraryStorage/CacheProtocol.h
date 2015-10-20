//
//  CacheProtocol.h
//  FATodos
//
//  Created by fallen.ink on 9/24/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// Obj-C语言开发iOS项目使用反射减少代码工作:http://www.cr173.com/html/18677_1.html

@protocol CacheProtocol <NSObject>

@required

/**
 * 该接口需要检查条目是否存在，如果存在则更新它
 */
- (void)addObject:(id)obj withCompletionBlock:(void (^)(BOOL isSucceed, id inserted))completionHandler;

- (void)updateObject:(id)obj;

- (void)removeAllObjects;

- (void)allObjectsUsingBlock:(void (^) (NSArray *allobjects))handler;

- (void)removeObjectById:(int64_t)id_;

@optional

- (BOOL)isEmpty;

- (BOOL)hasObjectForId:(id)id_;
- (id)objectForId:(id)id_;
- (NSString *)nameForId:(NSNumber *)id_ default:(NSString *)num;

- (NSMutableArray *)getObjects;

// query ranges

- (NSArray *)objectsWithRange:(NSRange)range; // 由缓存来决定 输出多少。

typedef void (^AsyncQueryCompletionHandler)(NSRange token, NSArray *objs);
- (BOOL)asyncObjectsWithRange:(NSRange)lastToken
              completionBlock:(AsyncQueryCompletionHandler)completion;

// db operation

+ (NSString *)dbPath;

- (void)createTable;

@end
