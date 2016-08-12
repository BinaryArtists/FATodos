#import <Foundation/Foundation.h>
#import "Mantle.h"
#import <UIKit/UIKit.h>
#import "FWResponse.h"
#import "FWGeoPoint.h"
@interface FWLoginRequest : MTLModel<MTLJSONSerializing>
	@property(nonatomic, strong) NSString * name;
	@property(nonatomic, strong) NSString * password;
	@property(nonatomic, assign) int userType;
//	@property(nonatomic, strong) FWGeoPoint * geoPoint;
	@property(nonatomic, strong) NSString * captchaCode;
	@property(nonatomic, strong) NSString * deviceId;

@end
@interface FWLoginResponse : MTLModel
	@property(nonatomic, strong) FWBaseResponse * response;
	@property(nonatomic, strong) NSString * token;
	@property(nonatomic, assign) long long userId;
	@property(nonatomic, strong) NSString * sessionId;
	@property(nonatomic, strong) NSString * strUserId;
	@property(nonatomic, strong) NSString * userSecId;
@end
