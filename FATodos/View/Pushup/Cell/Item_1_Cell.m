//
//  Item_1_Cell.m
//  FATodos
//
//  Created by 李杰 on 9/9/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "Item_1_Cell.h"

@interface Item_1_Cell () <AKPickerViewDataSource, AKPickerViewDelegate>

@property (nonatomic, weak) Item1 *item;

// PickerView
@property (nonatomic, strong) NSArray *roundData;

@end

@implementation Item_1_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initPickerViewWithModel:(Item1 *)item {
    [self initPickerView:self.round_1_pickerView withIndex:item.num_3];
    
    [self initPickerView:self.round_2_pickerView withIndex:item.num_2];
    
    [self initPickerView:self.round_3_pickerView withIndex:item.num_3];
}

- (void)setModel:(id)model {
    Item1 *item         = model;
    
    self.nameLabel.text = item.name;
    
    // state control
    
    UITapGestureRecognizer *doubleTapGestureRecognizer  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTappedOnCell:)];
    doubleTapGestureRecognizer.numberOfTapsRequired     = 2;
    doubleTapGestureRecognizer.cancelsTouchesInView     = NO;
    doubleTapGestureRecognizer.delegate                 = self;
//    [self addGestureRecognizer:doubleTapGestureRecognizer];
    
    // 用长按吧，然后弹起来～～～
    
    [self initPickerViewWithModel:item];
    
    self.item          = model;
}

- (CGFloat)cellHeight {
    return self.round_1_pickerViewHeightConstraint.constant;
}

#pragma mark - 

- (void)doubleTappedOnCell:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  todo:
     
        左右编辑态 和 数字编辑态 是互斥的！
     */
    
    if (self.transitionDelegate &&
        [self.transitionDelegate respondsToSelector:@selector(item_1_CellShouldExpandForEditing:)]) {
        if ([self.transitionDelegate item_1_CellShouldExpandForEditing:self]) {
            
            if (self.displayState == kItem_1_CellDisplayNormal) {
                // expand
                
            } else {
                // back
            }
            
        }
    }
}

#pragma mark - Utility

- (void)initPickerView:(AKPickerView *)pickerView withIndex:(NSInteger)index {
    pickerView.delegate             = self;
    pickerView.dataSource           = self;
    pickerView.autoresizingMask     = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    pickerView.font                 = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    pickerView.highlightedFont      = [UIFont fontWithName:@"HelveticaNeue" size:20];
    pickerView.interitemSpacing     = 20.0;
    pickerView.fisheyeFactor        = 0.001;
    pickerView.pickerViewStyle      = AKPickerViewStyle3D;
    pickerView.maskDisabled         = false;
    
    /**
     *  todo:
     
     *  可以根据统计，当量上去之后，区间也跟上去，下来，也跟着下来
     */
    self.roundData                  = @[@10, @15, @20, @25, @30, @35, @40, @45, @50, @55, @60, @65, @70, @75, @80];
    
    [pickerView reloadData];
}

#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView {
    return [self.roundData count];
}

/*
 * AKPickerView now support images!
 *
 * Please comment '-pickerView:titleForItem:' entirely
 * and uncomment '-pickerView:imageForItem:' to see how it works.
 *
 */

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item {
    return self.roundData[item];
}

/*
 - (UIImage *)pickerView:(AKPickerView *)pickerView imageForItem:(NSInteger)item {
	return [UIImage imageNamed:self.titles[item]];
 }
 */

#pragma mark - AKPickerViewDelegate

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item {
    NSLog(@"%@", self.roundData[item]);
    
    
    if (self.round_1_pickerView == pickerView) {
        self.item.num_1     = [self.roundData[item] intValue];
    } else if (self.round_2_pickerView == pickerView) {
        self.item.num_2     = [self.roundData[item] intValue];
    } else {
        self.item.num_3     = [self.roundData[item] intValue];
    }
}


/*
 * Label Customization
 *
 * You can customize labels by their any properties (except font,)
 * and margin around text.
 * These methods are optional, and ignored when using images.
 *
 */

/*
 - (void)pickerView:(AKPickerView *)pickerView configureLabel:(UILabel *const)label forItem:(NSInteger)item {
	label.textColor = [UIColor lightGrayColor];
	label.highlightedTextColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor colorWithHue:(float)item/(float)self.titles.count
 saturation:1.0
 brightness:1.0
 alpha:1.0];
 }
 */

/*
 - (CGSize)pickerView:(AKPickerView *)pickerView marginForItem:(NSInteger)item {
	return CGSizeMake(40, 20);
 }
 */

#pragma mark - UIScrollViewDelegate

/*
 * AKPickerViewDelegate inherits UIScrollViewDelegate.
 * You can use UIScrollViewDelegate methods
 * by simply setting pickerView's delegate.
 *
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Too noisy...
    // NSLog(@"%f", scrollView.contentOffset.x);
}

@end
