//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExceptionViewController : UIViewController {
    UIWebView *textView;
    NSMutableArray *oldLogs;
}

- (void) setTextContent:(NSArray*)lines url:(NSURL *)url line:(int)lineno;
- (void) resetTextContent;

@end
