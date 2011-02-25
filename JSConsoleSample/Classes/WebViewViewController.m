//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "WebViewViewController.h"

#define PAGE_HEIGHT 1024
#define PAGE_WIDTH 768

//  ==========================================================================================

@implementation WebViewViewController

@synthesize webPage;

// ****** INIT
- (id)init {
	webPage = [[UIWebView alloc] init];
	webPage.delegate = self;
	webPage.scalesPageToFit = NO;
	
    webPage.frame = CGRectMake(0, 0, PAGE_WIDTH, PAGE_HEIGHT);
    [[self view] addSubview:webPage];

    NSString *bundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"html"];
    NSString *path = [bundle stringByAppendingPathComponent:@"test.html"];
    [webPage loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
	return self;
}


// ****** WEBVIEW
- (void)webViewDidStartLoad:(UIWebView *)webView {
	// Sent before a web view begins loading content.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsBundlePath = [[NSBundle mainBundle] pathForResource:@"JS" ofType:@"bundle"];
    NSString *testObjPath = [NSString stringWithFormat:@"%@/test.js", jsBundlePath];
    NSFileHandle *fhRead = [NSFileHandle fileHandleForReadingAtPath:testObjPath];
    NSData *dataRead = [fhRead availableData];
    NSString *content = [[NSString alloc] initWithData:dataRead encoding:NSUTF8StringEncoding];
    
    [webView stringByEvaluatingJavaScriptFromString:content];

    [content release];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webView failed to load content with error: %@", error);
}

// ****** SYSTEM
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Overriden to allow any orientation.
    return NO;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewDidUnload {
    
	[super viewDidUnload];
	webPage.delegate = nil;
}
- (void)dealloc {
	[webPage release];
    [super dealloc];
}

@end