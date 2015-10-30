#import "UITableViewCell+Base.h"

@implementation UITableViewCell (Base)

#pragma mark - Class

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self identifier] bundle:nil];
}

+ (CGFloat)cellHeight {
    return 0.f;
}

+ (CGFloat)cellHeightWithModel:(id)model {
    return 0.f;
}

#pragma mark - Object

- (CGFloat)cellHeight {
    return 0.f;
}

- (void)setModel:(id)model {
    // do nothing.
}

#pragma mark - On UITableView

+ (void)registerOn:(UITableView *)tableView {
    _assert_( tableView )
    
    [tableView registerNib:[self nib]
    forCellReuseIdentifier:[self identifier]];
}

@end
