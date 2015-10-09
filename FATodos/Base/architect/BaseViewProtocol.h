//
//  BaseViewProtocol.h
//  FATodos
//
//  Created by fallen.ink on 9/22/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewProtocol <NSObject>

@required


@optional // 备忘录

@property (nonatomic, strong) NSObject *testObj;

- (void)onSaveInstanceState:(NSMutableDictionary *)bundle;

- (void)onLoadInstanceState:(NSDictionary *)bundle;

@optional



@end