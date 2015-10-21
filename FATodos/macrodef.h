//
//  macrodef.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//
//  所有宏定义，都遵循下划线风格

#ifndef FATodos_macrodef_h
#define FATodos_macrodef_h

#ifdef DEBUG

#   define debugLog(...) NSLog(__VA_ARGS__)
#   define debugMethod() NSLog(@"%s", __func__)

#   define FAssert( __condition ) NSAssert(__condition, NSStringFromSelector(_cmd));

#   define debugCode( __code_fragment ) { __code_fragment }

#else

#   define debugLog(...)
#   define debugMethod()

#   define FAssert( __condition )

#   define debugCode( __code_fragment )

#endif

#define rgb_color(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define rgba_color(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define deprecated_method __attribute__((deprecated))

#define empty_string        @""

#define str(key)            NSLocalizedString(key, nil)

#define path_of_app_home    NSHomeDirectory()
#define path_of_temp        NSTemporaryDirectory()
#define path_of_document    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define path_of_cache       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define app_version         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define _ self

#endif
