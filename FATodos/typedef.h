//
//  typedef.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#ifndef FATodos_typedef_h
#define FATodos_typedef_h

// ================================= Block 预定义

typedef void(^Block)(void);
typedef void(^BlockBlock)(Block block);
typedef void(^BOOLBlock)(BOOL b);
typedef void(^ObjectBlock)(id obj);
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^MutableArrayBlock)(NSMutableArray *array);
typedef void(^DictionaryBlock)(NSDictionary *dic);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^IndexBlock)(NSInteger index);
typedef void(^ListItemBlock) (NSInteger index, id param);
typedef void(^FloatBlock)(CGFloat afloat);
typedef void(^StringBlock)(NSString *str);
typedef void(^ImageBlock)(UIImage *image);

typedef void(^Event)(id event, NSInteger type, id object);

typedef void(^CancelBlock)(id viewController);
typedef void(^FinishedBlock)(id viewController, id object);

typedef void(^SendRequestAndResendRequestBlock)(id sendBlock, id resendBlock);

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
