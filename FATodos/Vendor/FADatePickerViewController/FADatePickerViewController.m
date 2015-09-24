//
//  QQDatePickerViewController.m
//  QQing
//
//  Created by 李杰 on 5/4/15.
//
//

#import "FADatePickerViewController.h"

/**
 *  Category of NSDate, Rounding
 */

@interface NSDate (Rounding)

- (NSDate *)dateByRoundingToMiniutes:(NSInteger)minutes;

@end

@implementation NSDate (Rounding)

- (NSDate *)dateByRoundingToMiniutes:(NSInteger)minutes {
    NSTimeInterval absoluteTime = floor([self timeIntervalSinceReferenceDate]);
    NSTimeInterval minuteInterval = minutes*60;
    
    NSTimeInterval remainder = (absoluteTime - (floor(absoluteTime/minuteInterval)*minuteInterval));
    if(remainder < 60) {
        return self;
    } else {
        NSTimeInterval remainingSeconds = minuteInterval - remainder;
        return [self dateByAddingTimeInterval:remainingSeconds];
    }
}

@end

/**
 *
 
 
 */

#define RM_DATE_PICKER_HEIGHT_PORTRAIT 216
#define RM_DATE_PICKER_HEIGHT_LANDSCAPE 162

@interface FADatePickerViewController ()

@property (nonatomic, strong)   UIWindow *window;
@property (nonatomic, strong)   UIViewController *rootViewController;
@property (nonatomic, strong)   UIView *backgroundView;

@property (nonatomic, strong)   NSLayoutConstraint *pickerHeightConstraint;

@property (nonatomic, weak)     NSLayoutConstraint *xConstraint;
@property (nonatomic, weak)     NSLayoutConstraint *yConstraint;
@property (nonatomic, weak)     NSLayoutConstraint *widthConstraint;

@property (nonatomic, strong)   UIView *topBarContentView;
@property (nonatomic, strong)   UIView *datePickerContentView;

@property (nonatomic, strong)   YearMonthPickerView *datePicker;

@property (nonatomic, strong)   UIButton *cancelButton;
@property (nonatomic, strong)   UIButton *selectButton;

@property (nonatomic, strong)   UIMotionEffectGroup *motionEffectGroup;

@property (nonatomic, assign)   BOOL hasBeenDismissed;

@end

@implementation FADatePickerViewController

#pragma mark - Class 

+ (id)datePickerController {
    return [[FADatePickerViewController alloc] init];
}

static NSString *_selectTitle = @"选择";
static NSString *_cancelTitle = @"取消";

+ (void)setTitleForSelectButton:(NSString *)title {
    _selectTitle = title;
}

+ (void)setTitleForCancelButton:(NSString *)title {
    _cancelTitle = title;
}

+ (NSString *)titleForSelectButton {
    return _selectTitle;
}

+ (NSString *)titleForCancelButton {
    return _cancelTitle;
}

static BOOL _yearFirst = YES;
static NSInteger _minimumYear = 0;
static NSInteger _maximumYear = NSIntegerMax;

+ (void)setYearFirst:(BOOL)yearFirst {
    _yearFirst = yearFirst;
}

+ (void)setMinimumYear:(NSInteger)minimumYear {
    _minimumYear = minimumYear;
}

+ (void)setMaximumYear:(NSInteger)maximumYear {
    // fixme: 应该设置为明年？
    _maximumYear = maximumYear;
}

#pragma mark - Initialization

- (id)init {
    if (self = [super init]) {
        [self initUIReleated];
    }
    
    return self;
}

