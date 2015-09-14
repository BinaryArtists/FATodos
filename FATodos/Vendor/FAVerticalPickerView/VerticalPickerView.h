//
//  VerticalPickerView.h
//  FATodos
//
//  Created by 李杰 on 9/13/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 */

@interface VerticalPickerView : UIView

@end

/**
 *  纵向 选择器 数据源
 */
@protocol VerticalPickerViewDataSource <NSObject>



@end

/**
 *  纵向 选择器 代理
 */
@protocol VerticalPickerViewDelegate <NSObject>

- (CGFloat)pickerView:(VerticalPickerView *)pickerView
    widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(MyPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

- (NSString *)pickerView:(VerticalPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;

//- (UIView *)pickerView:(MyPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(VerticalPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component;

@end