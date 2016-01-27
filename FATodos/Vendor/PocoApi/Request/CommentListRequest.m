//
//  CommentListRequest.m
//  FATodos
//
//  Created by qingqing on 16/1/26.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "CommentListRequest.h"

@implementation CommentListRequest

//@"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=8&data_type=list&show_type=show&struction=index&article_last_update_time=1437499820&zero_type=0&_no_cache=1&_=1453736485787"

+ (CommentListRequest *)instance {
    CommentListRequest *request = [CommentListRequest new];
    
    request.action  = @"get_article";
    request.articlePage = 10;
    request.type    = @"theme";
    request.typeId  = type_id_portrait;
    request.dataType    = @"list";
    request.showType    = @"show";
    request.struction   = @"index";
    request.articleLastUpdateTime   = [[NSDate new] timeIntervalSince1970];
    request.zeroType    = 0;
    request.noCache     = 1;
    request.timestamp        = [[NSDate new] timeIntervalSince1970];
    
    return request;
}

+ (NSDictionary *)transitePropertyKeys {
    return @{
             @"action":@"action",
             @"articlePage":@"article_page",
             @"type":@"type",
             @"typeId":@"type_id",
             @"dataType":@"data_type",
             @"showType":@"show_type",
             @"struction":@"struction",
             @"articleLastUpdateTime":@"article_last_update_time",
             @"zeroType":@"zero_type",
             @"noCache":@"_no_chache",
             @"timestamp":@"_"
             };
}

- (NSDictionary *)params {
    return [self dictionaryValue];
}


@end