- (void)initUIReleated {
    self.datePicker = [[YearMonthPickerView alloc] initWithDate:[NSDate date]];
    self.datePicker.layer.cornerRadius = 4;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self initDatePickerParam];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.cancelButton setTitle:[FADatePickerViewController titleForCancelButton] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(didPressedOnCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.selectButton setTitle:[FADatePickerViewController titleForSelectButton] forState:UIControlStateNormal];
    [self.selectButton addTarget:self action:@selector(didPressedOnDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.selectButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.selectButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.selectButton setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)initSubviewsLayout {
    self.topBarContentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.datePickerContentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    {
        [self.topBarContentView addSubview:self.cancelButton];
        [self.topBarContentView addSubview:self.selectButton];
        
        [self.datePickerContentView addSubview:self.datePicker];

        self.topBarContentView.backgroundColor = [UIColor whiteColor];
        self.datePickerContentView.backgroundColor = [UIColor whiteColor];
    }
    
    self.datePickerContentView.clipsToBounds = YES;
    self.datePickerContentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.topBarContentView.clipsToBounds = YES;
    self.topBarContentView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)initUIConstraint {
    UIView *topBarContentView = self.topBarContentView;
    UIView *datePickerContentView = self.datePickerContentView;
    UIButton *cancel = self.cancelButton;
    UIButton *select = self.selectButton;
    YearMonthPickerView *picker = self.datePicker;
    
    NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(topBarContentView, datePickerContentView, cancel, select, picker);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[topBarContentView]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[datePickerContentView]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[topBarContentView(40)]-(0)-[datePickerContentView]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    self.pickerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.datePickerContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:RM_DATE_PICKER_HEIGHT_PORTRAIT];
    [self.view addConstraint:self.pickerHeightConstraint];
    
    [self.topBarContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(15)-[cancel(46)]" options:0 metrics:nil views:bindingsDict]];
    [self.topBarContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[select(46)]-(15)-|" options:0 metrics:nil views:bindingsDict]];
    [self.topBarContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[cancel(30)]-(5)-|" options:0 metrics:nil views:bindingsDict]];
    [self.topBarContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(5)-[select(30)]-(5)-|" options:0 metrics:nil views:bindingsDict]];
    
    [self.datePickerContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[picker]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    [self.datePickerContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[picker]-(0)-|" options:0 metrics:nil views:bindingsDict]];
}

- (void)initDatePickerParam {
    self.datePicker.yearFirst = _yearFirst;
    self.datePicker.minimumYear = _minimumYear;
    self.datePicker.maximumYear = _maximumYear;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.layer.masksToBounds = YES;
    
    [self initSubviewsLayout];
    
    [self.view addSubview:self.topBarContentView];
    [self.view addSubview:self.datePickerContentView];
    
    [self initUIConstraint];
    
    [self initDatePickerParam];
    
    if (self.topBarBackgroundColor) {
        self.topBarContentView.backgroundColor = self.topBarBackgroundColor;
    }
    if (self.pickerBackgroundColor) {
        self.datePickerContentView.backgroundColor = self.pickerBackgroundColor;
    }
    
    [self addMotionEffects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handle

- (IBAction)didPressedOnDoneButton:(id)sender {
    if(!self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
        // Get date selected
        [self.delegate datePickerViewController:self didPickDate:self.datePicker.date];

        [self dismiss];
        //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
    }
}

- (IBAction)didPressedOnCancelButton:(id)sender {
    if(!self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
        if ([self.delegate respondsToSelector:@selector(datePickerViewControllerDidCancel:)]) {
            [self.delegate datePickerViewControllerDidCancel:self];
        }
        
        [self dismiss];
        //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
    }
}

- (IBAction)didTappedOnBackgroundView:(UIGestureRecognizer *)sender {
    if(!self.backgroundTapsDisabled && !self.hasBeenDismissed) {
        self.hasBeenDismissed = YES;
        
        if ([self.delegate respondsToSelector:@selector(datePickerViewControllerDidCancel:)]) {
            [self.delegate datePickerViewControllerDidCancel:self];
        }
        
        [self dismiss];
        //[self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
    }
}

#pragma mark - Properties

- (UIMotionEffectGroup *)motionEffectGroup {
    if(!_motionEffectGroup) {
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-10);
        verticalMotionEffect.maximumRelativeValue = @(10);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-10);
        horizontalMotionEffect.maximumRelativeValue = @(10);
        
        _motionEffectGroup = [UIMotionEffectGroup new];
        _motionEffectGroup.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    }
    
    return _motionEffectGroup;
}

- (UIWindow *)window {
    if (!_window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.windowLevel = UIWindowLevelStatusBar;
        
        UIViewController *rootViewController = [[UIViewController alloc] init];
        _window.rootViewController = rootViewController;
    }
    
    return _window;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedOnBackgroundView:)];
        [_backgroundView addGestureRecognizer:tapRecognizer];
    }
    
    return _backgroundView;
}

- (void)setTintColor:(UIColor *)newTintColor {
    if(_tintColor != newTintColor) {
        _tintColor = newTintColor;

        self.cancelButton.tintColor = newTintColor;
        self.selectButton.tintColor = newTintColor;
    }
}

- (void)setTopBarBackgroundColor:(UIColor *)newBackgroundColor {
    if(_topBarBackgroundColor != newBackgroundColor) {
        _topBarBackgroundColor = newBackgroundColor;
        
        if ([self isViewLoaded]) {
            self.topBarContentView.backgroundColor = newBackgroundColor;
        }
    }
}

- (void)setPickerBackgroundColor:(UIColor *)newBackgroundColor {
    if(_pickerBackgroundColor != newBackgroundColor) {
        _pickerBackgroundColor = newBackgroundColor;
        
        if([self isViewLoaded]) {
            self.datePickerContentView.backgroundColor = newBackgroundColor;
        }
    }
}

#pragma mark - Utility

- (void)addMotionEffects {
    [self.view addMotionEffect:self.motionEffectGroup];
}

- (void)removeMotionEffects {
    [self.view removeMotionEffect:self.motionEffectGroup];
}
        
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Presenting

- (void)show {
    self.rootViewController = self.window.rootViewController;
    
    {
        [self.window makeKeyAndVisible];
        
        // If we start in landscape mode also update the windows frame to be accurate
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.window.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
        }
    }
    
    {
        self.backgroundView.alpha = 0;
        [self.rootViewController.view addSubview:self.backgroundView];
        
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
        [self.rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    }
    
    [self willMoveToParentViewController:self.rootViewController];
    [self viewWillAppear:YES];
    
    [self.rootViewController addChildViewController:self];
    [self.rootViewController.view addSubview:self.view];
    
    [self viewDidAppear:YES];
    [self didMoveToParentViewController:self.rootViewController];
    
    //CGFloat height = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            //height = RM_DATE_SELECTION_VIEW_HEIGHT_LANDSCAPE;
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_LANDSCAPE;
        } else {
            //height = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_PORTRAIT;
        }
    }
    
    self.xConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    self.widthConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self.rootViewController.view addConstraint:self.xConstraint];
    [self.rootViewController.view addConstraint:self.yConstraint];
    [self.rootViewController.view addConstraint:self.widthConstraint];
    
    [self.rootViewController.view setNeedsUpdateConstraints];
    [self.rootViewController.view layoutIfNeeded];
    
    [self.rootViewController.view removeConstraint:self.yConstraint];
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.rootViewController.view addConstraint:self.yConstraint];
    
    [self.rootViewController.view setNeedsUpdateConstraints];

    {
        self.topBarContentView.alpha = 0;
        self.datePickerContentView.alpha = 0;
        
        //[UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.8 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.backgroundView.alpha = 1;
            self.topBarContentView.alpha = 1;
            self.datePickerContentView.alpha = 1;
            
            [self.rootViewController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)dismiss {
    [self.rootViewController.view removeConstraint:self.yConstraint];
    self.yConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.rootViewController.view addConstraint:self.yConstraint];
    
    [self.rootViewController.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.backgroundView.alpha = 0;
        self.topBarContentView.alpha = 0;
        self.datePickerContentView.alpha = 0;
        
        [self.rootViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self willMoveToParentViewController:nil];
        [self viewWillDisappear:YES];
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        [self viewDidDisappear:YES];
        
        [self.backgroundView removeFromSuperview];
        self.window = nil;
        self.hasBeenDismissed = NO;
    }];
}

