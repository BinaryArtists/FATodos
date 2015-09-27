//
//  BaseEntity.h
//  FATodos
//
//  Created by fallen.ink on 9/23/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "MTLModel.h"

@interface BaseEntity : MTLModel <BaseEntityProtocol>

@string( SQL_TABLE_ELEMENT_NAME_ID )

@property (nonatomic, assign) int64_t id;


@end
