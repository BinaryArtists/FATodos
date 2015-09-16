#import <UIKit/UIKit.h>

// UITableViewCell+Base
// 仅用于写法约定

@interface UITableViewCell (Base)

+ (NSString *)identifier;
+ (UINib *)nib;

- (CGFloat)cellHeight;
- (void)setModel:(id)model;

@end
