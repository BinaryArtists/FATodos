//
//  NSString+Theme.m
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "NSString+Theme.h"

@implementation NSString (Theme)

+ (NSString *)forItemType:(NSInteger)type {
    switch (type) {
        case kItemDumbbell: {
            return [s Dumbell];
        }
            break;
            
        case kItemPushup: {
            return [s Pushup];
        }
            break;
            
        case kItemSitup: {
            return [s SitsUp];
        }
    }
    
    return nil;
}

+ (NSString *)forModuleType:(NSInteger)type {
    switch (type) {
        case kModuleItem: {
            return [s ModuleItem];
        }
            break;
            
        case kModuleFourQuadrant: {
            return [s ModuleFourQuadrant];
        }
            break;
            
        case kModuleNote: {
            return [s ModuleNote];
        }
            break;
            
        case kModuleMemo: {
            return [s ModuleMemo];
        }
            break;
    }
    
    return nil;
}

@end
