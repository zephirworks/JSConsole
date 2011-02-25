//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import "Console.h"


@implementation Console

+ (Console*) sharedInstance
{
    static Console *instance = nil;
    
    if (instance == nil) {
        instance = [[Console alloc] init];
    }
    
    return instance;
}

- (void)log:(NSString *)theLog {
    NSLog(@"JSConsole: %@", theLog);
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector {
    return NO;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)name {
    return NO;
}

+ (NSString *) webScriptNameForSelector:(SEL)sel {
    if (sel == @selector(log:)) {
        return @"log";
    } else {
        return nil;
    }
}

@end
