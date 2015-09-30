//
//  Samurai_Error.h
//  AwesomeError
//
//  Created by fallen.ink on 9/18/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Samurai_Core.h"
#import "Samurai_EventConfig.h"

///===================================
// TODO:

// 1. 如果需要加userInfo，自定义FAError

///===================================

#pragma mark -

#undef  make_string_obj
#define make_string_obj( __obj ) \
[NSString stringWithFormat:@"%@", __obj]

#undef  make_error_domain
#define make_error_domain( __self ) make_string_obj(NSStringFromClass([__self class]))

#undef  make_error
#define make_error( __domain, __code ) \
([NSError errorWithDomain:__domain code:__code userInfo:nil])

#undef  make_error_3
#define make_error_3( __domain, __code, __desc ) \
([NSError errorWithDomain:__domain \
code:__code \
desc:__desc])

#undef  error_message_of
#define error_message_of( __error ) \
(__error . userInfo [kErrorDescString])

#pragma mark -

#undef	error
#define error( __name ) \
property (nonatomic, readonly) NSError * __name; \
- (NSError *)__name; \
+ (NSError *)__name;

#undef	def_error // 默认，把当前类，作为域
#define def_error( __name, __value, __desc ) \
dynamic __name; \
- (NSError *)__name { return make_error_3(make_string_obj(NSStringFromClass([self class])), __value, __desc); } \
+ (NSError *)__name { return make_error_3(make_string_obj(NSStringFromClass([self class])), __value, __desc); }

#undef	def_error_1 // 自定义 domain
#define def_error_1( __name, __domain, __value, __desc ) \
dynamic __name; \
- (NSError *)__name { return make_error_3(__domain, __value, __desc); } \
+ (NSError *)__name { return make_error_3(__domain, __value, __desc); }

#undef	def_error_2 // 默认，使用系统域
#define def_error_2( __name, __value, __desc ) \
def_error_1( __name, [NSError SamuraiErrorDomain], __value, __desc)

// Error operation, key-value-map

#undef  kvm_error
#define kvm_error( __error ) (@{[__error storedKey] : __error})

// Error Modulized
// 不同模块之间，error转换；2. 改变domain，改变code，在原有userinfo增加信息
#undef  error_modulized
#define error_modulized( __error ) // todo:

// ErrorCode for error
#undef  error_for
#define error_for( __code ) ([self errorForCode:__code])

#undef  error_for_domain_code
#define error_for_domain_code // todo:

#pragma mark - NSError ( Handler )

@interface NSError (Handler) // NSError的属性：domain、code、userinfo.....

/**
 *  @function:  error 存入字典的 key
 
 *  @named:     'stored' means error be stored
 
 *
 */
@prop_readonly( NSString *, storedKey )

/**
 *  @function:  通用的存入UserInfo的key
 */
@string( messagedKey )

// == 系统的
@string( CocoaErrorDomain )
@string( LocalizedDescriptionKey )
@string( StringEncodingErrorKey )
@string( URLErrorKey )
@string( FilePathErrorKey )

// == 框架的
@string( SamuraiErrorDomain )

@prop_readonly( NSString *, message )


// Error maker

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                           desc:(NSString *)desc;

// Equal

- (BOOL)isInteger:(NSInteger)code;

- (BOOL)is:(NSError *)error;

// Error userInfo

- (NSError *)with:(NSDictionary *)userinfo;

// External error pool

+ (void)setExternalErrorPool:(NSMutableDictionary *)pool;

// Error pool

+ (id)errorPoolOrCreate;

+ (id)errorPool;

- (id)errorPoolOrCreate;

- (id)errorPool;

// Error manage

+ (BOOL)isPooled:(NSString *)key;

- (BOOL)isPooled;

/**
 *  add to pool.
 
 *  named it "toPool", just because it's simple. ^_^
 */
- (void)toPool;

/**
 *  make self dictionary
 */
- (NSDictionary *)pooling;

/**
 *  drag error from pool
 
 *  是对象方法，是需要domain和code
 */
- (id)fromPool;

- (void)removeFromPool;

- (void)removeAllErrorsFromPool;

@end

#pragma mark - NSError ( Modulized )



#pragma mark - NSObject ( NSError_Handler )

/**
 *  重要：
 
 *  该方法，依赖self的class，也就是依赖当前域。
 
 *  如果接口提供的错误码，没有严格的分区：0～1000，1001～5000，5001～10000，则以接口为域
 
 @interface APIOrder_add (NSError)
 
 @error( Failed )
 
 @end
 
 *  否则：可以以当前层为域（ViewModel or service）
 
 @interface ServiceOrder (NSError)
 
 @error( Failed )
 
 @end
 
 *  再则：公用系统domain
 
 todo: 未实现
 
 */

@interface NSObject (NSError_Handler)

- (NSError *)errorForCode:(NSInteger)code;

+ (NSError *)errorForCode:(NSInteger)code;

@end

///////////////////////////////////////////////////////////
// 扩展
// 参考：https://github.com/karelia/KSError/blob/master/KSError.h
///////////////////////////////////////////////////////////

#pragma mark - NSError ( FAError )

@interface NSError ( FAError )

@end

#pragma mark - FAError

@interface FAError : NSObject

@end

#pragma mark - Mutable error

@interface FAMutableError : FAError

@end
