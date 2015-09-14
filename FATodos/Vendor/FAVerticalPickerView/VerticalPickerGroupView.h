//
//  VerticalPickerComponentView.h
//  FATodos
//
//  Created by 李杰 on 9/13/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

// todo; 参考 QQDatePickerViewController

@interface VerticalPickerGroupView : UIView

@end

/**
 *  纵向 选择器组 数据源
 */
@protocol VerticalPickerGroupViewDataSource <NSObject>

- (NSInteger)numberOfGroupsInPickerView;

- (NSInteger)pickerGroupView:(VerticalPickerGroupView *)pickerGroupView numberOfRowsInGroup:(NSInteger)group;

@end

/**
 *  纵向 选择器组 代理
 */
@protocol VerticalPickerGroupViewDelegate <NSObject>

- (CGFloat)pickerView:(VerticalPickerGroupView *)pickerView
    widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(MyPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

- (NSString *)pickerView:(VerticalPickerGroupView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component;

//- (UIView *)pickerView:(MyPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(VerticalPickerGroupView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component;

@end