//
//  PocoApi.m
//  FATodos
//
//  Created by qingqing on 16/1/25.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import "PocoApi.h"
#import "CommentListRequest.h"

#import "FWJsonProtocol.h"

@interface PocoApi ()

@property (nonatomic, strong) MKNetworkHost *netHost;

@end

@implementation PocoApi

@def_singleton( PocoApi )

#pragma mark - 

- (instancetype)init {
    if (self = [super init]) {
        self.netHost    = [[MKNetworkHost alloc] initWithHostName:@"192.168.0.182:8080"];
    }
    
    return self;
}

#pragma mark - Apis

- (void)commentListWithTypeId:(eTypeId)typeId
                      lastTag:(int64_t)lastUpdateTime
               successHandler:(ObjectBlock)successHandler
               failureHandler:(ErrorBlock)failureHandler {
//    CommentListRequest *request = [CommentListRequest instance];
//    request.typeId              = typeId;
//    request.timestamp           = lastUpdateTime;
//
//    /**
//     *  default: httpMethod is GET
//     */
//    MKNetworkRequest *urlRequest   = [self.netHost requestWithPath:UrlPocoCommentList
//                                                         params:[request params]];
//    [urlRequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
//        NSLog(@"%@", completedRequest.response);
//        
//        // 1. Has a error?
//        if (completedRequest.error) {
//            failureHandler(completedRequest.error);
//        } else {
//            CommentListResponse *response   = [CommentListResponse new];
//            
//            // 2. Parse response -> Json dictionary
//            
//            
//            // 3. Json dictionary -> Specific response
//            
//            
//            successHandler(response);
//        }
//    }];
//    
//    [self.netHost startRequest:urlRequest];
    
    FWLoginRequest *request = [FWLoginRequest new];
    request.userType  = 0;
    request.name = @"18616361386";
    request.password = @"qqqqqq";
//    request.geoPoint = [FWGeoPoint new];
//    request.geoPoint.longitude = 121;
//    request.geoPoint.latitude = 30;
    request.captchaCode = @"111111";
    request.deviceId  = @"fasy9fy9sfyasdfs";
    
    NSDictionary *params    = [MTLJSONAdapter JSONDictionaryFromModel:request error:nil];
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    __unused NSString *url = @"/QQ/api518/pb/v1/login";
    __unused NSString *fullUrl = [NSString stringWithFormat:@"/QQ/api518/pb/v1/login?a=%@", jsonString];
    
    
    // url 编码:::::http://blog.csdn.net/typingios/article/details/9136005
    // 网络方面的知识图谱
    
    /**
     
     方法1:
     NSString* encodedString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     方法2:
     NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)urlString,NULL,NULL,kCFStringEncodingUTF8);
     
     */
    
    __unused NSString *encodedFullUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)fullUrl,NULL,NULL,kCFStringEncodingUTF8));
    
    
    MKNetworkRequest *urlRequest   = [self.netHost requestWithPath:url
                                                        params:nil
                                                        httpMethod:@"POST"
                                                              body:requestData ssl:NO];
//                                                        httpMethod:@"POST"];
    
    [urlRequest addCompletionHandler:^(MKNetworkRequest *completedRequest) {
        NSLog(@"%@", completedRequest.response);

        // 1. Has a error?
        if (completedRequest.error) {
            failureHandler(completedRequest.error);
        } else {
//            CommentListResponse *response   = [CommentListResponse new];
            
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:completedRequest.responseData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
FWLoginResponse *response = [MTLJSONAdapter modelOfClass:FWLoginResponse.class
                                      fromJSONDictionary:dic
                                                   error:nil];

            // 2. Parse response -> Json dictionary


            // 3. Json dictionary -> Specific response


            successHandler(response);
        }
    }];
    
    [self.netHost startRequest:urlRequest];
}

@end
