//
//  NSObject+LS_Entity.h
//  FATodos
//
//  Created by fallen.ink on 10/30/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  为LibraryStorage的实体，提供必要的属性
 */

@interface NSObject (LS_Entity)

/**
 *  主键 id
 */
@property (nonatomic, assign) int         primiryKey;

/** 
 *  列名
 */
@property (nonatomic, strong) NSArray *      columeNames;

/**
 *  列objc类型
 */
@property (nonatomic, strong) NSArray *      columeObjctypes;

/**
 *  列sql类型
 */
@property (nonatomic, strong) NSArray *      columeSqltypes;

@end
