//
//  SocialWebViewController.m
//  St Kilda
//
//  Created by Okeito on 4/24/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "SocialWebViewController.h"


@interface SocialWebViewController ()

@end

@implementation SocialWebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_destinationUrl];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Webview delegate method

- (void)webViewDidStartLoad:(UIWebView *)webView
{
   _activityIndicator.hidden = false;
    [_activityIndicator startAnimating];
    NSLog(@"\n \n webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityIndicator stopAnimating];
    _activityIndicator.hidden = true;
    NSLog(@" \n \nwebViewDidFinishLoad");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
