//
//  Samurai_Package.h
//  FATodos
//
//  Created by fallen.ink on 9/29/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//
//  同样来自郭虹宇的框架：BeeFramework
//  todo：改写的舒服一些

#import <Foundation/Foundation.h>

#pragma mark -

#undef	component
#define component( __parentClass, __class, __propertyName ) \
        class __class; \
        @interface __parentClass (AutoLoad_##__propertyName) \
        @property (nonatomic, readonly) __class * __propertyName; \
        @end

#undef	def_component
#define def_component( __parentClass, __class, __propertyName ) \
        implementation __parentClass (AutoLoad_##__propertyName) \
        @dynamic __propertyName; \
        - (__class *)__propertyName \
        { \
        return [__class sharedInstance]; \
        } \
        @end

#undef	component_ // singleton
#define component_( __parentClass, __class, __propertyName ) \
        class __class; \
        @interface __parentClass (AutoLoad_##__propertyName) \
        @property (nonatomic, readonly) __class * __propertyName; \
        @end \
        @interface __class : NSObject \
        @singleton( __class ); \
        @end

#undef	def_component_
#define def_component_( __parentClass, __class, __propertyName ) \
        @implementation __parentClass (AutoLoad_##__propertyName) \
        @dynamic __propertyName; \
        - (__class *)__propertyName \
        { \
        return [__class sharedInstance]; \
        } \
        @end \
        @implementation __class \
        @def_singleton( __class ); \
        @end

#pragma mark -

@interface NSObject(AutoLoading)
+ (BOOL)autoLoad;
@end

#pragma mark -

/**
 * An Objective-C wrapper for android-like package, not thread-safe.
 *
 * It's the base class of all sub-packages, DO NOT use this class directly.
 *
 * Step 1) You must include the files below first:
 *
 @code
 #import "Bee_Precompile.h"
 #import "Bee_Package.h"
 @endcode
 *
 * Step 2) Declare package in .h file:
 *
 @code
 ...
 @package_( BeePackage, BeeCLI, cli );
 ^^^^^^  ^^^
 ...
 @endcode
 *
 * Step 3) Define package in .m/.mm file:
 *
 @code
 ...
 @def_package_( BeePackage, BeeCLI, cli );
 ^^^^^^  ^^^
 ...
 @endcode
 *
 * Step 4) Once the package was defined, you can use it like this:
 *
 @code
 BeeCLI * instance = bee.cli;
 ASSERT( nil != instance );
 ASSERT( [instance isKindOfClass:[BeeCLI class]] );
 @endcode
 *
 */

#pragma mark - 

@class SamuraiComponent;
extern SamuraiComponent *component;

#pragma mark - 

@interface SamuraiComponent : NSObject

@singleton( SamuraiComponent )

@property (nonatomic, readonly) NSArray * loadedPackages;

+ (void)load;

/**
 *  功能开启
 
 *  做初始化工作
 */
+ (void)powerOn;

/**
 *  功能关闭
 
 *  做清理工作
 */
+ (void)powerOff;

@end
