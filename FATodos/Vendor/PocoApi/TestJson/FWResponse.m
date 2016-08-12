#import "FWResponse.h"
@implementation FWBaseResponse
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"errorCode" :@"c",
		@"errorMessage" :@"m",
	};
 }
@end
