//
//  BaseEntity.h
//  FATodos
//
//  Created by fallen.ink on 9/23/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "MTLModel.h"

@interface BaseEntity : MTLModel <BaseEntityProtocol>

@string( SQL_TABLE_ELEMENT_NAME_ID )

@string( str_DateFormat )
@string( str_TimeFormat )

@property (nonatomic, assign) int64_t       id;
@property (nonatomic, copy) NSString *      name;
@property (nonatomic, strong) NSString *    date;
@property (nonatomic, strong) NSString *    time;

// todo：利用 + (const char *)attributesForProperty:(NSString *)property

#pragma mark - Template method

- (BOOL)isInit;
- (BOOL)isComplete;

@end

#pragma mark - BaseEntity ( Database )

#pragma mark - BaseEntity ( Utility )

@interface BaseEntity ( Utility )

- (NSDate *)dates; // Notice: 直接用复数形式，虽然不大好，但是方便。
- (void)setDates:(NSDate *)dates;

- (NSDate *)times;
- (void)setTimes:(NSDate *)times;

/**
 *  判断entity的生日
 */
- (BOOL)isBorn:(NSDate *)date;

@end