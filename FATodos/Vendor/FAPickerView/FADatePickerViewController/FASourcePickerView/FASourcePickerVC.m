//
//  QQPurchaseClassNumberPickerVC.m
//  QQing
//
//  Created by 陶澄 on 16/1/18.
//
//

#import "QQPurchaseClassNumberPickerVC.h"
#import "AppDelegate.h"

#define PickerViewHeight             202

@interface FASourcePickerVC ()
// 包含pickerview，取消按钮，确定按钮的view
@property (weak,   nonatomic) IBOutlet UIView       *classTimePickerBackgroundView;
// 购买可次的pickerview
@property (weak,   nonatomic) IBOutlet UIPickerView *classTimePickerView;
@property (weak,   nonatomic) IBOutlet NSLayoutConstraint *pickerBackgroundViewBottonContrainst;

@property (assign,   nonatomic) int maxNumber;
@property (assign,   nonatomic) int minNumber;
@property (assign,   nonatomic) int currentNumber;
@property (assign,   nonatomic) BOOL canSelectLessNumber;

@end

@implementation QQPurchaseClassNumberPickerVC

- (id)initWithMaxNumber:(int)maxNumber
          withMinNumber:(int)minNumber
      withCurrentNumber:(int)currentNumber
withCanSelectLessNumber:(BOOL)canSelectLessNumber {
    if (self = [super init]) {
        self.maxNumber = maxNumber;
        self.minNumber = minNumber;
        self.currentNumber = currentNumber;
        self.canSelectLessNumber = canSelectLessNumber;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.view.frame = CGRectMake(0, 0, [UIScreen width], [UIScreen height]);
    [self.classTimePickerView reloadAllComponents];
    if (self.canSelectLessNumber) {
        [self.classTimePickerView selectRow:self.currentNumber inComponent:0 animated:NO];
    } else {
        [self.classTimePickerView selectRow:self.currentNumber-self.minNumber+1 inComponent:0 animated:NO];
    }
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
        self.classTimePickerBackgroundView.frame = CGRectMake(0, self.view.frame.size.height, [UIScreen width], PickerViewHeight);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)showPickerView {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1;
        self.classTimePickerBackgroundView.alpha = 1;
        self.pickerBackgroundViewBottonContrainst.constant = 0;
        self.classTimePickerBackgroundView.frame = CGRectMake(0, self.view.frame.size.height - PickerViewHeight, [UIScreen width], PickerViewHeight);
    }];
}

- (void)show {
    [[AppDelegate sharedAppDelegate].window.rootViewController addChildViewController:self];
    [[AppDelegate sharedAppDelegate].window.rootViewController.view addSubview:self.view];
    [self showPickerView];
}

#pragma mark - PickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.canSelectLessNumber) {
        return self.maxNumber;
    } else {
        return self.maxNumber - self.minNumber + 1;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.canSelectLessNumber) {
        return [NSString stringWithFormat:@"%ld 次",(long)row+1];
    } else {
        return [NSString stringWithFormat:@"%ld 次",(long)row+self.minNumber];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.canSelectLessNumber) {
        self.currentNumber = (int)row + 1;
    } else {
        self.currentNumber = (int)row + self.minNumber;
    }
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(QQPurchaseClassNumberPickerVCDidCancel)]) {
        [self.delegate QQPurchaseClassNumberPickerVCDidCancel];
    }
}

- (IBAction)pickerViewDidClickedOnDoneBtn:(id)sender {
    [self hidePickerView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(QQPurchaseClassNumberPickerVCDidClickedDoneBtnWithNumber:)]) {
        [self.delegate QQPurchaseClassNumberPickerVCDidClickedDoneBtnWithNumber:self.currentNumber];
    }
}

@end
