//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "ScriptDebugDelegate.h"
#import <objc/runtime.h>

#define CONTEXT_LINES 3

@class WebView;
@class WebFrame;
@class WebScriptObject;
@class WebScriptCallFrame;

@interface ScriptDebugDelegate()
- (BOOL) isPad;
@end

@implementation ScriptDebugDelegate

@synthesize exceptionViewController;
@synthesize view;

- (id) initWithView:(UIView*)webView {
    if (self = [super init]) {
        dictionary = [[[NSMutableDictionary alloc] init] retain];
        sources = [[[NSMutableDictionary alloc] init] retain];

        if ([self isPad]) {
            exceptionViewController = [[[ExceptionViewController alloc]
                                        init] retain];
            popoverController = [[[UIPopoverController alloc]
                                  initWithContentViewController:exceptionViewController] retain];
            popoverController.delegate = self;
        }
        view = webView;
    }
    
    return self;
}

- (void) setURL:(NSURL*)url sources:(NSArray*)theSources forKey:(id)aKey {
    if (url) {
        [dictionary setObject:url forKey:aKey];
    }
    if (theSources) {
        [sources setObject:theSources forKey:aKey];
    }
}

- (NSURL*) urlForKey:(id)aKey {
    return [dictionary objectForKey:aKey];
}

- (NSArray*) sourcesForKey:(id)aKey {
    return [sources objectForKey:aKey];
}

- (void) dealloc {
    [dictionary release];
    [sources release];
    if ([self isPad]) {
        [exceptionViewController release];
        [popoverController release];
    }
    [super dealloc];
}

#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)thePopoverController {
    [exceptionViewController resetTextContent];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)thePopoverController {
    return YES;
}

#pragma mark iPad

- (BOOL) isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}


#ifdef DEBUG_CONFIGURATION

#pragma mark ScriptDebugDelegateMethods

- (void)webView:(WebView *)webView       didParseSource:(NSString *)source
 baseLineNumber:(unsigned)lineNumber
        fromURL:(NSURL *)url
       sourceId:(int)sid
    forWebFrame:(WebFrame *)webFrame
{
    NSArray *lines = [source componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSLog(@"ScriptLogger - a source has been parsed: sid:%d, url:%@, lines:%d", sid, url, [lines count]);

    [self setURL:url sources:lines forKey:[NSString stringWithFormat:@"%d", sid]];
}

// some source failed to parse
- (void)webView:(WebView *)webView  failedToParseSource:(NSString *)source
 baseLineNumber:(unsigned)lineNumber
        fromURL:(NSURL *)url
      withError:(NSError *)error
    forWebFrame:(WebFrame *)webFrame
{
    NSLog(@"ScriptLogger - failed parsing: url:%@ line:%d error:%@", url, lineNumber, error);
}

- (void)webView:(WebView *)webView   exceptionWasRaised:(WebScriptCallFrame *)frame
       sourceId:(int)sid
           line:(int)lineno
    forWebFrame:(WebFrame *)webFrame
{
    NSURL *url = [self urlForKey:[NSString stringWithFormat:@"%d", sid]];
    NSArray *lines = [self sourcesForKey:[NSString stringWithFormat:@"%d", sid]];

    //Log on console
    NSLog(@"ScriptLogger - found exception: sid:%d, url:%@, line:%d function:%@", 
          sid, url, lineno, [frame functionName]);

    int lowerBound = MAX(1, lineno - CONTEXT_LINES);
    int upperBound = MIN([lines count], lineno + CONTEXT_LINES) + 1;
    NSMutableString *log = [[NSMutableString alloc] init];
    [log appendString:@"ScriptLogger - exception in:\n"];
    for (int i = lowerBound; i <upperBound ; ++i) {
        [log appendFormat:@"%d: %@\n", i, [lines objectAtIndex:(i - 1)]];
    }
    NSLog(@"%@", log);
    [log release];

    //Log on PopOver
    if ([self isPad]) {
        [exceptionViewController setTextContent:lines url:url line:lineno];

        if (!popoverController.popoverVisible) {
            [popoverController presentPopoverFromRect:CGRectMake(50, 50, 0.0f, 0.0f) inView:view permittedArrowDirections:0 animated:YES];
        }
    }
}

- (void)webView:(WebView *)webView    didEnterCallFrame:(WebScriptCallFrame *)frame
       sourceId:(int)sid
           line:(int)lineno
    forWebFrame:(WebFrame *)webFrame;
{
    //NSLog(@"ScriptLogger -  didEnterCallFrame: sid=%d, line=%d", sid, lineno);
}

// about to execute some code
- (void)webView:(WebView *)webView willExecuteStatement:(WebScriptCallFrame *)frame
       sourceId:(int)sid
           line:(int)lineno
    forWebFrame:(WebFrame *)webFrame;
{
    //NSLog(@"ScriptLogger -  willExecuteStatement: sid=%d, line=%d", sid, lineno);
}

// about to leave a stack frame (i.e. return from a function)
- (void)webView:(WebView *)webView   willLeaveCallFrame:(WebScriptCallFrame *)frame
       sourceId:(int)sid
           line:(int)lineno
    forWebFrame:(WebFrame *)webFrame;
{
    //NSLog(@"ScriptLogger - willLeaveCallFrame: sid=%d, line=%d", sid, lineno);
}

#endif

@end