@end

/**
 
 
 */

#ifdef NSCalendarUnitMonth
#define NSCalendarUnitMonth NSMonthCalendarUnit
#endif

#ifdef NSCalendarUnitYear
#define NSCalendarUnitYear NSYearCalendarUnit
#endif

@interface YearMonthPickerView ()

@property (nonatomic) NSInteger monthComponent;
@property (nonatomic) NSInteger yearComponent;
@property (nonatomic, strong, readonly) NSArray* monthStrings;
@property (nonatomic, strong, readonly) NSDateFormatter* monthFormatter;
@property (nonatomic, strong, readonly) NSDateFormatter* yearFormatter;

- (void)prepare;
- (NSInteger)yearFromRow:(NSUInteger)row;
- (NSUInteger)rowFromYear:(NSInteger)year;

@end

@implementation YearMonthPickerView

static const NSInteger _monthRowMultiplier = 340;
static const NSInteger _defaultMinimumYear = 1;
static const NSInteger _defaultMaximumYear = 99999;
static const NSCalendarUnit _dateComponentFlags = NSCalendarUnitMonth | NSCalendarUnitYear;

#pragma mark - Initialization

- (id)initWithDate:(NSDate *)date calendar:(NSCalendar *)calendar {
    
    if (self = [super init]) {
        _calendar = calendar;
        
        [self prepare];
        [self setDate:date];
        
        self.showsSelectionIndicator = YES;
    }
    
    return self;
}

