#import <UIKit/UIKit.h>

// UITableViewCell+Base
// 仅用于写法约定

@interface UITableViewCell (Base)

+ (NSString *)identifier;
+ (UINib *)nib;

- (CGFloat)cellHeight;
+ (CGFloat)cellHeightWithModel:(id)model;
+ (CGFloat)cellHeight;

- (void)setModel:(id)model;

#pragma mark - On UITableView

+ (void)registerOn:(UITableView *)tableView;

@end
