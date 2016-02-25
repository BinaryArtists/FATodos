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
// pushup 模块，删除不成功
// pushup的条目，展开、收缩后，会有一条线没有了。
// pushup的条目，展开选择个数的时候，没有立即反馈，还需要重置。
// 作好db迁移
// 这个https://github.com/tanis2000/MTLFMDBAdapter类似于sql-query-builder，哈哈
// 注意swpeaView，https://github.com/zhxnlai/ZLSwipeableView/issues/9
// 对四象限变换的时候，使用pop的抖动效果
// 集成，手机端可以报bug的sdk。

// 便签开始之前：要做好db那部分，自动归档



/////////////////////////////////totototodo。

//  ！！！！！类似extobjc库，将写法也抽出来一种，也就是samurai中的各种简化写法，extobjccodingstyle


////////////////////////////////结合todo\结合外包\
// 如何构建自己的知识体系：http://www.zhihu.com/question/19591121
/**
 夏诚，达芬奇可以一手写字，同时另一手作画。
 千落、juguo、吴键 等人赞同
 回答了同类的问题如何构建各专门领域的知识体系？，直接粘贴过来，再做一点补充
 
 1、整理，要整理知识必须先对思维进行整理，树立一个明确的目标（这样做的目的是为了保持你的动力），比如你可以弄一个武将战斗力排名分析，先把一个个武将的事例、情况、资料都整理好，这一步你可以随机来做，用一句话来说就是把你知道的东西都用书面的形式表达出来。
 
 2、标签，你完成了对认知的整理之后，就可以开始给一类类的资料贴上标签，比如武将、背景、转折事件、人物的文化属性……一句话总结就是把能归纳到同一类的内容都找到标签归纳起来。
 
 3、分层，现在你要思考标签之间的关系，哪个是子级，哪个是父级，比如武将是父级，那么人物文化属性就是子级，具体的转折事件就是人物属性的子级……一句话总结就是把它们按照你的规则关联起来。
 
 4、逻辑树状，ok，通过上一步之后，要把经过分层之后的标签按照逻辑的关系组织起来，基本上到这一步你的体系已经建立起来了，历史时间常见的如按照时间顺序，每一年这些人物的情况……一句话总结就是别人可以清晰的阅读、理解你的这个东西。
 
 5、填充，根据你说的情况，你对有些东西不够了解，那么你在逻辑树状的时候一定会有些内容组织不起来，调查、学习那些东西，把它们联系起来，一句话总结：补足。
 
 6、完善、修正，当你以上五步完成以后，你可以把你知道的东西去交流、探讨、展示了，这个时候可能会有其他地方是你没想到的，历史的话正史、野史、传闻多了去了，不断完善，这样你的知识体系就会越来越圆满。
 
 最后：对知识的认知和所有一切的感知都必须建立在实践上。

 */

////////////////////////////////////////
// 产品是如何迭代的。。。。？？？？商业模式、盈利模式是如何确立的？？？？



／／依赖的工程：
1. beautiful app


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

@string( PHOTO_COMMENT_VC )

@string( POCO_HOME_VC )

@end

#pragma mark - AppDelegate (configuration)

@interface AppDelegate (configuration)

+ (void)doConfig;

+ (void)configSamuraiFramework;

@end

