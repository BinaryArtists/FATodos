//
//  Item1.h
//  FATodos
//
//  Created by 李杰 on 9/8/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

// 俯卧撑、哑铃

@interface Item1 : NSObject

@property (nonatomic, copy) NSString *      name;
@property (nonatomic, assign) int32_t       type; // in

// has_x
// 未设置、设置为0，都为NO
@property (nonatomic, assign) BOOL          has_1;
@property (nonatomic, assign) int32_t       num_1;
@property (nonatomic, assign) BOOL          has_2;
@property (nonatomic, assign) int32_t       num_2;
@property (nonatomic, assign) BOOL          has_3;
@property (nonatomic, assign) int32_t       num_3;

@end
