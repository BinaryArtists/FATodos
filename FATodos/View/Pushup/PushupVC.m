//
//  MainVC.m
//  DemoRepository
//
//  Created by fallen.ink on 9/2/15.
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
#import "Item_1_Cache.h"

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

@property (nonatomic, assign) BOOL                          shouldAnimateTableView;
@property (nonatomic, assign) BOOL                          newItemButtonHidden;
@property (nonatomic, strong) NSDate *                      today;

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
        self.today  = [NSDate new];
        
        // todo：这个应该是，纪录开始的那一天
        
        // todo: 区间设置，不需要太大
        [self.dayPicker setStartDate:[NSDate dateFromDay:7 month:9 year:2015] // fixme: 接口内部能处理的，
                                                                            // 外部就应该保持简单，比如直接传入nsdate对象，不进行约束
                             endDate:[NSDate dateFromDay:6 month:9 year:2016]];
        
        // todo:这个应该是当前天
        NSDate *todayDate   = [NSDate new];
        NSInteger year      = [todayDate year];
        NSInteger month     = [todayDate month];
        NSInteger day       = [todayDate day];
        [self.dayPicker setCurrentDate:[NSDate dateFromDay:day month:month year:year]
                              animated:NO];
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
        self.newItemButtonHidden    = NO;
    }
    
    [self selectItemsWithDate:[NSDate new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action handle

- (void)OnNavigationBarRightItem:(id)sender {
    Item1 *item         = [self.tableData lastObject];
    
    if (![item isKindOfClass:[PickerModel class]] &&
        ([item isInit] ||    // 最后一项未初始化
        !item))              // 还没有任何数据
    // 新增一个表项（当日）
    {
        Item1 *item     = [Item1 new];
        [[Item_1_Cache sharedInstance] addObject:item
                             withCompletionBlock:^(BOOL isSucceed, id inserted) {
                                 
                                 NSIndexPath *ip = [NSIndexPath indexPathForRow:[self.tableData count]
                                                                      inSection:0];
                                 
                                 [self.tableData addObject:inserted];
                                 
                                 [self setTableViewEditStyle:UITableViewCellEditingStyleInsert];
                                 
                                 [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                                                       withRowAnimation:UITableViewRowAnimationRight];
                                 
                             }];
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
    NSLog(@"date = %@", day.date);

    [self selectItemsWithDate:day.date];
}

- (void)dayPicker:(MZDayPicker *)dayPicker willSelectDay:(MZDay *)day {
    NSLog(@"Will select day %@", day);
    
    self.newItemButtonHidden    = [day.date isEarlierThan:self.today];
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
        
        // 当加载完成，开始动画
        if(indexPath.row == ((NSIndexPath *)[[tableView indexPathsForVisibleRows] lastObject]).row){
            
            if (self.shouldAnimateTableView) {
                self.shouldAnimateTableView = NO;
                
                [self performSelector:@selector(animate:) withObject:tableView afterDelay:0.1];
            }
        }
        
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
        __unused Item1 *item            = model;
        
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
    
    /**
     *  fallen.ink
     *  Notice:
     
     *  要注意这个用法！
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
                
            case kItemSitup: {
                [item setType:kItemSitup];
            }
                break;
        }
        
        [[Item_1_Cache sharedInstance] updateObject:item];
        
        // Reload cell
        [self.tableView reloadRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        switch (index) {
            case 0: {
                // todo: 如果存在展开，则要删除两个
                [self setTableViewEditStyle:UITableViewCellEditingStyleDelete];
                
                // Delete button was pressed
                NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
                Item1 *item                 = [self.tableData objectAtIndex:cellIndexPath.row];
                
                [[Item_1_Cache sharedInstance] removeObjectById:item.id];
                
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

#pragma mark - Table view aniamte

/**
 *  CGAffineTransformIdentity
 
 *  todo: 研究下这个原因
 */

- (void)animate:(UITableView *)tableView {
    NSLog(@"cell.rows = %ld, indexpath.rows = %ld", [tableView.visibleCells count], [tableView.indexPathsForVisibleRows count]);
    
    for (Item_1_Cell *aCell in tableView.visibleCells) {
        if ([tableView.visibleCells indexOfObject:aCell] % 2)
            [aCell pushCellWithAnimation:YES direction:kAnimationDirectionLeft];
        else
            [aCell pushCellWithAnimation:YES direction:kAnimationDirectionRight];
    }
}

//- (IBAction)btnAction:(id)sender {
//    //获取可见cells
//    visibleCells = visibleTableView.visibleCells;
//    NSLog(@"%@",visibleCells);
//    
//    UIButton *button = (UIButton*)sender;
//    CGAffineTransform transform;
//    double duration = 0.2;
//    
//    if (button.tag == 1) {
//        transform = CGAffineTransformMakeTranslation(-320, 0);
//    }else if(button.tag == 2){
//        for (UITableViewCell *cell in visibleCells) {
//            
//            [UIView animateWithDuration:duration delay:0 options:0  animations:^
//             {
//                 cell.transform = CGAffineTransformIdentity;
//                 
//                 
//             } completion:^(BOOL finished)
//             {
//                 
//             }];
//            duration+=0.1;
//        }
//        return;
//    }else{
//        transform = CGAffineTransformMakeTranslation(320, 0);
//        
//    }
//    for (UITableViewCell *cell in visibleCells) {
//        
//        [UIView animateWithDuration:duration delay:0 options:0  animations:^
//         {
//             cell.transform = transform;
//             
//         } completion:^(BOOL finished)
//         {
//             
//         }];
//        duration+=0.1;
//        
//    }
//    
//}

#pragma mark - Private method

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

- (void)selectItemsWithDate:(NSDate *)date {
    [[Item_1_Cache sharedInstance] allObjectsUsingBlock:^(NSArray *allobjects) {
        // 移除所有
        [self.tableData removeAllObjects];
        
        // 过滤出今天的
        [allobjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Item1 *item = obj;
            if ([item isBorn:date]) {
                [self.tableData addObject:obj];
            }
        }];
        
        // fixme: 删除无效的
        
        
        // 重新加载列表视图
        [self.tableView reloadData];
        
        // fixme：准备加载动画
        self.shouldAnimateTableView = YES;
    }];
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
                            backgroundColor:[UIColor green_1_color]],
             [MGSwipeButton buttonWithTitle:[s SitsUp]
                            backgroundColor:[UIColor blue_1_color]]];
}

- (void)setNewItemButtonHidden:(BOOL)newItemButtonHidden {
    _newItemButtonHidden    = newItemButtonHidden;
    
    if (_newItemButtonHidden) {
        [self setNavRightItemWithName:nil target:nil action:nil];
    } else {
        [self setNavRightItemWithName:@"新增" target:self action:@selector(OnNavigationBarRightItem:)];
    }
}

@end
