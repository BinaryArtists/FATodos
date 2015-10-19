#import "AppDelegate.h"
#import "Component.h"
#import "Routable.h"
#import "PushupVC.h"
#import "DiagramVC.h"
#import "MainVC.h"
#import "MemoVC.h"
#import "Memo.h"
#import "FourQuadrantVC.h"
#import "NoteVC.h"
#import "PomodoroVC.h"
#import "ServiceMonitor.h"
#import "ServiceBorder.h"
#import "ServiceGesture.h"
#import "ServiceGrids.h"
#import "ServiceInspector.h"
#import "ServiceTapspot.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize {
    [super initialize];
    
    [self doConfig];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *aNavController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
    [[Routable sharedRouter] map:[self MAIN_VC] toController:[MainVC class]];
    [[Routable sharedRouter] setNavigationController:aNavController];
    
    [self.window setRootViewController:aNavController];
    [self.window makeKeyAndVisible];
    
    [[Routable sharedRouter] open:[self MAIN_VC]];
    
    [self mapping];
    
//    [self test];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

- (void)test {
    NSDictionary *dict = [NSDictionary mtl_identityPropertyMapWithModel:[Memo class]];
    
    NSLog(@"%@", dict);
    
    [self test_speech];
}

- (void)test_speech {
    AVSpeechSynthesizer *av         = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance    = [[AVSpeechUtterance alloc]initWithString:@"走走 停停"];
    
    utterance.rate                  = AVSpeechUtteranceMinimumSpeechRate;
    [av speakUtterance:utterance];
}

#pragma mark - VC mapping

- (void)mapping {
    [[Routable sharedRouter] map:[self PUSHUP_VC] toController:[PushupVC class]];
    [[Routable sharedRouter] map:[self DIAGRAM_VC] toController:[DiagramVC class]];
    [[Routable sharedRouter] map:[self MEMO_VC] toController:[MemoVC class]];
    [[Routable sharedRouter] map:[self NOTE_VC] toController:[NoteVC class]];
    [[Routable sharedRouter] map:[self QUADRANT_VC] toController:[FourQuadrantVC class]];
    [[Routable sharedRouter] map:[self POMODORO_VC] toController:[PomodoroVC class]];
}

@end

#pragma mark - AppDelegate (ViewRoutable)

@implementation AppDelegate (ViewRoutable)

@def_string( MAIN_VC,       @"vc.main" )
@def_string( PUSHUP_VC,     @"vc.pushup" )
@def_string( DIAGRAM_VC,    @"vc.diagram" )

@def_string( MEMO_VC,       @"vc.memo" )
@def_string( NOTE_VC,       @"vc.note" )
@def_string( QUADRANT_VC,   @"vc.quadrant" )
@def_string( POMODORO_VC,   @"vc.pomodoro")

@end

#pragma mark - AppDelegate (configuration)

@implementation AppDelegate (configuration)

+ (void)doConfig {
    [self configSamuraiFramework];
}

+ (void)configSamuraiFramework {
    // load classes
    [SamuraiComponent load];
    
    // fixme: 如下，为何会影响statusBar的显示情况
    [[SamuraiServiceLoader sharedInstance] serviceExcept:[ServiceMonitor class]];
    [[SamuraiServiceLoader sharedInstance] serviceExcept:[ServiceBorder class]];
    [[SamuraiServiceLoader sharedInstance] serviceExcept:[ServiceGrids class]];
    [[SamuraiServiceLoader sharedInstance] serviceExcept:[ServiceGesture class]];
    [[SamuraiServiceLoader sharedInstance] serviceExcept:[ServiceInspector class]];
}

@end

