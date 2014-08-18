//
//  ArticleViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "ArticleViewController.h"


@interface ArticleViewController ()


@property (weak) IBOutlet UIImageView *imageView;


@end


@implementation ArticleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

-(void) viewDidLayoutSubviews
{
//------ #1  :/
//    CGRect newBounds = _textInWebView.bounds;
//    newBounds.size.height =_textInWebView.scrollView.contentSize.height;
//    NSLog(@" newBounds.size.height = \n %f",newBounds.size.height);
//    newBounds.size.height = _textInWebView.scrollView.contentSize.height;
//    _textInWebView.bounds = newBounds;
    
 //----- #2 :(
//    
//        _textInWebView.frame = CGRectMake(_textInWebView.frame.origin.x, _textInWebView.frame.origin.y, _textInWebView.frame.size.width, _textInWebView.scrollView.contentSize.height);
//    
//    CGRect newFrame = _textInWebView.frame;
//    
//    [_textInWebView setFrame:newFrame];
    
    //------ #3
//    CGRect newFrame = _textInWebView.frame;
//    newFrame.size = CGSizeMake(self.textInWebView.frame.size.width, self.textInWebView.frame.origin.y);
//    [_textInWebView setFrame:newFrame];
    
 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textInWebView.delegate = self;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//----set headline ----
    [_articleImage setImageWithURL:[NSURL URLWithString:_newsStory.image] placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
    _articleHeadline.font = [UIFont fontWithName:@"BebasNeueBold" size:25];
    _articleHeadline.text = [_newsStory.headline stringByDecodingHTMLEntities];

    
 //   NSString *rawText = self.newsStory.story;
    NSString* htmlContentString = [NSString stringWithFormat:@"<html><head></head><body><p> %@ </p></body></html>", self.newsStory.story];
    
    
    [_textInWebView loadHTMLString:htmlContentString baseURL:nil];
    
}

#pragma mark -
#pragma mark UIWebViewDelegate methods


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@" _textInWebView.scrollView.contentSize.height = \n %f",_textInWebView.scrollView.contentSize.height);
   
//    CGRect newFrame = _textInWebView.frame;
//    newFrame.size = CGSizeMake(self.textInWebView.frame.size.width, self.textInWebView.frame.origin.y);
//    [_textInWebView setFrame:newFrame];
    
//    NSString *webHeight = [_textInWebView stringByEvaluatingJavaScriptFromString:@"document.height;"];
  //  NSLog(@"WebView Height %@", webHeight);
  //   float newHeight = [webHeight floatValue];
    
//    CGRect frame = _textInWebView.frame;
//    frame.size.height = _textInWebView.scrollView.contentSize.height;
//    _textInWebView.frame = frame;
//    
 //   CGSize fittingSize = [_textInWebView sizeThatFits:CGSizeZero];
  //  frame.size = fittingSize;
 //   _textInWebView.frame = frame;
    
   // NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
     //  [self.textInWebView sizeToFit];
    
    CGFloat newHeight = [[self.textInWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight;"] floatValue];
    
    //float h;
    
    float contentHeight = _textInWebView.scrollView.contentSize.height;
    CGRect frame = _textInWebView.frame;
    frame.size = CGSizeMake(_textInWebView.frame.size.width, contentHeight);
    self.textInWebView.frame = frame;
   // h = _textInWebView.scrollView.contentSize.height;

    _textInWebView.frame = CGRectMake(_textInWebView.frame.origin.x, _textInWebView.frame.origin.y, _textInWebView.frame.size.width, newHeight);
    
    NSString *heightString = [self.textInWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    
    NSLog(@"web content is %@ high",heightString);

    
    //[self.scrollView setContentSize:CGSizeMake(320, h)];
    
    
    //---- NO scolling Mr webView ----
    [[[_textInWebView subviews] lastObject] setScrollEnabled:NO];
    
}


-(IBAction)readMore:(id)sender
{
    
}

#pragma mark - Navigation

-(IBAction) exitView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
