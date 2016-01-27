//
//  CommentListRequest.h
//  FATodos
//
//  Created by qingqing on 16/1/26.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "MTLModel.h"

/**
 *  宏、枚举，用下划线
 */
typedef enum : NSUInteger {
    type_id_portrait    = 1,
    type_id_scenery     = 2,
    type_id_ecology     = 3,
    type_id_documentary = 4,
    type_id_lomo        = 5,
    type_id_conception  = 6,
    type_id_commerce    = 7,
    type_id_other       = 8,
} eTypeId;

// 根据article_last_update_time=1453881222，单位秒，往前拉取数据

@interface CommentListRequest : MTLModel

@property (nonatomic, strong) NSString *action;
@property (nonatomic, assign) int32_t articlePage;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) int32_t typeId;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *struction;
@property (nonatomic, assign) int64_t articleLastUpdateTime;
@property (nonatomic, assign) int64_t timestamp;
@property (nonatomic, assign) int32_t zeroType;
@property (nonatomic, assign) int32_t noCache;

+ (CommentListRequest *)instance;
- (NSDictionary *)params;

@end
