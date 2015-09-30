//
//  IflyComponent_Config.m
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "IflyComponent_Config.h"

@implementation IflyComponent_Config

@def_singleton( IflyComponent_Config )

- (void)setPcmFile:(NSString *)pcmFile {
    FAssert( pcmFile )
    
    _pcmFile    = pcmFile;
    
    NSMutableString *path   = [PATH_OF_CACHE mutableCopy];
    [path appendFormat:@"/%@", pcmFile];
    _pcmPath    = path;
}

@end
