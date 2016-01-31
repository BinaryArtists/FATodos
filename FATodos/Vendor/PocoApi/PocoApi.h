//
//  PocoApi.h
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  人像
 */
#define ApiPocoPortraitListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=1&data_type=list&show_type=show&struction=index&article_last_update_time=1451807709&zero_type=0&_no_cache=1&_=1453736186866"



/**
 *  风景
 */
#define ApiPocoSceneryListURL   @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=2&data_type=list&show_type=show&struction=index&article_last_update_time=1442495211&zero_type=0&_no_cache=1&_=1453736220413"

/**
 *  生态
 */
#define ApiPocoEcologyListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=3&data_type=list&show_type=show&struction=index&article_last_update_time=1438145360&zero_type=0&_no_cache=1&_=1453736268656"

/**
 *  纪实
 */
#define ApiPocoDocumentaryListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=4&data_type=list&show_type=show&struction=index&article_last_update_time=1449560075&zero_type=0&_no_cache=1&_=1453736293990"

/**
 *  Lomo
 */
#define ApiPocoLomoListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=5&data_type=list&show_type=show&struction=index&article_last_update_time=1435766218&zero_type=0&_no_cache=1&_=1453736394789"

/**
 *  观念
 */
#define ApiPocoConceptionListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=6&data_type=list&show_type=show&struction=index&article_last_update_time=1428454658&zero_type=0&_no_cache=1&_=1453736416112"

/**
 *  商业
 */
#define ApiPocoCommerceListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=7&data_type=list&show_type=show&struction=index&article_last_update_time=1431262931&zero_type=0&_no_cache=1&_=1453736443317"

/**
 *  其他
 */
#define ApiPocoOtherListURL  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?action=get_article&article_page=10&type=theme&type_id=8&data_type=list&show_type=show&struction=index&article_last_update_time=1437499820&zero_type=0&_no_cache=1&_=1453736485787"
#define ApiPocoCommentOtherPageAtURL @"http://photo.poco.cn/dianping/index.htx&p=2&type=theme&type_id=8&data_type=list&show_type=show"

/**
 *  Poco 摄影社区点评板块的接口
 *
 */
#define UrlPocoCommentList  @"http://photo.poco.cn/dianping/module/get_data_ajax.php?"


@interface PocoApi : NSObject

@singleton( PocoApi )

- (void)commentListWithTypeId:(eTypeId)typeId
                      lastTag:(int64_t)lastUpdateTime
               successHandler:(ObjectBlock)successHandler
               failureHandler:(ErrorBlock)failureHandler;

@end

/**
 *
 */
@protocol RequestProtocol <NSObject>

// 打包属性
- (NSDictionary *)params;

@end

@protocol ResponseProtocol <NSObject>

- (void)parse:(NSData *)data;

@end
