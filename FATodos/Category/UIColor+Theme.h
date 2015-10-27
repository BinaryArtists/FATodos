//
//  UIColor+Theme.h
//  FATodos
//
//  Created by fallen.ink on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

// 外面图标颜色：151 195 255  浅蓝色

/**
 *  删除键
 */
+ (UIColor *)red_1_color;

/**
 *  俯卧撑
 */
+ (UIColor *)blue_1_color;

/**
 *  哑铃
 */
+ (UIColor *)green_1_color;

/**
 *
 */
+ (UIColor *)yellow_1_color;

/**
 *
 */
+ (UIColor *)gray_1_color;

#pragma mark - 

+ (UIColor *)fontGray001Color;

+ (UIColor *)fontGray002Color;

#pragma mark - 

+ (UIColor *)bgGrayColor;

#pragma mark - 小清新

+ (UIColor *)lightGreenColor;

+ (UIColor *)lightYellowColor;

+ (UIColor *)lightGrayColor;

+ (UIColor *)brightGreenColor;

+ (UIColor *)flatBlueColor;

#pragma mark - 便签 列表颜色

+ (UIColor *)memoDarkGreenColor;
+ (UIColor *)memoBrightGreenColor;
+ (UIColor *)memoLightGreenColor;

+ (UIColor *)memoDarkPurpleColor;
+ (UIColor *)memoLightPurpleColor;

+ (UIColor *)memoLightPinkColor;
+ (UIColor *)memoBrightPinkColor;
+ (UIColor *)memoDarkPinkColor;

+ (UIColor *)memoLightRedColor;

#pragma mark - 四象限 块颜色
// 抄的Quad的，需要再设计，fixme

+ (UIColor *)quadrantGrayColor;
+ (UIColor *)quadrantRedColor;
+ (UIColor *)quadrantBlueColor;
+ (UIColor *)quadrantGreenColor;

@end
