//
//  NSString+Theme.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Theme)

+ (NSString *)forItemType:(NSInteger)type;

+ (NSString *)forModuleType:(NSInteger)type;

@end
