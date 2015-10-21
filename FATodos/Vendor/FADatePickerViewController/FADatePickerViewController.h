//
//  QQDatePickerViewController.h
//  QQing
//
//  Created by fallen.ink on 5/4/15.
//
//

#import <UIKit/UIKit.h>

@class FADatePickerViewController;

/**
 *  delegate of QQDatePickerViewController
 */
@protocol FADatePickerViewControllerDelegate <NSObject>

/**
 *  This method is called when user picked a certain date.
 
 *  @param vc       The date picking view controller that just finished picking a date.
 *  @param aDate    The picked date.
 */
- (void)datePickerViewController:(FADatePickerViewController *)vc didPickDate:(NSDate *)aDate;

@optional

/**
 * This method is called when the user clicked the cancel button or taps the blank background erea.
 
 * @param vc
 */
- (void)datePickerViewControllerDidCancel:(FADatePickerViewController *)vc;

@end

/**
 *
 */

@interface FADatePickerViewController : UIViewController

@property (nonatomic, weak)     id<FADatePickerViewControllerDelegate> delegate;

@property (nonatomic, assign)   BOOL backgroundTapsDisabled;

@property (nonatomic, strong)   UIColor *tintColor;

@property (nonatomic, strong)   UIColor *topBarBackgroundColor;

@property (nonatomic, strong)   UIColor *pickerBackgroundColor;

/**
 *
 */
+ (id)datePickerController;

/**
 *
 */
+ (void)setTitleForSelectButton:(NSString *)title;

+ (void)setTitleForCancelButton:(NSString *)title;

/**
 *  Class method for Default setting, YearMonthPickerView
 */

+ (void)setYearFirst:(BOOL)yearFirst;

+ (void)setMinimumYear:(NSInteger)minimumYear;

+ (void)setMaximumYear:(NSInteger)maximumYear;


/**
 *
 */

- (void)show;

- (void)dismiss;


@end



/**
 *  The YearMonthPickerView class implements an object that uses multiple rotating
 *  wheels to allow users to select a month and year.
 */
@interface YearMonthPickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate>

/**
 The date represented by the month picker.
 
 The day component is ignored when written, and set to 1 when read.
 */
@property (nonatomic, strong) NSDate* date;

/**
 *  The calendar currently being used
 */
@property (nonatomic, strong, readonly) NSCalendar *calendar;

/**
 *  The minimum year that a month picker can show
 */
@property (nonatomic) NSInteger minimumYear;

/**
 *  The maximum year that a month picker can show
 */
@property (nonatomic) NSInteger maximumYear;

/**
 *  A Boolean value that determines whether the year is shown first
 */
@property (nonatomic) BOOL yearFirst;

/**
 *  A Boolean value that determines whether the month wraps
 */
@property (nonatomic) BOOL wrapMonths;

/**
 *  A Boolean value that determines whether the current month & year are coloured
 */
@property (nonatomic) BOOL enableColourRow;

/**
 *  en-US alias for `enableColourRow`
 */
@property (nonatomic, getter = enableColourRow, setter = setEnableColourRow:) BOOL enableColorRow;

/**
 *  Font to be used for all rows.  Default: System Bold, size 24
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  Colour to be used for all "non coloured" rows.  Default: Black
 */
@property (nonatomic, strong) UIColor *fontColour;

/**
 *  en-US alias for `fontColour`
 */
@property (nonatomic, strong, getter = fontColour, setter = setFontColour:) UIColor *fontColor;

- (id)init;

- (id)initWithDate:(NSDate *)date;

- (id)initWithDate:(NSDate *)date calendar:(NSCalendar *)calendar;

@end
