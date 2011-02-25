//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExceptionViewController.h"

@interface ScriptDebugDelegate : NSObject <UIPopoverControllerDelegate> {
    NSMutableDictionary *dictionary;
    NSMutableDictionary *sources;

    UIPopoverController *popoverController;
    ExceptionViewController *exceptionViewController;
    UIView *view;
}

@property (nonatomic, retain) ExceptionViewController *exceptionViewController;
@property (nonatomic, retain) UIView *view;

- (id) initWithView:(UIView*)view;

@end
