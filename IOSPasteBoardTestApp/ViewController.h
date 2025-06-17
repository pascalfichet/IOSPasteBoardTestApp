//
//  ViewController.h
//  IOSPasteBoardTestApp
//
//  Created by alexey on 03/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShowPasteBoardViewController.h"
#import "constants.h"

@interface ViewController : UIViewController
-(void) animateShowPasteboardButton;
+(NSInteger) getPasteBoardPickerSelection;

@end

