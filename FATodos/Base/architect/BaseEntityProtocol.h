//
//  BaseEntityProtocol.h
//  FATodos
//
//  Created by fallen.ink on 9/22/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseEntityProtocol <NSObject> // 组建式思维，而非多建几个XXXCache

// 表名字

// 建表必备


// 更新必备




@optional

/**
 *  1. 如果不存在，则insert
 *  2. 如果存在，则update
 
 *  default: update all properties
 
 *  todo: KVO ????? 每个property改变都需要update？
 */
- (void)update;

/**
 *  default: remove entity by 'id'
 */
- (void)remove;


/**
 *  清除同类型，所有记录
 
 *  default: delete the table
 */
- (void)purge;

@end
