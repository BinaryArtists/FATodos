//
//  IflyComponent.m
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <iflyMSC/iflyMSC.h>

#import "IflyComponent.h"
#import "IflyComponent_Config.h"

@interface IflyComponent () <IFlySpeechRecognizerDelegate, IFlyRecognizerViewDelegate>

@property (nonatomic, strong) IFlySpeechRecognizer *    iFlySpeechRecognizer;   //不带界面的识别对象
@property (nonatomic, strong) IFlyRecognizerView *      iflyRecognizerView;     //带界面的识别对象

@property (nonatomic, strong) IFlyDataUploader *        uploader;               //数据上传对象

@end

@implementation IflyComponent

@def_singleton( IflyComponent )

#pragma mark - 

+ (void)powerOn {
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    [IFlySetting setLogFilePath:path_of_cache];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", [s APP_ID]];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    // 订阅 showSpeechView
    IflyComponent_Config *config    = [[IflyComponent sharedInstance] config];
    kvo_ptr kvoPtr     = [[IflyComponent sharedInstance] kvo];

    [kvoPtr observe:config
            keyPath:@"showSpeechView"
            options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
              block:^(IflyComponent *observer, IflyComponent_Config *object, NSDictionary *change) {
                  NSNumber *newValue    = kvo_value_of( change )
                  
                  [observer whenShowSpeechView:[newValue boolValue]];
              }];
}

+ (void)powerOff {
    [[IflyComponent sharedInstance] kvo_off];
}

#pragma mark - 

- (void)process:(id)data {
    [[IFlySpeechUtility getUtility] handleOpenURL:data];
}

#pragma mark - IFlySpeechRecognizerDelegate

- (void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    
}

#pragma mark - IFlyRecognizerViewDelegate

/*!
 *  回调返回识别结果
 *
 *  @param resultArray 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度
 *  @param isLast      -[out] 是否最后一个结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast {
    
}

/*!
 *  识别结束回调
 *
 *  @param error 识别结束错误码
 */
- (void)onError: (IFlySpeechError *) error {
    
}

#pragma mark - Private method

/**
 *  Notice:
 
 *  尽量用好on、when等词，常用在事件过程
 
 *  像 didClick 是面相事件对应的操作类型的用语
 */

- (void)whenShowSpeechView:(BOOL)show {
    
}

#pragma mark - Property

- (IflyComponent_Config *)config {
    return [IflyComponent_Config sharedInstance];
}

@end
