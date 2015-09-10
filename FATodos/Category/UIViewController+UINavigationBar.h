#import <UIKit/UIKit.h>

@interface UIViewController (UINavigationBar)

@property (nonatomic, strong) NSString *navTitleString;
@property (nonatomic, strong) UIView *navTitleView;

- (void)setNavLeftItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action;

- (void)setNavRightItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action;

@end
