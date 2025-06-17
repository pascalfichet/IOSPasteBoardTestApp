//
//  UIPasteboard+MyPasteBoard.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 30/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import "UIPasteboard+MyPasteBoard.h"
#import "ViewController.h"
#import "PasteBoards.h"





@implementation UIPasteboard (MyPasteBoard)


+ (UIPasteboard *) swizzled_generalPasteboard
{
    NSInteger res = ViewController.getPasteBoardPickerSelection;
    NSLog(@"Swizzled general pasteboard");
    
    UIPasteboard *pasteBoard;
    switch(res) {
        case 0:
            pasteBoard = [PasteBoards getGeneralPasteBoard];
            break;
        case 1:
            pasteBoard = [PasteBoards getNamedPasteboard];
            break;
        case 2:
            pasteBoard = [PasteBoards getUniquePasteboard];
            break;
    }
    return pasteBoard;
}

@end
