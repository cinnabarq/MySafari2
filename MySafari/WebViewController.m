//
//  ViewController.m
//  MySafari
//
//  Created by Tommy Gibbons on 3/11/15.
//  Copyright (c) 2015 Tommy Gibbons. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate,UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
   [self performLoadRequestWithString:@"http://www.google.com"];
    self.webView.scrollView.delegate = self;

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performLoadRequestWithString:textField.text];
    [textField resignFirstResponder];
    return YES;

}


-(void)performLoadRequestWithString:(NSString *)string
{
    if([self.urlTextField.text hasPrefix: @"http://"]){
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
    }else{
        NSMutableString *newURL = [NSMutableString stringWithString:string];
        [newURL insertString:@"http://" atIndex:0];
        NSURL *String2 = [NSURL URLWithString:newURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:String2];
        [self.webView loadRequest: request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.networkActivityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.networkActivityIndicator startAnimating];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    if (self.webView.canGoForward)//checks to see if on current page
    {
    [self.webView goForward];
    }
    
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onBackButtonPressed:(id)sender
{
    if(self.webView.canGoBack){ //checks to see if on first page
    [self.webView goBack];
    }
}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.webView reload];
}
- (IBAction)onPlusButtonTap:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -UIScrollViewDelegate Protocols

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.urlTextField setHidden:YES];
}

@end
