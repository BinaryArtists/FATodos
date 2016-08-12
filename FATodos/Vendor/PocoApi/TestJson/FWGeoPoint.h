#import <Foundation/Foundation.h>
#import "Mantle.h"
#import <UIKit/UIKit.h>
@interface FWGeoPoint : MTLModel<MTLJSONSerializing>
	@property(nonatomic, assign) double longitude;
	@property(nonatomic, assign) double latitude;
@end
