//
//  UIUtils.m
//  QQing
//
//  Created by fallen.ink on 3/1/15.
//
//

#import "UIUtils.h"

@implementation UIUtils

+ (void)viewWithCorner:(UIView *)view withRadius:(CGFloat)radius {
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+ (CGFloat)statusHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

+ (CGFloat)navigationBarHeight {
    UINavigationController *vc =[UINavigationController new];
    CGRect rectNav = [vc.navigationBar frame];
    return rectNav.size.height;
}

+ (CGFloat)tabBarHeight {
    UITabBarController *vc = [UITabBarController new];
    CGRect rectTab = [vc.tabBar frame];
    return rectTab.size.height;
}

+ (CGFloat)keyboardHeightFromNotificationUserInfo:(NSDictionary *)userInfo {
    CGFloat currentKeyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
#ifdef __IPHONE_8_0
    //以下代码主要是为了让iOS8SDK＋iOS8之后的设备得到的键盘尺寸与iOS8SDK之前的计算方法保持一致
    if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
        && UIDeviceOrientationIsLandscape((UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation)) {
        currentKeyboardHeight = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.width;
    }
#endif
    
    return currentKeyboardHeight;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (UILabel *)labelWith:(NSString *)text size:(CGFloat)size color:(UIColor *)color {
    UILabel *lbl = [[UILabel alloc] init];
    
    // fixme 应该自动计算长宽
    lbl.font = [UIFont systemFontOfSize:size];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = color;
    lbl.numberOfLines = 0;
    lbl.lineBreakMode = NSLineBreakByCharWrapping;
    lbl.text = text;
    
    CGSize contentSize = [text sizeWithFont:lbl.font
                          constrainedToSize:CGSizeZero
                              lineBreakMode:NSLineBreakByWordWrapping];
    lbl.width = contentSize.width;
    lbl.height = contentSize.height;
    
    return lbl;
}

+ (void)setViewStyle:(UIView*)view {
    if (!view) {
        return;
    }
    view.layer.borderColor = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:.1].CGColor;
    view.layer.borderWidth = 1;
}

+ (void)setButtonStyle:(UIButton *)btn andColor:(UIColor *)color{
    btn.layer.cornerRadius = 4.0;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = color.CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitleColor:color forState:UIControlStateNormal];
}

+ (void)setTextFieldStyle:(UITextField *)textField andTitle:(NSString *)text{

    if (text) {
        UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        phoneLbl.backgroundColor = [UIColor clearColor];
        phoneLbl.textColor = [UIColor gray_1_color];
        phoneLbl.text = text;
        phoneLbl.font = [UIFont systemFontOfSize:16];
        
        textField.leftView = phoneLbl;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.textColor = [UIColor gray_1_color];
        
        [textField setValue:[UIColor gray_1_color] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

    }else{
    
        textField.textColor = [UIColor gray_1_color];
    }
}

+ (float)textSizeWithFont:(UIFont *)font andTextString:(NSString *)text andSize:(CGSize)size {
    NSRange allRange = [text rangeOfString:text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];

    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:allRange];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect Size = [attrStr boundingRectWithSize:size
                                               options:options
                                               context:nil];
    float Height = ceilf(Size.size.height);
    return Height;
}

@end
