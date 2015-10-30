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

#undef  SN
#define SN  @"name"

#undef  ST
#define ST  @"type"

/**
 *  SQLite将数据值的存储划分为以下几种存储类型：
 */
#define SQLite_TEXT     @"TEXT"             // 文本字符串，存储使用的编码方式为UTF-8、UTF-16BE、UTF-16LE。
#define SQLite_INTEGER  @"INTEGER"          // 无符号整型值。
#define SQLite_REAL     @"REAL"             // 浮点值。
#define SQLite_BLOB     @"BLOB"             // 存储Blob数据，该类型数据和输入数据完全相同。
#define SQLite_NULL     @"NULL"             // 表示该值为NULL值。

//
#define PrimaryKey  @"primary key"

@interface DatabaseTable ()

/**
 *  @param  objctypes   could be types: or shorttypes:
 */
+ (NSArray *)sqlitetypesForObjctypes:(NSArray *)objctypes;

@end

@implementation DatabaseTable

+ (void)initialize {
 
}

//+ (void)printAttributesForProperty:(NSString *)prop {
//    const char *attrbutes   = [self attributesForProperty:prop];
//    NSString *Attributes = [NSString stringWithUTF8String:attrbutes];
//    
//    NSLog(@"%@ attributes = %@", prop, @(attrbutes));
//}

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
 *  不支持的类型，返回空
 */
+ (NSString *)sqlitetypeForObjctype:(NSString *)objctype supported:(BOOL *)supportedPtr{
    NSString *sqlitetype;
    
    *supportedPtr = YES;
    
#undef  is_type
#define is_type( __type ) [str_of_type(__type) contains:objctype]
    
    _assert_(! is_type(void)/** 'v' */);
//    _assert_(! is_type(char *)/** '*' */);
    _assert_(! is_type(Class)/** '#' */);
    _assert_(! is_type(SEL)/** ':' */);
    
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
        
    } else if (is_type(float)       ||
               is_type(double)) {
        
    } else if (is_type(unsigned char *)     ||
               is_type(char *)) {
        
    } else if (is_type(NSString *)) {
        
    } else {
        *supportedPtr    = NO;
        sqlitetype      = nil;
        
        // should be logged.
        loge(@"type (%@) not supported!", objctype);
    }
    
    return sqlitetype;
}

#pragma mark -

@end
