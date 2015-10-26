//
//  AppDelegate.h
//  FATodos
//
//  Created by fallen.ink on 8/4/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

// Use Framework.SAMURAI
// Use Vendor.Routable
// Use sql-query-builder
// Use MZDayPicker          https://github.com/m1entus/MZDayPicker
// Use PARTagPicker         https://github.com/paulrolfe/PARTagPicker

// Use FlatUIKit

// 窄距俯卧撑锻炼臂力。 宽距俯卧撑锻炼胸大肌

// 1. 上传sqlite
// 2. 下载sqlite

// 俯卧撑 分3组
// cell 长按，从原地动画弹起来，然后扩展，并选择

//self.notificationController = [FTGNotificationController controllerWithObserver:self];
//[self.notificationController observeNotificationName:UIApplicationDidReceiveMemoryWarningNotification
//                                              object:nil
//                                               queue:[NSOperationQueue mainQueue]
//                                               block:^(NSNotification *note, id observer)
// {
//     NSLog(@"observer %@ notification payload %@", observer, note);
// }];


//语音！！！相关工程：
//MSCDemo_UI
//Voice2Note

// todo:
// pushup中日期管理
// db 中加入日期的字段
// 重构LaunchScreen.xib
// 根据http://www.cr173.com/html/18677_1.html这个重构storage模块,https://github.com/Joker-King/JKDBModel
// pushup 模块，删除不成功
// pushup的条目，展开、收缩后，会有一条线没有了。
// pushup的条目，展开选择个数的时候，没有立即反馈，还需要重置。
// pushup的条目，如果超出屏幕了，‘新增’之后，需要直接定位到那里。
// 作好db迁移
// 这个https://github.com/tanis2000/MTLFMDBAdapter类似于sql-query-builder，哈哈
// pushup 那边的首次加载动画，不成功

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

#pragma mark - AppDelegate (ViewRoutable)

@interface AppDelegate (ViewRoutable)

@string( MAIN_VC )

@string( PUSHUP_VC )

@string( DIAGRAM_VC )

@string( MEMO_VC )

@string( NOTE_VC )

@string( QUADRANT_VC )

@string( POMODORO_VC )

@end

#pragma mark - AppDelegate (configuration)

@interface AppDelegate (configuration)

+ (void)doConfig;

+ (void)configSamuraiFramework;

@end

