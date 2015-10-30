//
//  Library、.h
//  FATodos
//
//  Created by fallen.ink on 10/28/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

//  依赖：
//  fmdb
//  samurai

//  参考：
//  https://github.com/li6185377/LKDaoBase
//  https://github.com/Joker-King/JKDBModel
//  https://github.com/iKingsly/iKYerialization
//  https://github.com/woooooojianjie/SQLitePersistentObject
//  api语法，简洁程度，类似MagicalRecord

//  博客：
//  http://www.cr173.com/html/18677_1.html

//  使用：
//  1. 引入依赖
//  2. 引入本库
//  3. 引入libsqlite3.dylib
//  4. 实体类继承，可以不实用继承么？卧槽，直接对NSObject进行扩展、可能要设置baseClass的层级，组织property序列化hack错误。
//  5. 所有api都定义在：AutoXXXProtocol中，实际上，对NSobject对象进行操作，误用对象，会断言

#ifndef Library__h
#define Library__h

/***
 * TODO:
 
 * 1. 自动化Entity存储, AD：auto database
 * 2. 自动化归档，AA：auto archive
 * 3. db迁移
 * 4. 研究其他存储方案，取其精华
 * 5. swift版本
 
 *  6. 实体类功能：
 *  6.1 增删改差，
 *  6.2 序列化，反序列化？json、xml等等支持？mantle、Jastor
 *  6.3 MT: multi-thread, ST: single-thread，实现两个版本，然后用钩子
 
 *  7. JKDBModel的特点：
 *  7.1 自动创建数据库、自动创建数据库表。
 *  7.2 自动检测字段添加新字段。
 *  7.3 一行代码实现数据库的CURD操作。
 *  7.4 源码及其简单，易于理解和掌握。
 *  7.5 扩展自己的功能也非常得简单，容易。
 *  7.6 支持多线程，非线程阻塞。
 *  7.7 支持arc和mrc。
 
 *  8. 本项目的目标：
 *  8.1 自动创建数据库，创建数据库表
 *  8.2 无需继承
 *  8.3 自动归档
 *  8.4 自动检测字段、添加新字段
 *  8.5 自动完成db迁移，深度迁移
 *  8.6 支持多线程、单线程，默认单线程
 *
 */

// 事先的约定？？？？
//1. sqlite的数据库表名直接使用实体类的类名；
//2. sqlite的数据字段使用实体类的属性名称；
//3. sqlite的数据类型统一设为text（引起sqlite这种文本数据库是动态类型的，存储的本质都是文本）
//4. 实体类的类型统一都设为NSString




// ==================================
// 实体属性类型支持：
//
//
//
//
//
//
// ==================================


#import "NSObject+AutoDatabase.h"
#import "NSObject+AutoArchive.h"

//  实现思路


#endif /* Library__h */
