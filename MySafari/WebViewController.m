//
//  ViewController.m
//  MySafari
//
//  Created by Tommy Gibbons on 3/11/15.
//  Copyright (c) 2015 Tommy Gibbons. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
   [self performLoadRequestWithString:@"http://www.google.com"];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self performLoadRequestWithString:textField.text];
    [textField resignFirstResponder];
    return YES;
}

-(void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest: request];
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
    [self.webView goForward];
    
}

- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
}



@end
