//
//  ViewController.m
//  TextInputStudy
//
//  Created by Hiroshi Hashiguchi on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
typedef enum {
    TextProcessorStateBOL = 0,  // Begin Of Line
    TextProcessorStateIOL,      // Inner Of Line
    TextProcessorStateEOL,      // End of Line
    TextProcessorStateEL        // Empty Line
} TextProcessorState;

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)check:(id)sender {
    
    NSLog(@"-----------------");

    BOOL is1 = [self.textView.tokenizer isPosition:self.textView.selectedTextRange.start
                                    withinTextUnit:UITextGranularityParagraph
                                       inDirection:UITextStorageDirectionForward];
    BOOL is2 = [self.textView.tokenizer isPosition:self.textView.selectedTextRange.start
                                    withinTextUnit:UITextGranularityParagraph
                                       inDirection:UITextStorageDirectionForward];
    NSLog(@"is1[fw] %d", is1);
    NSLog(@"is2[fw] %d", is2);

    BOOL p1 = [self.textView.tokenizer isPosition:self.textView.selectedTextRange.start
                                       atBoundary:UITextGranularityParagraph
                                      inDirection:UITextStorageDirectionForward];
    BOOL p2 = [self.textView.tokenizer isPosition:self.textView.selectedTextRange.start
                                       atBoundary:UITextGranularityParagraph
                                      inDirection:UITextStorageDirectionBackward];
    
    NSLog(@"[isPosition:atBoundary:inDirection:][fw] %d", p1);
    NSLog(@"[isPosition:atBoundary:inDirection:][bk] %d", p2);
    
    TextProcessorState state;

    if (p1) {
        if (p2) {
            state = TextProcessorStateEL;   // [1][1]
            NSLog(@"state: TextProcessorStateEL");
        } else {
            state = TextProcessorStateEOL;  // [1][0]
            NSLog(@"state: TextProcessorStateEOL");
        }
    } else {
        if (p2) {
            state = TextProcessorStateBOL;  // [0][1]
            NSLog(@"state: TextProcessorStateBOL");
        } else {
            state = TextProcessorStateIOL;  // [0][0]
            NSLog(@"state: TextProcessorStateIOL");
        }
    }
    
    if (state ==TextProcessorStateEL) {        
        NSLog(@"-- return");
        return;
        // normal return action
        // ** not reacehd **
    }
    
    UITextDirection direction = state == TextProcessorStateBOL ? 
        UITextStorageDirectionForward : UITextStorageDirectionBackward;

    //----------
    UITextRange* range =[self.textView.tokenizer rangeEnclosingPosition:self.textView.selectedTextRange.start
                                    withGranularity:UITextGranularityParagraph
                                        inDirection:direction];
    // not UITextGranularityLine !! --> ignore CR+LF
    NSLog(@"[LINE:1]|%@|", [self.textView textInRange:range]);
    //----------

    UITextPosition* startOfBOL = range.start;
    UITextPosition* endOfBOL;
    NSString* BOLString = @"";

    if (startOfBOL) {
        endOfBOL = [self.textView positionFromPosition:startOfBOL offset:1];
        UITextRange* bolRange = [self.textView textRangeFromPosition:startOfBOL
                                                          toPosition:endOfBOL];
        BOLString = [self.textView textInRange:bolRange];
    }
    
    
    NSLog(@"[BOL]|%@|", BOLString);
    NSLog(@"[BOL:startOfBOL]%@", startOfBOL);
    NSLog(@"[BOL:endOfBOL]%@", endOfBOL);

    
    NSLog(@"%s|%@|length=%d|index[0]=%@", __PRETTY_FUNCTION__, BOLString, BOLString.length, [BOLString substringWithRange:NSMakeRange(0, 2)]);

//    UITextPosition* EOL = [self.textView.tokenizer positionFromPosition:startOfBOL
//                                                             toBoundary:UITextGranularityLine
//                                                            inDirection:UITextStorageDirectionForward];
//
//    UITextRange* lineRange = [self.textView textRangeFromPosition:startOfBOL
//                                                       toPosition:EOL];
//
//    NSLog(@"[LINE:2] %@", [self.textView textInRange:lineRange]);
//
}

@end
