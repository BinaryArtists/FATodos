//
//  Memo.h
//  FATodos
//
//  Created by fallen.ink on 9/27/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "BaseEntity.h"

@interface Memo : BaseEntity

@string( fmt_Date )

@property (nonatomic, strong) NSString *    title;
@property (nonatomic, strong) NSString *    content;
@property (nonatomic, strong) NSString *    date;

@end
