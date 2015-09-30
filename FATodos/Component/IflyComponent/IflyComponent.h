//
//  IflyComponent.h
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

/**
 *  ify也可以有多种服务：听写、语音识别、语义分析、词法分析、
 */

/*
 SDK Demo包含以下功能：
 1.语音识别
 2.语义理解
 3.语法识别
 4.语音合成
 5.语音评测
 6.语音唤醒（仅提醒）
 7.声纹识别（仅提醒）
 */

#import "Samurai_Package.h"

@class IflyComponent_Config;

@interface IflyComponent : SamuraiComponent

@singleton( IflyComponent )

@property (nonatomic, readonly) IflyComponent_Config *  config;

@property (nonatomic, assign) NSUInteger                errorCode;
@property (nonatomic, strong) NSString *                errorDesc;

@property (nonatomic, strong) NSError *                 error;

// 事件

@property (nonatomic, strong) Block                     startHandler;

#pragma mark - error

@error( err_ )

#pragma mark - notification

#pragma mark - setup

+ (void)powerOn;

+ (void)powerOff;

#pragma mark - 

- (void)process:(id)data;

@end

