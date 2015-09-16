//
//  MainVC.m
//  DemoRepository
//
//  Created by 李杰 on 9/2/15.
//  Copyright (c) 2015 fallen.ink. All rights reserved.
//

#import "PushupVC.h"
#import "UIViewController+UINavigationBar.h"
#import "UIView+Frame.h"
#import "MZDayPicker.h"
#import "Samurai_Property.h"
#import "JDFPeekabooCoordinator.h"
#import "DiagramVC.h"
#import "NSMutableArray+SWUtilityButtons.h"
#import "SWTableViewCell.h"
#import "Item_1_Cell.h"

@interface PushupVC () <UITableViewDelegate, UITableViewDataSource, MZDayPickerDelegate, MZDayPickerDataSource, SWTableViewCellDelegate, Item_1_CellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *          tableView;
@property (weak, nonatomic) IBOutlet MZDayPicker *          dayPicker;

@property (nonatomic, assign) UITableViewCellEditingStyle   tableViewEditStyle;

@property (nonatomic, strong) NSMutableArray *              tableData;
@property (nonatomic, strong) NSDateFormatter *             dateFormatter;

@property (nonatomic, strong) NSArray *                     leftButtons;
@property (nonatomic, strong) NSArray *                     rightButtons;

@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;

@string( TABLE_CELL_INDETIFY )

@end

@implementation PushupVC

@def_string( TABLE_CELL_INDETIFY, @"identifier.UITableViewCell");

#pragma mark - Initialize

- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        self.title = @"俯卧撑";
    }
    return self;
}

#pragma mark - Life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.scrollCoordinator disable];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.scrollCoordinator disable];   // Notice: content 被填充满了，才会产生效果。
                                        // 满屏了，才有收缩其他边角的必要！
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout         = UIRectEdgeNone;

    // Table view
    {
        self.tableView.tableFooterView  = [UIView new];

        [self.tableView registerNib:[Item_1_Cell nib]
             forCellReuseIdentifier:[self TABLE_CELL_INDETIFY]];
    }
    
    {
        self.tableData = [@[] mutableCopy];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"EE"];
    }
    
    {
        self.dayPicker.delegate = self;
        self.dayPicker.dataSource = self;
        
        self.dayPicker.dayNameLabelFontSize = 12.0f;
        self.dayPicker.dayLabelFontSize = 18.0f;
        
        /*
         *  You can set month, year using:
         *  self.dayPicker.month = 9;
         *  self.dayPicker.year = 2013;
         *  [self.dayPicker setActiveDaysFrom:1 toDay:30];
         *  [self.dayPicker setCurrentDay:15 animated:NO];
         *
         *  or set up date range:
         */
        
        [self.dayPicker setStartDate:[NSDate dateFromDay:28 month:9 year:2013] endDate:[NSDate dateFromDay:5 month:10 year:2013]];
        
        [self.dayPicker setCurrentDate:[NSDate dateFromDay:3 month:10 year:2013] animated:NO];
    }

    // Need UITableViewController or...
    {
        self.scrollCoordinator                  = [[JDFPeekabooCoordinator alloc] init];
        self.scrollCoordinator.scrollView       = self.tableView;
        self.scrollCoordinator.containingView   = self.view;
        self.scrollCoordinator.topView          = self.dayPicker;
        self.scrollCoordinator.topViewMinimisedHeight = 5.0f;
        self.scrollCoordinator.bottomView       = self.navigationController.toolbar;
    }
    
    {
        [self setNavRightItemWithName:@"新增" target:self action:@selector(didClickOnNavigationBarRightItem:)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handle

- (void)didClickOnNavigationBarRightItem:(id)sender {
    [self setTableViewEditStyle:UITableViewCellEditingStyleInsert];
    
    
    Item1 *item         = [self.tableData lastObject];
    
    if ([item isInit] ||    // 最后一项未初始化
        !item)              // 还没有任何数据
    // 新增一个表项（当日）
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.tableData count]
                                             inSection:0];
        
        [self.tableData addObject:[Item1 new]];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                              withRowAnimation:UITableViewRowAnimationRight];
    }
    else
    // 重新加载当前项目
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.tableData count]-1
                                             inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                              withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark - MZDayPickerDelegate & MZDayPickerDataSource

- (NSString *)dayPicker:(MZDayPicker *)dayPicker titleForCellDayNameLabelInDay:(MZDay *)day {
    return [self.dateFormatter stringFromDate:day.date];
}


- (void)dayPicker:(MZDayPicker *)dayPicker didSelectDay:(MZDay *)day {
    NSLog(@"Did select day %@", day.day);

    [self.tableView reloadData];
}

- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day {
    NSLog(@"Will select day %@",day.day);
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Item1 *item         = [self.tableData objectAtIndex:indexPath.row];
    Item_1_Cell *cell   = [tableView dequeueReusableCellWithIdentifier:[self TABLE_CELL_INDETIFY]
                                                            forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.leftUtilityButtons = [self leftButtons];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }

    // optionally specify a width that each set of utility buttons will share
    cell.delegate = self;
    [cell setLeftUtilityButtons:[self leftButtons] WithButtonWidth:58.0f];
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    
    // Set model
    [cell setModel:item];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do nothing
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableViewEditStyle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state {
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    // Get cell's index
    NSIndexPath *cellIndexPath  = [self.tableView indexPathForCell:cell];
    Item1 *item                 = [self.tableData objectAtIndex:cellIndexPath.row];
    
    // Update data
    switch (index+1) {
        case kItemPushup: {
            [item setType:kItemPushup];
        }
            break;
        case kItemDumbbell: {
            [item setType:kItemDumbbell];
        }
            break;
    }
    
    // Reload cell
    [self.tableView reloadRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0: {
            
            [cell hideUtilityButtonsAnimated:YES];
            
            [[Routable sharedRouter] open:[AppDelegate DIAGRAM_VC] animated:YES extraParams:@{}];
            
            break;
        }
        case 1: {
            [self setTableViewEditStyle:UITableViewCellEditingStyleDelete];
            
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [self.tableData removeObjectAtIndex:cellIndexPath.row];
            
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state {
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

#pragma mark - Item_1_CellDelegate

- (BOOL)item_1_CellShouldExpandForEditing:(Item_1_Cell *)cell {
    return YES;
}

- (void)item_1_CellDidExpand:(Item_1_Cell *)cell {
    
}

- (void)item_1_CellDidBack:(Item_1_Cell *)cell {
    // save state to model
}

#pragma mark - UIScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = self.tableViewHeader.height;
//    
//    if (scrollView.contentOffset.y <= sectionHeaderHeight &&
//        scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark - Property

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor gray_1_color]
                                                title:@"更多"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor red_1_color]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons {
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor blue_1_color]
                                                title:@"俯卧撑"];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor green_1_color]
                                                title:@"哑铃"];

    
    return leftUtilityButtons;
}

@end
