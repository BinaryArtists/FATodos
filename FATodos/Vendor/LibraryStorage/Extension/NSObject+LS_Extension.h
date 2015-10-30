//
//  NSObject+LS_Extension.h
//  FATodos
//
//  Created by fallen.ink on 10/29/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <Foundation/Foundation.h>

//  依赖：Samurai
//  可以成为：#import "Samurai_Runtime.h"的补充

@interface NSObject (LS_Extension)

//  Type Encodings
//  https://developer.apple.com/library/prerelease/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1


//  Table 6-1  Objective-C type encodings
//  ___________________________________________________
//  Code                        Meaning

//  c                           A char
//  i                           An int
//  s                           A short
//  l                           A long
//                              l is treated as a 32-bit quantity on 64-bit programs.
//  q                           A long long
//  C                           An unsigned char
//  I                           An unsigned int
//  S                           An unsigned short
//  L                           An unsigned long
//  Q                           An unsigned long long
//  f                           A float
//  d                           A double
//  B                           A C++ bool or a C99 _Bool
//  v                           A void
//  *                           A character string (char *)
//  @                           An object (whether statically typed or typed id)
//  #                           A class object (Class)
//  :                           A method selector (SEL)
//  [array type]                An array
//  {name=type...}              A structure
//  (name=type...)              A union
//  bnum                        A bit field of num bits
//  ^type                       A pointer to type
//  ?                           An unknown type (among other things, this code is used for function pointers)

//  Table 7-1  Declared property type encodings
//  _________________________________________________________________
//  Code                        Meaning
//  R                           The property is read-only (readonly).
//  C                           The property is a copy of the value last assigned (copy).
//  &                           The property is a reference to the value last assigned (retain).
//  N                           The property is non-atomic (nonatomic).
//  G<name>                     The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,).
//  S<name>                     The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,).
//  D                           The property is dynamic (@dynamic).
//  W                           The property is a weak reference (__weak).
//  P                           The property is eligible for garbage collection.
//  t<encoding>                 Specifies the type using old-style encoding.

//  Property declaration                        Property description
//  @property char charDefault;                 Tc,VcharDefault
//  @property double doubleDefault;             Td,VdoubleDefault
//  @property enum FooManChu enumDefault;       Ti,VenumDefault
//  @property float floatDefault;               Tf,VfloatDefault
//  @property int intDefault;                   Ti,VintDefault
//  @property long longDefault;                 Tl,VlongDefault
//  @property short shortDefault;               Ts,VshortDefault
//  @property signed signedDefault;             Ti,VsignedDefault
//  @property struct YorkshireTeaStruct structDefault;  T{YorkshireTeaStruct="pot"i"lady"c},VstructDefault
//  @property YorkshireTeaStructType typedefDefault;    T{YorkshireTeaStruct="pot"i"lady"c},VtypedefDefault
//  @property union MoneyUnion unionDefault;            T(MoneyUnion="alone"f"down"d),VunionDefault
//  @property unsigned unsignedDefault;                 TI,VunsignedDefault
//  @property int (*functionPointerDefault)(char *);    T^?,VfunctionPointerDefault
//  @property id idDefault;\
    Note: the compiler warns: "no 'assign', 'retain', or 'copy' attribute is specified - 'assign' is assumed"\
                                                        T@,VidDefault
//  @property int *intPointer;                          T^i,VintPointer
//  @property void *voidPointerDefault;                 T^v,VvoidPointerDefault
//  @property int intSynthEquals;\
    In the implementation block:\
    @synthesize intSynthEquals=_intSynthEquals;\
                                                        Ti,V_intSynthEquals
//  @property(getter=intGetFoo, setter=intSetFoo:) int intSetterGetter;\
                                                        Ti,GintGetFoo,SintSetFoo:,VintSetterGetter
//  @property(readonly) int intReadonly;                Ti,R,VintReadonly
//  @property(getter=isIntReadOnlyGetter, readonly) int intReadonlyGetter;\
                                                        Ti,R,GisIntReadOnlyGetter
//  @property(readwrite) int intReadwrite;              Ti,VintReadwrite
//  @property(assign) int intAssign;                    Ti,VintAssign
//  @property(retain) id idRetain;                      T@,&,VidRetain
//  @property(copy) id idCopy;                          T@,C,VidCopy
//  @property(nonatomic) int intNonatomic;              Ti,VintNonatomic
//  @property(nonatomic, readonly, copy) id idReadonlyCopyNonatomic;\
                                                        T@,R,C,VidReadonlyCopyNonatomic
//  @property(nonatomic, readonly, retain) id idReadonlyRetainNonatomic;\
                                                        T@,R,&,VidReadonlyRetainNonatomic
+ (NSArray *)typesForProperties:(NSArray *)properties;

+ (NSArray *)types;
+ (NSArray *)typesUntilClass:(Class)baseClass;

+ (NSArray *)shorttypesForProperties:(NSArray *)properties; // shorttype 是取出第一段

+ (NSArray *)shorttypes;
+ (NSArray *)shorttypesUntilClass:(Class)baseClass;

@end
