//
//  ArticleViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"
#import "NewsStory.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "MKAnnotationView+WebCache.h"


@interface ArticleViewController : UIViewController <UITextViewDelegate, UIWebViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleHeadline;


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NewsStory *newsStory;



-(IBAction)exitView:(id)sender;
-(IBAction)readMore:(id)sender;

@end
