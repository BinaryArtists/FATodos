#import "FWLogin.h"
@implementation FWLoginRequest
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"name" :@"n",
		@"password" :@"p",
		@"userType" :@"ut",
//		@"geoPoint" :@"gp",
		@"captchaCode" :@"cc",
		@"deviceId" :@"di",
	};
 }
//+ (NSValueTransformer *)geoPointJSONTransformer {
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        NSArray * jsonArray = value;
//        NSMutableArray * geoPointArray = [NSMutableArray array];
//        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            FWGeoPoint * item = [MTLJSONAdapter modelOfClass:[FWGeoPoint class] fromJSONDictionary:obj error:nil];
//            [geoPointArray addObject:item];
//        }];
//        return geoPointArray;
//    }];
//}

@end
@implementation FWLoginResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"response" :@"r",
		@"token" :@"t",
		@"userId" :@"ui",
		@"sessionId" :@"si",
		@"strUserId" :@"sui",
		@"userSecId" :@"usi",
	};
 }
+ (NSValueTransformer *)responseJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray * jsonArray = value;
        NSMutableArray * responseArray = [NSMutableArray array];
        [jsonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            FWBaseResponse * item = [MTLJSONAdapter modelOfClass:[FWBaseResponse class] fromJSONDictionary:obj error:nil];
            [responseArray addObject:item];
        }];
        return responseArray;
    }];
}
@end
