/**
  Copyright (c) 2014-present, Facebook, Inc.
  All rights reserved.

  This source code is licensed under the BSD-style license found in the
  LICENSE file in the root directory of this source tree. An additional grant
  of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>
#import "FBKVOController.h"

typedef FBKVOController *kvo_ptr;

#pragma mark -

@interface NSObject (FA)

- (kvo_ptr)kvo;

- (void)kvo_off;

@end

#pragma mark -

#undef  kvo_at
#define kvo_at( __host ) [FBKVOController controllerWithObserver: __host ];

#undef  kvo_value_of
#define kvo_value_of( __change_dict ) __change_dict[NSKeyValueChangeNewKey];