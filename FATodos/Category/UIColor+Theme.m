//
//  UIColor+Theme.m
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)red_1_color {
    return [UIColor colorWithRed:248.f/255
                           green:55.f/255
                            blue:59.f/255
                           alpha:1.f];
}

+ (UIColor *)blue_1_color {
    return [UIColor colorWithRed:133.f/255
                           green:206.f/255
                            blue:208.f/255
                           alpha:1.f];
}

+ (UIColor *)green_1_color {
    return [UIColor colorWithRed:32.f/255
                           green:182.f/255
                            blue:146.f/255
                           alpha:1.f];
}

+ (UIColor *)yellow_1_color {
    return [UIColor colorWithRed:211.f/255
                           green:206.f/255
                            blue:125.f/255
                           alpha:1.f];
}

+ (UIColor *)gray_1_color {
    return [UIColor colorWithRed:104.f/255
                           green:94.f/255
                            blue:109.f/255
                           alpha:1.f];
}

#pragma mark - 

+ (UIColor *)fontGray001Color {
    return [UIColor colorWithRed:153.f/255
                           green:153.f/255
                            blue:153.f/255
                           alpha:1.f];
}

+ (UIColor *)fontGray002Color {
    return [UIColor colorWithRed:102.f/255
                           green:102.f/255
                            blue:102.f/255
                           alpha:1.f];
}

#pragma mark - 

+ (UIColor *)bgGrayColor {
    return [UIColor darkGrayColor];
}

#pragma mark - 小清新

+ (UIColor *)lightGreenColor {
    return [UIColor colorWithRed:138.f/255
                           green:167.f/255
                            blue:151.f/255
                           alpha:1.f];
}

+ (UIColor *)lightYellowColor {
    return [UIColor colorWithRed:217.f/255
                           green:212.f/255
                            blue:80.f/255
                           alpha:1.f];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

+ (UIColor *)lightGrayColor {
    return [UIColor colorWithRed:201.f/255
                           green:217.f/255
                            blue:221.f/255
                           alpha:1.f];
}

#pragma clang dianostic pop

+ (UIColor *)brightGreenColor {
    return [UIColor colorWithRed:157.f/255
                           green:199.f/255
                            blue:38.f/255
                           alpha:1.f];
}

+ (UIColor *)flatBlueColor {
    return [UIColor colorWithRed:101.f/255
                           green:177.f/255
                            blue:181.f/255
                           alpha:1.f];
}

@end
