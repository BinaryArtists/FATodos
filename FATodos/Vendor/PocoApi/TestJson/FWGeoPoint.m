#import "FWGeoPoint.h"
@implementation FWGeoPoint
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"longitude" :@"lo",
		@"latitude" :@"la",
	};
 }
@end
