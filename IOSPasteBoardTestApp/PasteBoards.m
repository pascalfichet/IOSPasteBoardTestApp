//
//  PasteBoards.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 13/05/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "constants.h"


UIPasteboard *generalPasteboard;
UIPasteboard *namedPasteboard;
UIPasteboard *uniquePasteboard;

@interface PasteBoards : NSObject



@end

@implementation PasteBoards

+ (void)load {
    NSLog(@"PasteBoards load method called");
    UIPasteboard *generalPasteBoard = [UIPasteboard generalPasteboard];
    [PasteBoards setGeneralPasteBoard:generalPasteBoard];
    
    UIPasteboard *namedPasteboard = [UIPasteboard pasteboardWithName:uiPasteboradName create:YES];
    [PasteBoards setNamedPasteBoard:namedPasteboard];
    
    UIPasteboard *uniquePasteboard = [UIPasteboard pasteboardWithUniqueName];
    [PasteBoards setUniquePasteBoard:uniquePasteboard];
}

+ (UIPasteboard *) getGeneralPasteBoard {
    return generalPasteboard;
}

+ (UIPasteboard *) getNamedPasteboard {
    return namedPasteboard;
}

+ (UIPasteboard *) getUniquePasteboard {
    return uniquePasteboard;
}

+ (void) setGeneralPasteBoard:(UIPasteboard *)pasteboard {
    generalPasteboard = pasteboard;
}
+ (void) setNamedPasteBoard:(UIPasteboard *)pasteboard {
    namedPasteboard = pasteboard;
}
+ (void) setUniquePasteBoard:(UIPasteboard *)pasteboard {
    uniquePasteboard = pasteboard;
}

@end
