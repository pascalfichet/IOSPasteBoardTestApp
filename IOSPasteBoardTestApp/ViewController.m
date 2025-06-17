//
//  ViewController.m
//  IOSPasteBoardTestApp
//
//  Created by alexey on 03/04/2019.
//  Copyright © 2019 alexey. All rights reserved.
//

#import "ViewController.h"
#import <Webkit/Webkit.h>
#import <objc/runtime.h>
#import "PasteBoards.h"


#import <SafariServices/SafariServices.h>

NSInteger pickerSelecetion;




@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *pasteImageView;
@property (weak, nonatomic) IBOutlet UIPickerView *pasteBoardPicker;
@property (weak, nonatomic) IBOutlet UIButton *showPasteboard;

@property (nonatomic, assign) UIViewAnimationOptions shakeAnimationOptions;
@property (nonatomic, assign) BOOL animationInProgress;
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UITextField *pasteBoardNameView;
@property UIPasteboard *pasteboard;

@property CGColorRef borderColor;
@property float borderSize;

@end

@implementation ViewController


+ (NSInteger) getPasteBoardPickerSelection{
    return pickerSelecetion;
}

- (void)initDevEventListener {
    //TODO: need to change the "BlockedClipboardEvent" to pasteboard alert key
    [[NSNotificationCenter defaultCenter] addObserverForName: @"BlockedClipboardEvent" object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *blocked = [[note userInfo] objectForKey:@"blocked"]; // True/false
            NSLog(@"clipboard dev-event Received %@", blocked);
            [self animateShowPasteboardButton];
        });
    }];
}


- (void)initBorderParameters {
    self.borderColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
    self.borderSize = 5.0f;
}

- (void)initWKWebView {
    NSURL *googleUrl = [NSURL URLWithString:@"https://www.google.com/"];
    NSURLRequest *googleUrlRequest = [NSURLRequest requestWithURL:googleUrl];
    [self.wkWebView loadRequest:googleUrlRequest];
    self.wkWebView.layer.borderColor = self.borderColor;
    self.wkWebView.layer.borderWidth = self.borderSize;
}

- (void)initWebView {
    NSURL *yahooUrl = [NSURL URLWithString:@"https://www.yahoo.com"];
    NSURLRequest *yahooUrlRequest = [NSURLRequest requestWithURL:yahooUrl];
    [self.webView loadRequest:yahooUrlRequest];
    self.webView.layer.borderColor = self.borderColor;
    self.webView.layer.borderWidth = self.borderSize;
}

- (void)initCopyImageView {
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageCopyTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    imageCopyTapGesture.numberOfTapsRequired = 1;
    [imageCopyTapGesture setDelegate:self];
    [_imageView addGestureRecognizer:imageCopyTapGesture];
    [imageCopyTapGesture reset];
}

- (void)initPasteImageView {
    self.pasteImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imagePasteGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(pasteGesture:)];
    imagePasteGesture.numberOfTapsRequired = 1;
    [imagePasteGesture setDelegate:self];
    [self.pasteImageView addGestureRecognizer:imagePasteGesture];
    [imagePasteGesture reset];
    
    self.pasteImageView.layer.borderColor = self.borderColor;
    self.pasteImageView.layer.borderWidth = self.borderSize;
}

- (void)initKeyboardClose {
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
    viewTapGesture.numberOfTapsRequired = 1;
    [viewTapGesture setDelegate:self];
    [self.view addGestureRecognizer:viewTapGesture];
    [viewTapGesture reset];
}

- (NSString *)setPasteBoardNameInputView {
    return _pasteBoardNameView.text = uiPasteboradName;
}

- (void)setPickerDelegates {
    _pasteBoardPicker.dataSource = self;
    _pasteBoardPicker.delegate = self;
}

