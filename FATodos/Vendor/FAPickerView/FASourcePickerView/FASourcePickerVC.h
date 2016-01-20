
#import <UIKit/UIKit.h>

@protocol FASourcePickerVCDelegate;

/**
 *  todo-fallenink
 */

@interface FASourcePickerVC : UIViewController

// 代理
@property (nonatomic, weak) id<FASourcePickerVCDelegate> delegate;
// 数据源
@property (nonatomic, strong) NSMutableArray<NSString *> *dataSource;
@property (nonatomic, assign) int32_t   initialIndex;
// 是否显示：取消、确定
@property (nonatomic, assign) BOOL toolBarHidden;
// 其他颜色配置，从简

- (void)show;
- (void)dismiss;

@end

/**
 *
 */

@protocol FASourcePickerVCDelegate <NSObject>

- (void)FASourcePickerVC:(FASourcePickerVC *)vc didSelectAtIndex:(int32_t)index;

@optional

- (void)FASourcePickerVCDidCancel;

@end
