//
//  QQPurchaseClassNumberPickerVC.h
//  QQing
//
//  Created by 陶澄 on 16/1/18.
//
//

#import <UIKit/UIKit.h>

@protocol FASourcePickerVCDelegate;

/**
 *
 */

@interface FASourcePickerVC : UIViewController

@property (nonatomic, weak) id<FASourcePickerVCDelegate> delegate;
@property (nonatomic, weak) NSMutableArray *dataSource;
@property (nonatomic, assign) toolBar

- (void)show;

@end

/**
 *
 */

@protocol FASourcePickerVCDelegate <NSObject>

- (void)FASourcePickerVC:() didSelectAtIndex:(int32_t)index;

@optional

- (void)FASourcePickerVCDidCancel;

@end
