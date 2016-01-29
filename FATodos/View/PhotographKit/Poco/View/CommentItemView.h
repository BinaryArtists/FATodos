//
//  CommentItemView.h
//  FATodos
//
//  Created by qingqing on 16/1/28.
//  Copyright © 2016年 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentItemView : UIView

@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *wishCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