- (id)initWithDate:(NSDate *)date {
    self = [self initWithDate:date calendar:[NSCalendar currentCalendar]];
    return self;
}

- (id)init {
    self = [self initWithDate:[NSDate date] calendar:[NSCalendar currentCalendar]];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _minimumYear = _defaultMinimumYear;
        _maximumYear = _defaultMaximumYear;
        
        [self prepare];
        if (!_calendar) {
            _calendar = [NSCalendar currentCalendar];
        }
        
        if (!_date) {
            [self setDate:[NSDate date]];
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _minimumYear = _defaultMinimumYear;
        _maximumYear = _defaultMaximumYear;
        
        [self prepare];
        if (!_calendar)
            _calendar = [NSCalendar currentCalendar];
        if (!_date)
            [self setDate:[NSDate date]];
    }
    
    return self;
}

#pragma mark - Properties

- (id<UIPickerViewDelegate>)delegate {
    return self;
}

- (void)setDelegate:(id<UIPickerViewDelegate>)delegate {
    if ([delegate isEqual:self]) {
        [super setDelegate:delegate];
    }
}

- (id<UIPickerViewDataSource>)dataSource {
    return self;
}

- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource {
    if ([dataSource isEqual:self]) {
        [super setDataSource:dataSource];
    }
}

- (NSInteger)monthComponent {
    return self.yearComponent ^ 1;
}

- (NSInteger)yearComponent {
    return !self.yearFirst;
}

- (NSDateFormatter *)monthFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.calendar = self.calendar;
        formatter.dateFormat = @"M";
    });
    return formatter;
}

- (NSDateFormatter *)yearFormatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.calendar = self.calendar;
        formatter.dateFormat = @"y";
    });
    return formatter;
}

- (NSArray *)monthStrings {
    return self.monthFormatter.monthSymbols;
}

- (void)setYearFirst:(BOOL)yearFirst {
    _yearFirst = yearFirst;
    NSDate* date = self.date;
    
    [self reloadAllComponents];
    [self setNeedsLayout];
    [self setDate:date];
}

- (void)setMinimumYear:(NSInteger)minimumYear {
    NSDate* currentDate = self.date;
    NSDateComponents* components = [self.calendar components:_dateComponentFlags fromDate:currentDate];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    if (components.year < minimumYear) {
        components.year = minimumYear;
    }
    
    _minimumYear = minimumYear;
    [self reloadAllComponents];
    [self setDate:[self.calendar dateFromComponents:components]];
}

- (void)setMaximumYear:(NSInteger)maximumYear {
    NSDate* currentDate = self.date;
    NSDateComponents* components = [self.calendar components:_dateComponentFlags fromDate:currentDate];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    if (components.year > maximumYear) {
        components.year = maximumYear;
    }
    
    _maximumYear = maximumYear;
    [self reloadAllComponents];
    [self setDate:[self.calendar dateFromComponents:components]];
}

- (void)setWrapMonths:(BOOL)wrapMonths {
    _wrapMonths = wrapMonths;
    [self reloadAllComponents];
}

