//
//  SocialWebViewController.h
//  St Kilda
//
//  Created by Okeito on 4/24/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSURL* destinationUrl;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
