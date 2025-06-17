//
//  PasteBoards.h
//  IOSPasteBoardTestApp
//
//  Created by alexey on 13/05/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#ifndef PasteBoards_h
#define PasteBoards_h
@interface PasteBoards : NSObject
+ (UIPasteboard *) getGeneralPasteBoard;
+ (UIPasteboard *) getNamedPasteboard;
+ (UIPasteboard *) getUniquePasteboard;


+ (void) setNamedPasteBoard: (UIPasteboard *) pasteboard;


@end
#endif /* PasteBoards_h */
