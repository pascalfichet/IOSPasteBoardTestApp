//
//  SecondViewController.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 11/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import "ShowPasteBoardViewController.h"
#import "Utils.h"


@interface ShowPasteBoardViewController ()
@property (weak, nonatomic) IBOutlet UITextView *pasteBoardContent;
@property UIPasteboard *pasteBoard;
@property (weak, nonatomic) IBOutlet UILabel *pasteBoardName;


@end

@implementation ShowPasteBoardViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pasteBoard = [UIPasteboard generalPasteboard];
    
    _pasteBoardName.text = _pasteBoard.name;
    
    NSLog(@"ShowPasteBoardViewController pasteBoard : %@", _pasteBoard);
    NSLog(@"strings : %@", _pasteBoard.strings);
    for(NSString* string in _pasteBoard.strings){
        
        NSLog(@"string: %@", string);
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"string : %@\n\n", string]];
    }
    
    NSLog(@"images : %@", _pasteBoard.images);
    for (UIImage* image in _pasteBoard.images) {
        NSLog(@"image :%@", image);
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"image : %@\n\n", image]];
    }
    
    NSLog(@"URLs : %@", _pasteBoard.URLs);
    for (NSURL* url in _pasteBoard.URLs ) {
        NSLog(@"url :%@", url);
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"url : %@\n\n", url]];
    }
    
    NSLog(@"colors : %@", _pasteBoard.colors);
    for (UIColor* color in _pasteBoard.colors) {
        NSLog(@"color :%@", color);
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"color : %@\n\n", color]];
    }
    
    NSLog(@"first pasteboardTypes : %@", _pasteBoard.pasteboardTypes);
    _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"UTIs : %@\n\n", _pasteBoard.pasteboardTypes]];
    
    _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:@"data:(\n"];
    
    for (NSString *type in _pasteBoard.pasteboardTypes) {
        
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"UTIs : %@\n", type]];
        NSData *data = [[UIPasteboard generalPasteboard]dataForPasteboardType:type];
        NSString* dataString = [Utils hexString:data length:10];
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"data : %@...\n\n", [dataString substringWithRange:NSMakeRange(0, dataString.length)]]];
        
        NSObject *theValue = [[UIPasteboard generalPasteboard]valueForPasteboardType:type];
        NSLog(@"class value :%@", [theValue class]);
        if ([theValue isKindOfClass:[NSString class]]) {
            NSString *valueString =[(NSString *)theValue copy];
            _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"value is a string: %@...\n\n", [valueString substringWithRange:NSMakeRange(0, MIN(10, valueString.length))]]];
        } else {
            NSString *decription = [theValue description];
            _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"value is not a string: %@...\n\n", [decription substringWithRange:NSMakeRange(0, MIN(10, dataString.length))]]];
        }
    }
    
    _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:@")\n"];
    _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:@"\n\nItemProviders:\n"];
    NSArray<NSItemProvider *> *itemProviders = [_pasteBoard itemProviders];
    for (NSItemProvider *itemProvider in itemProviders) {
        _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"itemProvider : %@\n\n", itemProvider]];
        NSArray<NSString *> *types = [itemProvider registeredTypeIdentifiers];
        for (NSString *type in types) {
            
            [itemProvider loadDataRepresentationForTypeIdentifier:type completionHandler: ^( NSData *data, NSError * error )
             {
                 if ( NULL != error )
                 {
                     NSLog( @"There was an error retrieving the attachments: %@", error );
                     return;
                 }
                 
                 NSString *stringRepresentation = [Utils hexString:data length:10];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.pasteBoardContent.text = [self->_pasteBoardContent.text stringByAppendingString:[NSString stringWithFormat:@"UTI: %@ \ndata: %@...\n\n", type, stringRepresentation]];
                 });
             } ];
        }
    }
     _pasteBoardContent.text = [_pasteBoardContent.text stringByAppendingString:@"\n)"];
    
}
- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
