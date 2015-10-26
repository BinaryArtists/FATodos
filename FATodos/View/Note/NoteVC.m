//
//  NoteVC.m
//  FATodos
//
//  Created by fallen.ink on 10/18/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import "NoteVC.h"
#import "CardView.h"

@interface NoteVC () <
    ZLSwipeableViewDataSource,
    ZLSwipeableViewDelegate
>

@property (weak, nonatomic) IBOutlet ZLSwipeableView *swipeableView;

@end

@implementation NoteVC

#pragma mark - Initialize

- (void)initSwipeableView {
    // Optional Delegate
    self.swipeableView.delegate = self;
    self.swipeableView.dataSource = self;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSwipeableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark - Action
//
//- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
//    [self.swipeableView swipeTopViewToLeft];
//}
//
//- (IBAction)swipeRightButtonAction:(UIButton *)sender {
//    [self.swipeableView swipeTopViewToRight];
//}
//- (IBAction)swipeUpButtonAction:(UIButton *)sender {
//    [self.swipeableView swipeTopViewToUp];
//}
//- (IBAction)swipeDownButtonAction:(UIButton *)sender {
//    [self.swipeableView swipeTopViewToDown];
//}
//
//- (IBAction)reloadButtonAction:(UIButton *)sender {
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"Load Cards"
//                                  delegate:self
//                                  cancelButtonTitle:@"Cancel"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"Programmatically", @"From Xib", nil];
//    [actionSheet showInView:self.view];
//}
//
//#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet
//clickedButtonAtIndex:(NSInteger)buttonIndex {
//    self.loadCardFromXib = buttonIndex == 1;
//    
//    self.colorIndex = 0;
//    
//    [self.swipeableView discardAllSwipeableViews];
//    [self.swipeableView loadNextSwipeableViewsIfNeeded];
//}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f",
          location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    {
        CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
        view.backgroundColor = [UIColor randomFlatColor];
        
//        {
//            UIView *contentView =
//            [[[NSBundle mainBundle] loadNibNamed:@"CardContentView"
//                                           owner:self
//                                         options:nil] objectAtIndex:0];
//            contentView.translatesAutoresizingMaskIntoConstraints = NO;
//            [view addSubview:contentView];
//            
//            // This is important:
//            // https://github.com/zhxnlai/ZLSwipeableView/issues/9
//            
//            // fixme: to use masonry
//            NSDictionary *metrics = @{
//                                      @"height" : @(view.bounds.size.height),
//                                      @"width" : @(view.bounds.size.width)
//                                      };
//            NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
//            [view addConstraints:
//             [NSLayoutConstraint
//              constraintsWithVisualFormat:@"H:|[contentView(width)]"
//              options:0
//              metrics:metrics
//              views:views]];
//            [view addConstraints:[NSLayoutConstraint
//                                  constraintsWithVisualFormat:
//                                  @"V:|[contentView(height)]"
//                                  options:0
//                                  metrics:metrics
//                                  views:views]];
//        }
        {
            UITextView *textView =
            [[UITextView alloc] initWithFrame:view.bounds];
            textView.text = @"This UITextView was created programmatically.";
            textView.backgroundColor = [UIColor clearColor];
            textView.font = [UIFont systemFontOfSize:24];
            textView.editable = NO;
            textView.selectable = NO;
            [view addSubview:textView];
        }
        
        return view;
    }
    return nil;
}

@end
