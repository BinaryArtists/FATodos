//
//  QuadrantView.h
//  FATodos
//
//  Created by fallen.ink on 10/27/15.
//  Copyright © 2015 fallen.ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuadrantView : UIView

@property (nonatomic, weak) id<UITableViewDelegate, UITableViewDataSource> delegate;

@end
