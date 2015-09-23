//
//  VerticalPickerView.h
//  FATodos
//
//  Created by 李杰 on 9/13/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerticalPickerViewDelegate;
@protocol VerticalPickerViewDataSource;


/**
 * 选择器
 */

@interface VerticalPickerView : UIView

@property (nonatomic, weak) id<VerticalPickerViewDelegate> delegate;
@property (nonatomic, weak) id<VerticalPickerViewDataSource> dataSource;

@end

/**
 *  纵向 选择器 数据源
 */
@protocol VerticalPickerViewDataSource <NSObject>

- (NSInteger)numberOfRowsInVerticalPickerView:(VerticalPickerView *)pickerView;

- (NSString *)verticalPickerView:(VerticalPickerView *)pickerView titleAtIndex:(NSUInteger)index;

@end

/**
 *  纵向 选择器 代理
 */
@protocol VerticalPickerViewDelegate <NSObject>

- (CGFloat)verticalPickerView:(VerticalPickerView *)pickerView heightForRowAtIndex:(NSInteger)index;

- (void)verticalPickerViewDidScroll:(VerticalPickerView *)pickerView;

- (void)verticalPickerView:(VerticalPickerView *)pickerView DidSelectRowAtIndex:(NSInteger)index;

@end