//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "JSConsoleSampleAppDelegate.h"
#import "WebViewViewController.h"
#import "JSConsole/JSConsoleInitializer.h"

@implementation JSConsoleSampleAppDelegate
@synthesize consoleViewController;


@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [JSConsoleInitializer start];

	// Create the controller for the root view
	self.consoleViewController =[[WebViewViewController alloc] init];
    
    // Create the application window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
	
	// Add the root view to the application window
	[window addSubview:[consoleViewController view]];
	
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
