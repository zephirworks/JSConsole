//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController < UIWebViewDelegate, UIScrollViewDelegate > {
	UIWebView *webPage;
}

@property (nonatomic, retain) UIWebView *webPage;

@end
