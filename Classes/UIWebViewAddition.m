//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "UIWebViewAddition.h"
#import "Console.h"

#import "ScriptDebugDelegate.h"

@class WebView;
@class WebFrame;
@class WebScriptObject;

@implementation UIWebView (JSDevelopment)

#ifdef DEBUG_CONFIGURATION

- (void)webViewJSDev:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    [self webViewJSDev:sender didClearWindowObject:windowObject forFrame:frame];

    Console *console = [Console sharedInstance];
    id win = [sender windowScriptObject];
    [win setValue:console forKey:@"zephirConsole"];
    
    [sender setScriptDebugDelegate:[[ScriptDebugDelegate alloc] initWithView:self]];
}

#endif

@end
