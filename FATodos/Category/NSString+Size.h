//
//  NSString+Size.h
//  QQing
//
//  Created by 李杰 on 2/13/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

//文字的行数
- (int)textLineNumWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

//文字放在一行时的宽高
- (CGSize)textSizeForOneLineWithFont:(UIFont *)font;

@end