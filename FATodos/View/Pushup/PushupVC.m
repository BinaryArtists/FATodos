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
#import "Item_1_PickerCell.h"
#import "PickerModel.h"

#pragma mark -

@interface PushupVC () <UITableViewDelegate, UITableViewDataSource, MZDayPickerDelegate, MZDayPickerDataSource, MGSwipeTableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *          tableView;
@property (weak, nonatomic) IBOutlet MZDayPicker *          dayPicker;

@property (nonatomic, assign) UITableViewCellEditingStyle   tableViewEditStyle;

@property (nonatomic, strong) NSMutableArray *              tableData;
@property (nonatomic, strong) NSDateFormatter *             dateFormatter;

@property (nonatomic, strong) NSArray *                     leftButtons;
@property (nonatomic, strong) NSArray *                     rightButtons;

@property (nonatomic, strong) JDFPeekabooCoordinator *scrollCoordinator;

@end

@implementation PushupVC

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
             forCellReuseIdentifier:[Item_1_Cell identifier]];
        [self.tableView registerNib:[Item_1_PickerCell nib]
             forCellReuseIdentifier:[Item_1_PickerCell identifier]];
        
        self.tableView.separatorInset   = UIEdgeInsetsMake(0, 0, 0, 0);
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
    Item1 *item         = [self.tableData lastObject];
    
    if (![item isKindOfClass:[PickerModel class]] &&
        ([item isInit] ||    // 最后一项未初始化
        !item))              // 还没有任何数据
    // 新增一个表项（当日）
    {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.tableData count]
                                             inSection:0];
        
        [self.tableData addObject:[Item1 new]];
        
        [self setTableViewEditStyle:UITableViewCellEditingStyleInsert];
        
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
    id model                = [self.tableData objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[Item1 class]]) {
        return 58.f;
    } else if ([model isKindOfClass:[PickerModel class]]) {
        return 162.f;
    } else {
        return 0.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model                = [self.tableData objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[Item1 class]]) {
        Item1 *item             = model;
        Item_1_Cell *cell       = [tableView dequeueReusableCellWithIdentifier:[Item_1_Cell identifier]
                                                                  forIndexPath:indexPath];
        
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType      = UITableViewCellAccessoryNone;
        cell.selectionStyle     = UITableViewCellSelectionStyleNone;
        
        {
            cell.delegate = self; //optional
            
            //configure left buttons
            cell.leftButtons = [self leftButtons];
            cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
            
            //configure right buttons
            cell.rightButtons = [self rightButtons];
            cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        }
        
        [cell setModel:item];
        
        return cell;
    } else if ([model isKindOfClass:[PickerModel class]]) {
        PickerModel *pickerModel        = model;
        Item_1_PickerCell *cell         = [tableView dequeueReusableCellWithIdentifier:[Item_1_PickerCell identifier]
                                                                          forIndexPath:indexPath];
        
        cell.backgroundColor    = [UIColor whiteColor];
        cell.accessoryType      = UITableViewCellAccessoryNone;
        cell.selectionStyle     = UITableViewCellSelectionStyleNone;

        [cell setModel:pickerModel];
        
        
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model                = [self.tableData objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[Item1 class]]) {
        Item1 *item             = model;
        
        // expand next cell
        if ([self isListEditing]) {
            
            if (indexPath.row == [self listEditingAtIndex]-1) {
                // 点击的同一个cell
                NSInteger deleteIndex   = [self listEditingAtIndex];
                
                // delete
                [self setTableViewEditStyle:UITableViewCellEditingStyleDelete];
                
                [self.tableData removeObjectAtIndex:deleteIndex];
                
                [self.tableView beginUpdates];
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:deleteIndex inSection:0]]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
            } else {
                // move model
                
                
                // move cell
                [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:[self listEditingAtIndex] inSection:0]
                                       toIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
            }
        } else {
            Item1 *item         = [self.tableData objectAtIndex:indexPath.row];
            
            // insert to
            PickerModel *model  = [PickerModel new];
            model.round_1       = item.num_1;
            model.round_2       = item.num_2;
            model.round_3       = item.num_3;
            model.item          = item;
            
            [self.tableData insertObject:model atIndex:indexPath.row+1];

            [self setTableViewEditStyle:UITableViewCellEditingStyleInsert];
            
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row+1
                                                                        inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } else if ([model isKindOfClass:[PickerModel class]]) {
        // do nothing
    } else {
        // do nothing
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableViewEditStyle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - MGSwipeTableCellDelegate

- (BOOL)swipeTableCell:(MGSwipeTableCell*)cell
   tappedButtonAtIndex:(NSInteger)index
             direction:(MGSwipeDirection)direction
         fromExpansion:(BOOL)fromExpansion {
    
    if (direction == MGSwipeDirectionLeftToRight) {
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
    } else {
        switch (index) {
            case 0: {
                // todo: 如果存在展开，则要删除两个
                [self setTableViewEditStyle:UITableViewCellEditingStyleDelete];
                
                // Delete button was pressed
                NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
                
                [self.tableData removeObjectAtIndex:cellIndexPath.row];
                
                [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                break;
            }
                
            case 1: {
                
                [cell hideSwipeAnimated:YES];
                
                [[Routable sharedRouter] open:[AppDelegate DIAGRAM_VC] animated:YES extraParams:@{}];
                
                break;
            }
                
            default:
                break;
        }
    }
    
    return YES;
}

#pragma mark - Utility

- (BOOL)isListEditing {
    __block BOOL is = NO;
    
    [self.tableData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[PickerModel class]]) {
            is      = YES;
            
            *stop       = YES;
        }
    }];
    
    return is;
}

- (NSInteger)listEditingAtIndex {
    __block NSInteger idx_  = -1;
    
    [self.tableData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[PickerModel class]]) {
            idx_            = idx;
            
            *stop       = YES;
        }
    }];
    
    return idx_;
}

#pragma mark - Property

- (NSArray *)rightButtons {
    return @[
             [MGSwipeButton buttonWithTitle:[s  Delete]
                            backgroundColor:[UIColor red_1_color]],
             [MGSwipeButton buttonWithTitle:[s More]
                            backgroundColor:[UIColor gray_1_color]]];
}

- (NSArray *)leftButtons {
    return @[
             [MGSwipeButton buttonWithTitle:[s Pushup]
                            backgroundColor:[UIColor blue_1_color]],
             [MGSwipeButton buttonWithTitle:[s Dumbell]
                            backgroundColor:[UIColor green_1_color]]];
}

@end
