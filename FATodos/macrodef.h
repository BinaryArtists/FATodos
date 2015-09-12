//
//  macrodef.h
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#ifndef FATodos_macrodef_h
#define FATodos_macrodef_h

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define DEPRECATED_METHOD __attribute__((deprecated))Y(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define DEPRECATED_METHOD __attribute__((deprecated))

#define kStringPushup       @"俯卧撑"
#define kStringDumbell      @"哑铃"

#endif
