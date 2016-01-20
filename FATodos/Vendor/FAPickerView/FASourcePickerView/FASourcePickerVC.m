
#import "FASourcePickerVC.h"

@interface WindowRootViewController : UIViewController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyleToSet;

+ (WindowRootViewController *)createRootViewControllerWithStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

@end

@implementation WindowRootViewController

+ (WindowRootViewController *)createRootViewControllerWithStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    WindowRootViewController *rootVC = [[WindowRootViewController alloc] init];
    rootVC.statusBarStyleToSet = statusBarStyle;
    return rootVC;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyleToSet;
}

@end

#define PickerViewHeight            202
#define ScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                [UIScreen mainScreen].bounds.size.height

@interface FASourcePickerVC ()
// 包含pickerview，取消按钮，确定按钮的view
@property (weak,   nonatomic) IBOutlet UIView       *classTimePickerBackgroundView;
// 购买可次的pickerview
@property (weak,   nonatomic) IBOutlet UIPickerView *classTimePickerView;
@property (weak,   nonatomic) IBOutlet NSLayoutConstraint *pickerBackgroundViewBottonContrainst;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController *rootViewController;

@end

@implementation FASourcePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGesture];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self.classTimePickerView reloadAllComponents];
    [self.classTimePickerView selectRow:self.initialIndex inComponent:0 animated:YES];
}

- (void)addGesture {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePickerViewSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handlePickerViewSingleTap:(UITapGestureRecognizer *)tap {
    [self hidePickerView];
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
        self.classTimePickerBackgroundView.frame = CGRectMake(0, self.view.frame.size.height, ScreenWidth, PickerViewHeight);
        
        [self.rootViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self willMoveToParentViewController:nil];
        [self viewWillDisappear:YES];
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        [self viewDidDisappear:YES];

        [self.window resignKeyWindow];
        self.window = nil;
        
        [self removeFromParentViewController];
    }];
}

- (void)showPickerView {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1;
        self.classTimePickerBackgroundView.alpha = 1;
        self.pickerBackgroundViewBottonContrainst.constant = 0;
        self.classTimePickerBackgroundView.frame = CGRectMake(0, self.view.frame.size.height - PickerViewHeight, ScreenWidth, PickerViewHeight);
    }];
}

- (void)show {
    // Use key window
//    UIWindow *keyWindow    = [UIApplication sharedApplication].keyWindow;
//    
//    [keyWindow.rootViewController addChildViewController:self];
//    [keyWindow.rootViewController.view addSubview:self.view];
    
    // Create a Window
    self.rootViewController = self.window.rootViewController;
    
    {
        [self.window makeKeyAndVisible];
        
        // If we start in landscape mode also update the windows frame to be accurate
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.window.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
        }
    }
    
    {
        [self.rootViewController.view addSubview:self.view];
    }
    
    [self willMoveToParentViewController:self.rootViewController];
    [self viewWillAppear:YES];
    
    [self.rootViewController addChildViewController:self];
    [self.rootViewController.view addSubview:self.view];
    
    [self viewDidAppear:YES];
    [self didMoveToParentViewController:self.rootViewController];
    
    [self.rootViewController.view setNeedsUpdateConstraints];
    [self.rootViewController.view layoutIfNeeded];

    [self showPickerView];
}

- (void)dismiss {
    [self hidePickerView];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataSource objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //
}

//自定义piker字体
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:22]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (IBAction)pickerViewDidClickedOnCancelBtn:(id)sender {
    [self hidePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(FASourcePickerVCDidCancel)]) {
        [self.delegate FASourcePickerVCDidCancel];
    }
}

- (IBAction)pickerViewDidClickedOnDoneBtn:(id)sender {
    [self hidePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(FASourcePickerVC:didSelectAtIndex:)]) {
        [self.delegate FASourcePickerVC:self didSelectAtIndex:0];
    }
}

#pragma mark - Property

- (UIWindow *)window {
    if (!_window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _window.windowLevel = UIWindowLevelStatusBar;
        
        WindowRootViewController *rootViewController = [WindowRootViewController createRootViewControllerWithStatusBarStyle:[UIApplication sharedApplication].statusBarStyle];
        _window.rootViewController = rootViewController;
    }
    
    return _window;
}

@end
