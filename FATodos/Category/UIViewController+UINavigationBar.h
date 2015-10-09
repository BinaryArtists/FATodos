#import <UIKit/UIKit.h>

#import "UINavigationItem+MultipleItems.h"

@interface UIViewController (UINavigationBar)

@property (nonatomic, strong) NSString *navTitleString;
@property (nonatomic, strong) UIView *navTitleView;

@property (nonatomic, strong) UIColor* navBarColor;     //改变导航栏背景颜色
@property (nonatomic, strong) UIColor* navTitleColor;   //改变导航栏标题颜色
@property (nonatomic, strong) UIColor* navLeftItemTitleColor; //改变导航栏左按钮标题颜色
@property (nonatomic, strong) UIColor* navRightItemTitleColor; //改变导航栏右边按钮标题颜色

- (void)setNavLeftItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action;

- (void)setNavRightItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action;

- (void)addNavLeftItemWithImage:(NSString*)image position:(UINavigationItemPosition)position target:(id)target action:(SEL)action;
- (void)addNavLeftItemWithName:(NSString*)name position:(UINavigationItemPosition)position target:(id)target action:(SEL)action;

- (void)addNavRightItemWithImage:(NSString*)image position:(UINavigationItemPosition)position target:(id)target action:(SEL)action;
- (void)addNavRightItemWithName:(NSString*)name position:(UINavigationItemPosition)position target:(id)target action:(SEL)action;

@end
