//
//  Samurai_Error.m
//  AwesomeError
//
//  Created by fallen.ink on 9/18/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//
#import <objc/runtime.h>

#import "Samurai_Error.h"

@implementation NSError (Handler)

@def_string( messagedKey, @"NSError.message.key" )

@def_string( CocoaErrorDomain           , NSCocoaErrorDomain )
@def_string( LocalizedDescriptionKey    , NSLocalizedDescriptionKey )
@def_string( StringEncodingErrorKey     , NSStringEncodingErrorKey )
@def_string( URLErrorKey                , NSURLErrorKey )
@def_string( FilePathErrorKey           , NSFilePathErrorKey )
@def_string( SamuraiErrorDomain         , @"NSError.samurai.domain" )

#pragma mark - Error maker

+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                           desc:(NSString *)desc { // desc 可以为空
    NSAssert(domain, @"Domain nil");
    
    desc = !desc ? @"" : desc;
    
    NSDictionary *userInfo      = @{[self messagedKey]:desc};
    NSError *error              = [self errorWithDomain:domain code:code userInfo:userInfo];;
    
    // 加入pool
    if (![error isPooled]) {
        [error toPool];
        
        return error;
    } else {
        return [error fromPool];
    }
}

#pragma mark - Equal

- (BOOL)isInteger:(NSInteger)code {
    return [self code] == code;
}

- (BOOL)is:(NSError *)error {
    
    // 实现
    
    return NO;
}

#pragma mark - UserInfo

- (NSString *)message {
    if (self.userInfo &&
        [self.userInfo.allKeys containsObject:[self messagedKey]]) {
        
        return self.userInfo[[self messagedKey]];
    }
    
    return [NSString new];
}

- (NSError *)with:(NSDictionary *)userinfo {
//    NSAssert(userinfo, @"nil");
//    
//    NSMutableDictionary *togetherDict   = [self.userInfo mutableCopy];
//    
//    [togetherDict addEntriesFromDictionary:userinfo];
//    
//    _userInfo   = togetherDict;
    
    // todo：扩展了FAMutableError之后，可用。原地修改userInfo

    return self;
}

#pragma mark - Extern pool - 优先

// rentzsch/jrswizzle start

+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    
    if (!origMethod) {
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!altMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel {
    return [object_getClass(self) swizzleMethod:origSel withMethod:altSel];
}

// rentzsch/jrswizzle end

+ (void)setExternalErrorPool:(NSMutableDictionary *)pool {
    UNUSED([self externalPool:pool])
}

+ (NSMutableDictionary *)externalPool:(NSMutableDictionary *)pool {
    static NSMutableDictionary *storedPool;
    
    NSAssert([pool isKindOfClass:[NSMutableDictionary class]], @"pool class imcompatable");
    
    if (pool) {
        storedPool                  = pool;
    }
    
    // 重要：要决定使用外部pool，还是，内部pool
    // Using Method Swizzling
    
    if (storedPool) {
        [self swizzleMethod:@selector(errorPool) withMethod:@selector(externalPool)];
    } else {
        Class class = [self class];
        Method origMethod = class_getInstanceMethod(class, @selector(errorPool));
        IMP origIMP = method_getImplementation(origMethod);
        method_setImplementation(origMethod, origIMP);
        
        Method dstMethod = class_getInstanceMethod(class, @selector(externalPool));
        IMP dstIMP = method_getImplementation(dstMethod);
        method_setImplementation(dstMethod, dstIMP);
    }
    
    return storedPool;
}

+ (NSMutableDictionary *)externalPool {
    return [self externalPool:nil];
}

#pragma mark - Error pool

- (NSString *)storedKey {
    return [NSString stringWithFormat:@"%@.%ld", self.domain, self.code]; // todo: use MACRO
}

+ (id)errorPoolOrCreate {
    static NSMutableDictionary *pool;
    
    if (!pool) {
        pool                        = [NSMutableDictionary new];
    }
    
    return pool;
}

+ (id)errorPool {
    return [self errorPoolOrCreate];
}

- (id)errorPoolOrCreate {
    return [self.class errorPoolOrCreate];
}

- (id)errorPool {
    return [self.class errorPool];
}

#pragma mark - Error manage

+ (BOOL)isPooled:(NSString *)key {
    NSAssert(key, @"Error key nil");
    
    return NO;
}

- (BOOL)isPooled {
    NSMutableDictionary *pool       = [self errorPool];
    
    if (!pool) {
        return NO;
    }
    
    if ([pool.allKeys containsObject:[self storedKey]]) {
        return YES;
    }
    
    return NO;
}

- (void)toPool {
    NSAssert(self.storedKey, @"Error key nil");
    
    NSMutableDictionary *pool       = [self errorPool];
    
    if (pool && ![pool.allKeys containsObject:[self storedKey]]) {
        [pool setObject:self forKey:[self storedKey]];
    }
}

- (NSDictionary *)pooling {
    return @{[self storedKey] : self};
}

- (id)fromPool {
    if ([self isPooled]) {
        NSMutableDictionary *pool       = [self errorPool];
        
        return [pool objectForKey:[self storedKey]];
    } else {
        return nil;
    }
}

- (void)removeFromPool {
    NSAssert(self.storedKey, @"Error key nil");
    
    NSMutableDictionary *pool       = [self errorPool];
    
    if (pool && [pool.allKeys containsObject:[self storedKey]]) {
        [pool removeObjectForKey:[self storedKey]];
    }
}

- (void)removeAllErrorsFromPool {
    NSMutableDictionary *pool       = [self errorPool];
    
    if (pool) {
        [pool removeAllObjects];
    }
}

@end

#pragma mark - NSObject (Property_Traversal)

@interface NSObject (Property_Traversal)

- (void)objectPropertyTraversal; // 也可以withBlock，对属性进行处理

+ (void)objectPropertyTraversal; // 也可以withBlock，对属性进行处理

@end

@implementation NSObject (Property_Traversal)

+ (void)objectPropertyTraversal {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    
    TODO( "Should be 递归" )
    for(int i = 0; i < propsCount; i++) {
        objc_property_t prop    = props[i];
        NSString *propName      = [NSString stringWithUTF8String:property_getName(prop)];
        __unused id value       = [self valueForKey:propName];
    }
}

- (void)objectPropertyTraversal {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    
    TODO( "Should be 递归" )
    
    for(int i = 0; i < propsCount; i++) {
        objc_property_t prop    = props[i];
        NSString *propName      = [NSString stringWithUTF8String:property_getName(prop)];
        __unused id value       = [self valueForKey:propName];
    }
}

@end

#pragma mark - NSObject (NSError_Handler)

@implementation NSObject (NSError_Handler)

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

+ (NSError *)errorForCode:(NSInteger)code {
    NSError *error = make_error(make_string_obj(NSStringFromClass([self class])), code);
    
    if (![error isPooled]) { // pool中没有该key的error
        [self objectPropertyTraversal];
    }
    
    return make_error_3(make_string_obj(NSStringFromClass([self class])), code, nil);
}

- (NSError *)errorForCode:(NSInteger)code {
    NSError *error = make_error(make_string_obj(NSStringFromClass([self class])), code);
    
    if (![error isPooled]) {
        [self objectPropertyTraversal];
    }
    
    return make_error_3(make_string_obj(NSStringFromClass([self class])), code, nil);
}

@end