- (void)setDate:(NSDate *)date {
    NSDateComponents* components = [self.calendar components:_dateComponentFlags fromDate:date];
    components.timeZone = [NSTimeZone defaultTimeZone];
    
    if (self.minimumYear && components.year < self.minimumYear) {
        components.year = self.minimumYear;
    } else if (self.maximumYear && components.year > self.maximumYear) {
        components.year = self.maximumYear;
    }
    
    if(self.wrapMonths) {
        NSInteger monthMidpoint = self.monthStrings.count * (_monthRowMultiplier / 2);
        
        [self selectRow:(components.month - 1 + monthMidpoint) inComponent:self.monthComponent animated:NO];
    } else {
        [self selectRow:(components.month - 1) inComponent:self.monthComponent animated:NO];
    }
    
    [self selectRow:[self rowFromYear:components.year] inComponent:self.yearComponent animated:NO];
    
    _date = [self.calendar dateFromComponents:components];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.month = 1 + ([self selectedRowInComponent:self.monthComponent] % self.monthStrings.count);
    components.year = [self yearFromRow:[self selectedRowInComponent:self.yearComponent]];
    
    [self willChangeValueForKey:@"date"];
//    if ([self.monthPickerDelegate respondsToSelector:@selector(monthPickerWillChangeDate:)])
//        [self.monthPickerDelegate monthPickerWillChangeDate:self];
    
    _date = [self.calendar dateFromComponents:components];
    
//    if ([self.monthPickerDelegate respondsToSelector:@selector(monthPickerDidChangeDate:)])
//        [self.monthPickerDelegate monthPickerDidChangeDate:self];
    [self didChangeValueForKey:@"date"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == self.monthComponent && !self.wrapMonths) {
        return self.monthStrings.count;
    } else if (component == self.monthComponent) {
        return _monthRowMultiplier * self.monthStrings.count;
    }
    
    NSInteger maxYear = _defaultMaximumYear;
    if (self.maximumYear) {
        maxYear = self.maximumYear;
    }
    
    return [self rowFromYear:maxYear] + 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width/2;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    CGFloat width = [self pickerView:self widthForComponent:component];
    CGRect frame = CGRectMake(0.0f, 0.0f, width, 45.0f);
    
    if (component == self.monthComponent) {
        const CGFloat padding = 15.0f;
        if (component) {
            frame.origin.x += padding;
        }
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    
    NSDateFormatter* formatter = nil;
    
    if (component == self.monthComponent) {
        label.text = [self.monthStrings objectAtIndex:(row % self.monthStrings.count)];
        label.textAlignment = NSTextAlignmentCenter;//component ? NSTextAlignmentLeft : NSTextAlignmentRight;
        formatter = self.monthFormatter;
    } else {
        formatter = self.yearFormatter;
        
        label.text = [NSString stringWithFormat:@"%zd年", [self yearFromRow:row]];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    label.font = self.font;
    label.textColor = self.fontColour;
    
    if (self.enableColourRow && [[formatter stringFromDate:[NSDate date]] isEqualToString:label.text]) {
        label.textColor = [UIColor colorWithRed:0.0f green:0.35f blue:0.91f alpha:1.0f];
    }
    
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(0.0f, 0.1f);
    label.shadowColor = [UIColor whiteColor];
    
    return label;
}

#pragma mark - Private Methods

- (NSInteger)yearFromRow:(NSUInteger)row {
    NSInteger minYear = _defaultMinimumYear;
    
    if (self.minimumYear) {
        minYear = self.minimumYear;
    }
    
    return row + minYear;
}

- (NSUInteger)rowFromYear:(NSInteger)year {
    NSInteger minYear = _defaultMinimumYear;
    
    if (self.minimumYear) {
        minYear = self.minimumYear;
    }
    
    return year - minYear;
}

- (void)prepare {
    self.dataSource = self;
    self.delegate = self;
    
    self.enableColourRow = YES;
    self.wrapMonths = YES;
    
    self.font = [UIFont boldSystemFontOfSize:22.0f];
    self.fontColor = [UIColor blackColor];
}

@end
