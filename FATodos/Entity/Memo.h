//
//  Memo.h
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "BaseEntity.h"

@interface Memo : BaseEntity

@string( str_DateFormat )

@property (nonatomic, strong) NSString *    title;
@property (nonatomic, strong) NSString *    content;
@property (nonatomic, strong) NSString *    date;

@end

#pragma mark - Memo ( Utility )

@interface Memo ( Utility )

- (NSDate *)dates; // Notice: 直接用复数形式，虽然不大好，但是方便。
- (void)setDates:(NSDate *)dates;

@end
