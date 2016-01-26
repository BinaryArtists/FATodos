//
//  DatabaseTable.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

//  三层
//  runtime     － 实体的属性、属性的类型（property）
//  dictionary？？？这里再加入包装层？统统转为字符串类型？？？？如果约定，实体的属性类型都是字串，实现会比较简单。
//  database    － 实体的表，字段，值（table），，，，，这层同样是容器层，数据表／json／xml不同种类的
//  operation   － 实体的操作（sentence）

#import "DatabaseTable.h"
#import "Samurai_Property.h"
#import "NSObject+LS_Extension.h"

/**
 *  SQLite将数据值的存储划分为以下几种存储类型：
 */
#define SQLITE_TYPENAME_TEXT     @"TEXT"             // 文本字符串，存储使用的编码方式为UTF-8、UTF-16BE、UTF-16LE。
#define SQLITE_TYPENAME_INTEGER  @"INTEGER"          // 无符号整型值。
#define SQLITE_TYPENAME_REAL     @"REAL"             // 浮点值。
#define SQLITE_TYPENAME_BLOB     @"BLOB"             // 存储Blob数据，该类型数据和输入数据完全相同。
#define SQLITE_TYPENAME_NULL     @"NULL"             // 表示该值为NULL值。

//
#define PrimaryKey  @"primary key"

@interface DatabaseTable ()

@string( text )
@string( integer )
@string( real )
@string( blob )
@string( null )
@string( not_supported )

/**
 *  @param  objctypes   could be types: or shorttypes:
 */
+ (NSArray *)sqlitetypesForObjctypes:(NSArray *)objctypes;

@end

@implementation DatabaseTable

@def_string( text,      SQLITE_TYPENAME_TEXT )
@def_string( integer,   SQLITE_TYPENAME_INTEGER )
@def_string( real,      SQLITE_TYPENAME_REAL )
@def_string( blob,      SQLITE_TYPENAME_BLOB )
@def_string( null,      SQLITE_TYPENAME_NULL )
@def_string( not_supported, @"not supported" )

+ (void)initialize {
 
}

#pragma mark - 



#pragma mark - objc type => sqlite type

+ (NSArray *)sqlitetypesForObjctypes:(NSArray *)objctypes {
    NSMutableArray *sqlitetypes = [@[] mutableCopy];
    
    [objctypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isObjctypeSuppported = NO;
        NSString *sqlitetype    = [self sqlitetypeForObjctype:obj supported:&isObjctypeSuppported];
        if (isObjctypeSuppported) {
            [sqlitetypes addObject:sqlitetype];
        }
    }];
    
    return sqlitetypes;
}

/**
 *  不支持的类型，返回 not_supported
 */
+ (NSString *)sqlitetypeForObjctype:(NSString *)objctype supported:(BOOL *)supportedPtr{
    NSString *sqlitetype;
    
    *supportedPtr = YES;
    
#undef  is_type
#define is_type( __type ) [str_of_type(__type) contains:objctype]
    
    NSAssert(! is_type(void)/** 'v' */, nil);
//    _assert_(! is_type(char *)/** '*' */);
    NSAssert(! is_type(Class)/** '#' */, nil);
    NSAssert(! is_type(SEL)/** ':' */, nil);
    
    if (is_type(char)               ||              // char
        is_type(int)                ||              // int int32_t
        is_type(short)              ||              // short int16_t
        is_type(long)               ||              // long
        is_type(long long)          ||              // long long int64_t
        is_type(unsigned char)      ||
        is_type(unsigned int)       ||
        is_type(unsigned short)     ||
        is_type(unsigned long)      ||
        is_type(unsigned long long) ||
        is_type(BOOL)
        ) {
        return [self integer];
    } else if (is_type(float)       ||
               is_type(double)) {
        return [self real];
    } else if (is_type(unsigned char *)     ||
               is_type(char *)) {
        return [self text];
    } else if (is_type(NSString *)) {
        return [self text];
    } else {
        *supportedPtr   = NO;
        sqlitetype      = [self not_supported];
        
        // should be logged.
        loge(@"type (%@) not supported!", objctype);
    }
    
    return sqlitetype;
}

#pragma mark -

@end
