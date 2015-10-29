//
//  DatabaseTable.m
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

//  三层
//  runtime     － 实体的属性、属性的类型（property）
//  database    － 实体的表，字段，值（table）
//  operation   － 实体的操作（sentence）

#import "DatabaseTable.h"

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

@implementation DatabaseTable

@end
