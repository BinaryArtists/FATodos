//
//  IflyComponent.m
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <iflyMSC/iflyMSC.h>

#import "IflyComponent.h"

@implementation IflyComponent

@def_singleton( IflyComponent )

#pragma mark - 

+ (void)powerOn {
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    [IFlySetting setLogFilePath:PATH_OF_CACHE];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", [s APP_ID]];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}

+ (void)powerOff {
    
}

#pragma mark - 

- (void)process:(id)data {
    [[IFlySpeechUtility getUtility] handleOpenURL:data];
}

@end
