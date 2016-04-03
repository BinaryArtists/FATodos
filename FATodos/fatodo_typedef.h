//
//  typedef.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#ifndef FATodos_typedef_h
#define FATodos_typedef_h



// ================================= 枚举类型

typedef NS_ENUM(NSInteger, ModuleType) {
    kModuleItem             = 1, // 俯卧撑、哑铃、仰卧起坐
    kModuleFourQuadrant     = 2, // 四象限
    kModuleNote             = 3, // 笔记
    kModuleMemo             = 4, // 便签
    kModulePomodoro         = 5, // 番茄工作法，The pomodoro technique
};

typedef NS_ENUM(NSInteger, ItemType) {
    kItemPushup             = 1, // 俯卧撑
    kItemDumbbell           = 2, // 哑铃
    kItemSitup              = 3, // 仰卧起坐
};

#endif
