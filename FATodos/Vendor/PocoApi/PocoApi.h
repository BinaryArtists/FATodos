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
#define ApiPocoPortraitListURL  @""

/**
 *  风景
 */
#define ApiPocoSceneryListURL   @""

/**
 *  生态
 */
#define ApiPocoEcologyListURL  @""

/**
 *  纪实
 */
#define ApiPocoDocumentaryListURL  @""

/**
 *  Lomo
 */
#define ApiPocoLomoListURL  @""

/**
 *  观念
 */
#define ApiPocoConceptionListURL  @""

/**
 *  商业
 */
#define ApiPocoCommerceListURL  @""

/**
 *  其他
 */
#define ApiPocoOtherListURL  @""


@interface PocoApi : NSObject

@singleton( PocoApi )

@end
