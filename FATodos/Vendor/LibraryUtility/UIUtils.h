//
//  UIUtils.h
//  QQing
//
//  Created by fallen.ink on 3/1/15.
//
//

#import <Foundation/Foundation.h>

#define PIXEL_2     2.f
#define PIXEL_4     4.f
#define PIXEL_8     8.f
#define PIXEL_12    12.f
#define PIXEL_16    16.f

#define PIXEL_40    40.f
#define PIXEL_56    56.f

#define kScreenWidth        [UIUtils screenWidth]
#define kScreenHeight       [UIUtils screenHeight]
#define kNavigationHeight   [UIUtils navigationBarHeight]
#define kStatusHeight       [UIUtils statusHeight]

@interface UIUtils : NSObject

/**
 * 设置视图风格，阴影
 */
+ (void)setViewStyle:(UIView *)view;
/**
* 设置TextField风格
*/
+ (void)setTextFieldStyle:(UITextField *)textField andTitle:(NSString *)text;

/**
 * 将view的边角磨圆, 上面可以废弃
 */
+ (void)viewWithCorner:(UIView *)view withRadius:(CGFloat)radius;

/**
 *  设置Button风格
 */
+ (void)setButtonStyle:(UIButton *)btn andColor:(UIColor *)color;

/**
 * 状态栏高度
 */
+ (CGFloat)statusHeight;

/**
 * 导航栏高度
 */
+ (CGFloat)navigationBarHeight;

/**
 * 状态栏高度
 */
+ (CGFloat)tabBarHeight;

/**
 * 键盘高度
 */
+ (CGFloat)keyboardHeightFromNotificationUserInfo:(NSDictionary *)userInfo;

/**
 * 屏幕高度
 */
+ (CGFloat)screenHeight;

/**
 * 屏幕宽度
 */
+ (CGFloat)screenWidth;

/**
 * 创建普通label
 
 * 默认左对齐
 * 默认单行
 */
+ (UILabel *)labelWith:(NSString *)text size:(CGFloat)size color:(UIColor *)color;
/**
 *  计算文字高度
 */
+ (float)textSizeWithFont:(UIFont *)font andTextString:(NSString *)text andSize:(CGSize)size;

@end
