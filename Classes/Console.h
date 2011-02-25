//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Console : NSObject {

}
+ (Console*) sharedInstance;

- (void)log:(NSString *)theLog;

/* WebScripting methods */
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)selector;
+ (BOOL)isKeyExcludedFromWebScript:(const char *)property;
+ (NSString *) webScriptNameForSelector:(SEL)sel;

@end
