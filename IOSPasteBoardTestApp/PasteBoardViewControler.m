//
//  ViewController.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 03/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import "PasteBoardViewControler.h"
#import <Webkit/Webkit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"https://www.google.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    [self.wkWebView loadRequest:urlRequest];
}
- (IBAction)showPasteBoard:(id)sender {
    NSLog(@"button showPasteBoard clicked");
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    NSLog(@"strings : %@", pasteboard.strings);
    NSLog(@"images : %@", pasteboard.images);
    NSLog(@"URLs : %@", pasteboard.URLs);
    NSLog(@"colors : %@", pasteboard.colors);
    
    NSLog(@"first pasteboardTypes : %@", pasteboard.pasteboardTypes);
}

- (IBAction)clearPasteBoard:(id)sender {
    NSLog(@"button clearPasteBoard clicked");
    //copy from https://stackoverflow.com/questions/11067554/how-to-clear-empty-pasteboard-on-viewwilldisappear
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:@"" forPasteboardType:UIPasteboardNameGeneral];
    //end copy
}

@end

