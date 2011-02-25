//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "TestWebView.h"
#import "Console.h"
#import "ScriptDebugDelegate.h"

@class WebView;
@class WebFrame;
@class WebScriptObject;
@class WebScriptCallFrame;
@class NSImage;

@implementation TestWebView

#ifdef DEBUG_CONFIGURATION

- (void)webView:(WebView *)sender didCancelClientRedirectForFrame:(WebFrame *)frame {
    [super webView:sender didCancelClientRedirectForFrame:frame];
}

- (void)webView:(WebView *)sender didChangeLocationWithinPageForFrame:(WebFrame *)frame {
    [super webView:sender didChangeLocationWithinPageForFrame:frame];
}


- (void)webView:(WebView *)sender didClearWindowObject:(WebScriptObject *)windowObject forFrame:(WebFrame *)frame {
    [super webView:sender didClearWindowObject:windowObject forFrame:frame];

    Console *console = [Console sharedInstance];
    id win = [sender windowScriptObject];
    [win setValue:console forKey:@"zephirConsole"];

    [sender setScriptDebugDelegate:[[ScriptDebugDelegate alloc] initWithView:self]];
}


- (void)webView:(WebView *)sender didCommitLoadForFrame:(WebFrame *)frame {
    [super webView:sender didCommitLoadForFrame:frame]; 
}


- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    [super webView:sender didFailLoadWithError:error forFrame:frame]; 
}


- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    [super webView:sender didFailProvisionalLoadWithError:error forFrame:frame]; 
}


- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    [super webView:sender didFinishLoadForFrame:frame]; 
}


- (void)webView:(WebView *)sender didReceiveIcon:(NSImage *)image forFrame:(WebFrame *)frame {
    [super webView:sender didReceiveIcon:frame]; 
}


- (void)webView:(WebView *)sender didReceiveServerRedirectForProvisionalLoadForFrame:(WebFrame *)frame {
    [super webView:sender didReceiveServerRedirectForProvisionalLoadForFrame:frame]; 
}


- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame {
    [super webView:sender didReceiveTitle:title forFrame:frame]; 
}


- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
    [super webView:sender didStartProvisionalLoadForFrame:frame]; 
}


- (void)webView:(WebView *)sender willCloseFrame:(WebFrame *)frame {
    [super webView:sender willCloseFrame:frame]; 
}


- (void)webView:(WebView *)sender willPerformClientRedirectToURL:(NSURL *)URL delay:(NSTimeInterval)seconds fireDate:(NSDate *)date forFrame:(WebFrame *)frame {
    [super webView:sender willPerformClientRedirectToURL:URL delay:seconds fireDate:date forFrame:frame]; 
}

#endif

@end
