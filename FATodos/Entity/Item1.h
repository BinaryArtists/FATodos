//
//  Item1.h
//  FATodos
//
//  Created by 李杰 on 9/8/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "BaseEntity.h"

// 俯卧撑、哑铃

@interface Item1 : BaseEntity

@string( str_DateFormat )

@property (nonatomic, copy) NSString *      name;
@property (nonatomic, assign) int32_t       type; // in
@property (nonatomic, strong) NSString *    date;

// has_x
// 未设置、设置为0，都为NO
@property (nonatomic, assign) BOOL          has_1;
@property (nonatomic, assign) int32_t       num_1;
@property (nonatomic, assign) BOOL          has_2;
@property (nonatomic, assign) int32_t       num_2;
@property (nonatomic, assign) BOOL          has_3;
@property (nonatomic, assign) int32_t       num_3;

@end

#pragma mark - Item1 ( Utility )

@interface Item1 ( Utility )

@property (nonatomic, assign, readonly) BOOL isInit;

- (NSDate *)dates; // Notice: 直接用复数形式，虽然不大好，但是方便。
- (void)setDates:(NSDate *)dates;

@end
