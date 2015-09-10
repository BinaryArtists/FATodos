//
//  Item_1_Cell.h
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Item_1_CellDisplayState) {
    /* 正常态
     
     * 1. picker显示一个
     */
    kItem_1_CellDisplayNormal,
    /* 展开态
     
     * 1. picker显示三个
     * 2. cell响应拉长
     * 3. 只有一个cell可以伸展
     */
    kItem_1_CellDisplayExpand,
};

@class Item_1_Cell;

@protocol Item_1_CellDelegate <NSObject> // 双击 编辑
@optional

- (BOOL)item_1_CellShouldExpandForEditing:(Item_1_Cell *)cell;

- (void)item_1_CellDidExpand:(Item_1_Cell *)cell;

- (void)item_1_CellDidBack:(Item_1_Cell *)cell;

@end

@interface Item_1_Cell : SWTableViewCell

@property (nonatomic, assign) Item_1_CellDisplayState displayState;

@property (nonatomic, weak) id <Item_1_CellDelegate> transitionDelegate; // 状态变换

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AKPickerView *round_1_pickerView;
@property (weak, nonatomic) IBOutlet AKPickerView *round_2_pickerView;
@property (weak, nonatomic) IBOutlet AKPickerView *round_3_pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *round_1_pickerViewHeightConstraint;

- (void)setModel:(id)model;

- (CGFloat)cellHeight;

@end
