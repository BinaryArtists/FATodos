#import <Foundation/Foundation.h>
#import "Mantle.h"
#import <UIKit/UIKit.h>
@interface FWBaseResponse : MTLModel<MTLJSONSerializing>
	@property(nonatomic, assign) int errorCode;
	@property(nonatomic, strong) NSString * errorMessage;
@end
