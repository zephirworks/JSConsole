//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebViewViewController;

@interface JSConsoleSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WebViewViewController *consoleViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) WebViewViewController *consoleViewController;


@end

