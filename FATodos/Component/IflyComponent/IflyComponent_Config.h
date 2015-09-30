//
//  IflyComponent_Config.h
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IflyComponent_Config : NSObject

@singleton( IflyComponent_Config )

// iat
@property (nonatomic, readonly) NSString *          pcmPath;
@property (nonatomic, strong) NSString *            pcmFile;

/**
 *  Setting by ifly
 */
@property (nonatomic, assign) BOOL                  showSpeechView;

@end

//- (instancetype)initWithClock:(Clock *)clock style:(ClockViewStyle)style
//{
//    self = [super init];
//    if (nil != self) {
//        CLOCK_LAYER(self).style = layer_style(style);
//        
//        // create KVO controller instance
//        _KVOController = [FBKVOController controllerWithObserver:self];
//        
//        // handle clock change, including initial value
//        [_KVOController observe:clock keyPath:@"date" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(ClockView *clockView, Clock *clock, NSDictionary *change) {
//            
//            // update observer with new value
//            CLOCK_LAYER(clockView).date = change[NSKeyValueChangeNewKey];
//        }];
//    }
//    return self;
//}