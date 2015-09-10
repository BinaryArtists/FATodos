//
//  NSString+Theme.m
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "NSString+Theme.h"

@implementation NSString (Theme)

+ (NSString *)forItemType:(NSInteger)type {
    switch (type) {
        case kItemDumbbell: {
            return kStringDumbell;
        }
            break;
            
        case kItemPushup: {
            return kStringPushup;
        }
            break;
    }
    
    return nil;
}

+ (NSString *)forModuleType:(NSInteger)type {
    switch (type) {
        case kModuleItem: {
            
        }
            break;
            
        case kModuleFourQuadrant: {
            
        }
            break;
    }
    
    return nil;
}

@end
