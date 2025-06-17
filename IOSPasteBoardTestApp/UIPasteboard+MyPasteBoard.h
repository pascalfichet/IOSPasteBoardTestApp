//
//  UIPasteboard+MyPasteBoard.h
//  IOSPasteBoardTestApp
//
//  Created by alexey on 30/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>



@interface UIPasteboard (MyPasteBoard)
+ (UIPasteboard *) swizzled_generalPasteboard;
@end

