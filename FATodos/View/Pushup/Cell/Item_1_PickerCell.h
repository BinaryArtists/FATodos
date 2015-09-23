//
//  Item_1_PickerCell.h
//  FATodos
//
//  Created by fallen.ink on 9/22/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item1;
@class PickerModel;

@interface Item_1_PickerCell : UITableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *round_1_pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *round_2_pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *round_3_pickerView;

@property (weak, nonatomic) Item1 *         item;
@property (weak, nonatomic) PickerModel *   pickerModel;

@end
