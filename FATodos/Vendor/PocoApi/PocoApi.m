//
//  PocoApi.m
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoApi.h"
#import "CommentListRequest.h"

@interface PocoApi ()

@property (nonatomic, strong) MKNetworkHost *netHost;

@end

@implementation PocoApi

@def_singleton( PocoApi )

#pragma mark - 

- (instancetype)init {
    if (self = [super init]) {
        self.netHost    = [MKNetworkHost new];
    }
    
    return self;
}

#pragma mark - Apis

- (void)commentListWithTypeId:(eTypeId)typeId
                      lastTag:(int64_t)lastUpdateTime
               successHandler:(ObjectBlock)successHandler
               failureHandler:(ErrorBlock)failureHandler {
    CommentListRequest *request = [CommentListRequest instance];
    request.typeId              = typeId;
    request.timestamp           = lastUpdateTime;
    
    MKNetworkRequest *urlRequest   = [self.netHost requestWithPath:ApiPocoPortraitListURL
                                                         params:[request params]];
    [urlRequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        NSLog(@"%@", completedRequest.response);
        
        // 1. Has a error?
        
        
        // 2. Parse response -> Json dictionary
        
        
        // 3. Json dictionary -> Specific response
    }];
    
    [self.netHost startRequest:urlRequest];
}

@end
