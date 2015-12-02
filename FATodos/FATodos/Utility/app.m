//
//  app.m
//  FATodos
//
//  Created by fallen.ink on 12/1/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "app.h"

@implementation app

+ (UIDeviceOrientation)deviceOrientation {
    return [[UIDevice currentDevice] orientation];
}

+ (UIInterfaceOrientation)statusBarOrientation {
    return [[UIApplication sharedApplication] statusBarOrientation];
}

@end
