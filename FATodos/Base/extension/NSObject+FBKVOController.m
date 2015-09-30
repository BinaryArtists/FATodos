/**
 Copyright (c) 2014-present, Facebook, Inc.
 All rights reserved.
 
 This source code is licensed under the BSD-style license found in the
 LICENSE file in the root directory of this source tree. An additional grant
 of patent rights can be found in the PATENTS file in the same directory.
 */

#import "NSObject+FBKVOController.h"

#import <libkern/OSAtomic.h>
#import <objc/message.h>

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Convert your project to ARC or specify the -fobjc-arc flag.
#endif

#pragma mark NSObject Category -

@implementation NSObject (FA)

- (kvo_ptr)kvo {
    return [self KVOController];
}

- (void)kvo_off {
    [self setKVOController:nil];
}

@end

