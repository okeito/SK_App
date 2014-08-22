//
//  UIWebView+Dynamic.m
//  St Kilda
//
//  Created by Okeito on 8/21/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "UIWebView+Dynamic.h"

@implementation UIWebView (Dynamic)


+(void)reLayoutFrame:(float*)height
{
//    
//    float h = *height;
//    self->frame = CGRectMake(self->frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
//------ #1  :/
//    CGRect newBounds = _webView.bounds;
//    newBounds.size.height =_webView.scrollView.contentSize.height;
//    NSLog(@" newBounds.size.height = \n %f",newBounds.size.height);
//    newBounds.size.height = _webView.scrollView.contentSize.height;
//    _webView.bounds = newBounds;
//
//----- #2 :(
//
//    _webView.bounds = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, _webView.scrollView.contentSize.height);
//    CGRect newFrame = _webView.frame;
//    [_webView setFrame:newFrame];


//    _webView.bounds = _webView.frame;


//NSLog(@"\n _webView.scrollView.contentSize.height = \n %f", _webView.scrollView.contentSize.height);

//int content_height = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] integerValue];
//
//_webView.frame = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, content_height);

//    CGRect rect = _webView.frame;
//    rect.size.height = content_height;
//    _webView.frame = rect;


//    CGRect frame = _webView.frame;
//    frame.size.height = _webView.scrollView.contentSize.height;
//    _webView.frame = frame;


// NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
//  [self.webView sizeToFit];
//
//   float h = ;
//CGFloat newHeight;
//  float h = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight;"] floatValue];
//h = _webView.scrollView.contentSize.height;

//
//    float contentHeight = _webView.scrollView.contentSize.height;
//    CGRect frame = _webView.frame;
//    frame.size = CGSizeMake(_webView.frame.size.width, contentHeight);
//    self.webView.frame = frame;
//
//    NSString *heightString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
//    NSLog(@"web content is %@ high",heightString);

//    _webView.bounds = _webView.frame;


//    NSString *webHeight = [_webView stringByEvaluatingJavaScriptFromString:@"document.height;"];
//    float newHeight = [webHeight floatValue];
//    NSLog(@"WebView Height %f", newHeight);
//    _webView.frame = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, newHeight);
//    _webView.bounds = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, newHeight);`

//[self.scrollView setContentSize:CGSizeMake(320, _webView.scrollView.contentSize.height)];

}

@end
