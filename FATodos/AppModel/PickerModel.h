//
//  PickerModel.h
//  FATodos
//
//  Created by fallen.ink on 9/22/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Item1;

@interface PickerModel : NSObject

@property (nonatomic, strong) NSArray *     titleArray;
@property (nonatomic, assign) NSInteger     indexSelected;

@property (nonatomic, assign) int32_t       round_1;
@property (nonatomic, assign) int32_t       round_2;
@property (nonatomic, assign) int32_t       round_3;

@property (nonatomic, weak) Item1 *         item;

@end