- (void)viewDidLoad {
    NSLog(@"viewDidLoad called");
    [super viewDidLoad];
    
    [self setPickerDelegates];
    [self setPasteBoardNameInputView];
    [self initDevEventListener];
    [self initBorderParameters];
    [self initWebView];
    [self initWKWebView];
    [self initCopyImageView];
    [self initPasteImageView];
    [self initKeyboardClose];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    switch(row) {
        case 0:
            title = @"General";
            break;
        case 1:
            title = @"WithName";
            break;
        case 2:
            title = @"WithUniqueName";
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    NSLog(@"picker item selected %ld", (long)row);
    pickerSelecetion = row;
}

- (void) viewTapGesture: (id)sender
{
    NSLog(@"view taped");
    [self.view endEditing:YES];
}

- (void) pasteGesture: (id)sender
{
    UIImage *imageFromPasteBoard = [[UIPasteboard generalPasteboard] image];
    self.pasteImageView.image = imageFromPasteBoard;
}

- (void) tapGesture: (id)sender
{
    NSLog(@"image View tap");
    [UIView animateKeyframesWithDuration:0.05
                                   delay:0.0
                                 options:_shakeAnimationOptions
                              animations:^{
                                  _imageView.frame = CGRectMake(_imageView.frame.origin.x + 20, _imageView.frame.origin.y, _imageView.frame.size.width, _imageView.frame.size.height);
                              }
                              completion:^(BOOL finished) {
                                  [UIView animateKeyframesWithDuration:0.05
                                                                 delay:0.0
                                                               options:self->_shakeAnimationOptions
                                                            animations:^{
                                                                _imageView.frame = CGRectMake(_imageView.frame.origin.x - 20, _imageView.frame.origin.y, _imageView.frame.size.width, _imageView.frame.size.height);
                                                            }
                                                            completion:^(BOOL finished) {
                                                                self->_animationInProgress = NO;
                                                            }];
                              }];
    
    
    UIImage *copiedImage = _imageView.image;
    [[UIPasteboard generalPasteboard] setImage:copiedImage];

}
- (void) changeNamedPasteboard {
    NSString *newName = self.pasteBoardNameView.text;
    NSLog(@"changeNamedPasteboard renaming named pasteboard to %@", newName);
    UIPasteboard *namedPasteboard = [UIPasteboard pasteboardWithName:newName create:YES];
    [PasteBoards setNamedPasteBoard:namedPasteboard];
}

- (IBAction)changeNamedPasteboard:(id)sender {
    [self changeNamedPasteboard];
}

- (IBAction)showPasteBoard:(id)sender {
    NSLog(@"button showPasteBoard clicked");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ShowPasteBoardViewController *vc = (ShowPasteBoardViewController*)[storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)clearPasteBoard:(id)sender {
    NSLog(@"button clearPasteBoard clicked");
    [[UIPasteboard generalPasteboard] setValue:@"" forPasteboardType:UIPasteboardNameGeneral];
}
- (IBAction)openSafari:(id)sender {
    NSLog(@"open Safari clicked");
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:url];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
}

- (void) animateShowPasteboardButton {
    UIButton *thisButton = self->_showPasteboard;
    [UIView animateKeyframesWithDuration:0.1
                                   delay:0.0
                                 options:_shakeAnimationOptions
                              animations:^{
                                  thisButton.frame = CGRectMake(thisButton.frame.origin.x + 20, thisButton.frame.origin.y, thisButton.frame.size.width, thisButton.frame.size.height);
                              }
                              completion:^(BOOL finished) {
                                  [UIView animateKeyframesWithDuration:0.1
                                                                 delay:0.0
                                                               options:self->_shakeAnimationOptions
                                                            animations:^{
                                                                thisButton.frame = CGRectMake(thisButton.frame.origin.x - 20, thisButton.frame.origin.y, thisButton.frame.size.width, thisButton.frame.size.height);
                                                            }
                                                            completion:^(BOOL finished) {
                                                                self->_animationInProgress = NO;
                                                            }];
                              }];
}

@end
