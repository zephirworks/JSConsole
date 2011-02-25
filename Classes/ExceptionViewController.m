//
//  Copyright 2011 ZephirWorks. All rights reserved.
//

#define CONTEXT_LINES 3


#import "ExceptionViewController.h"


@implementation ExceptionViewController

- (id)init {    
    textView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 500, 200)] retain];
    [[self view] addSubview:textView];
    oldLogs = [[[NSMutableArray alloc] init] retain];    
    
	return self;
}

- (void)viewDidLoad { [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(500, 200);
}

- (void) resetTextContent {
    [oldLogs removeAllObjects];
    [oldLogs addObject:@"<body style=\"background-color:lightgray;\">"];
}

-(void) setTextContent:(NSArray*)lines url:(NSURL *)url line:(int)lineno {
    int lowerBound = MAX(1, lineno - CONTEXT_LINES);
    int upperBound = MIN([lines count], lineno + CONTEXT_LINES) + 1;
    
    NSMutableString *log = [[NSMutableString alloc] init];
    
    for (NSString *str in oldLogs) {
        [log appendString:str];
    }
    
    NSMutableString *newLog = [[NSMutableString alloc] init];
    NSString *file = ([url lastPathComponent] ? [NSString stringWithFormat:@" in \"%@\":", [url lastPathComponent]] : @":");
    NSString *head = [NSString stringWithFormat:@"Exception found%@", file];
    
    NSString *format = @"<font color =\"%@\" size=%d face=\"Helvetica\">%@<BR></font>";

    [newLog appendString:[NSString stringWithFormat:format, @"red", 2, head]];


    for (int i = lowerBound; i <upperBound ; ++i) {
        NSString *sourceLine = [NSString stringWithFormat:@"%d: %@\n", i, [lines objectAtIndex:(i - 1)]];
        if (i==lineno) {
            [newLog appendString:[NSString stringWithFormat:format, @"red", 1, sourceLine]];
        } else {
            [newLog appendString:[NSString stringWithFormat:format, @"black", 1, sourceLine]];
        }
    }
    [newLog appendString:@"<BR>"];
    
    [oldLogs addObject:newLog];
    [log appendString:newLog];
    [textView loadHTMLString:log baseURL:nil];
    [newLog release];
    [log release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;
}


- (void)dealloc {
    [super dealloc];
    [textView release];
    [oldLogs release];
}


@end
