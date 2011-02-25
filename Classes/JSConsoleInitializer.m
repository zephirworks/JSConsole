//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "JSConsoleInitializer.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

void MethodSwizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

@implementation JSConsoleInitializer

+ (void) start
{
#ifdef DEBUG_CONFIGURATION
    MethodSwizzle([UIWebView class],
                  @selector(webView:didClearWindowObject:forFrame:),
                  @selector(webViewJSDev:didClearWindowObject:forFrame:));

#endif
}

@end
