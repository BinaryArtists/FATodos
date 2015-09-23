//
//  Item_1_PickerCell.m
//  FATodos
//
//  Created by fallen.ink on 9/22/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Item_1_PickerCell.h"
#import "PickerModel.h"

@implementation Item_1_PickerCell

- (void)awakeFromNib {
    self.round_1_pickerView.backgroundColor     = [UIColor clearColor];
    self.round_2_pickerView.backgroundColor     = [UIColor clearColor];
    self.round_3_pickerView.backgroundColor     = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id)model {
    self.pickerModel = model;
    
    
    self.round_1_pickerView.delegate    = self;
    self.round_2_pickerView.delegate    = self;
    self.round_3_pickerView.delegate    = self;
    
    [self.round_1_pickerView reloadAllComponents];
    [self.round_2_pickerView reloadAllComponents];
    [self.round_3_pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerModel.titleArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100.f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36.f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *title = [self.pickerModel.titleArray objectAtIndex:row];
    CGFloat width = [self pickerView:pickerView widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 45.0f);
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];

    {
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    label.font = [UIFont systemFontOfSize:21.f];

    if (pickerView == self.round_1_pickerView) {
        label.textColor = [UIColor lightGreenColor];
    } else if (pickerView == self.round_2_pickerView) {
        label.textColor = [UIColor lightYellowColor];
    } else if (pickerView == self.round_3_pickerView) {
        label.textColor = [UIColor lightGrayColor];
    }

    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0.0f, 0.1f);
    label.shadowColor = [UIColor whiteColor];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *value = [self.pickerModel.titleArray objectAtIndex:row];
    
    if (pickerView == self.round_1_pickerView) {
        self.pickerModel.item.num_1 = [value intValue];
    } else if (pickerView == self.round_2_pickerView) {
        self.pickerModel.item.num_2 = [value intValue];
    } else if (pickerView == self.round_3_pickerView) {
        self.pickerModel.item.num_3 = [value intValue];
    }
}

#pragma mark - Property

- (PickerModel *)pickerModel {
    if (!_pickerModel) {
        return [PickerModel new];
    }
    
    return _pickerModel;
}

@end
