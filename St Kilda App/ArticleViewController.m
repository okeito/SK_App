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
    [super viewDidLayoutSubviews];
    
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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.webView.delegate = self;
    
//----set headline ----
    [_articleImage sd_setImageWithURL:[NSURL URLWithString:_newsStory.image] placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    _articleHeadline.font = [UIFont fontWithName:@"BebasNeueBold" size:25];
    _articleHeadline.text = [_newsStory.headline stringByDecodingHTMLEntities];

//---- DO WEBVIEW IN CODE
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 360, 300, 300)];

    
    NSString* htmlContentString = [NSString stringWithFormat:@"<html><head></head><body><p> %@ </p></body></html>", self.newsStory.story];
    [_webView loadHTMLString:htmlContentString baseURL:nil];
    [[[_webView subviews] lastObject] setScrollEnabled:NO];
//  [self.view addSubview:_webView];
}

#pragma mark -
#pragma mark UIWebViewDelegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    CGRect frame = webView.frame;
    
    frame.size.height = 5.0f;
    
    webView.frame = frame;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//       _webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webView.frame.size.width, [_webView sizeThatFits:CGSizeZero].height);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"\n _webView.scrollView.contentSize.height = \n %f", _webView.scrollView.contentSize.height);
   
    int content_height = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] integerValue];
    
    _webView.frame = CGRectMake(_webView.frame.origin.x, _webView.frame.origin.y, _webView.frame.size.width, content_height);
    
    
    CGSize mWebViewTextSize = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)];  // Pass about any size
    
    CGRect mWebViewFrame = webView.frame;
    
    
    mWebViewFrame.size.height = mWebViewTextSize.height;
    
    webView.frame = mWebViewFrame;
    
    
    //Disable bouncing in webview
    for (id subview in webView.subviews)
    {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
        {
            [subview setBounces:NO];
        }
    }
    
    
//    CGRect rect = _webView.frame;
//    rect.size.height = content_height;
//    _webView.frame = rect;
    
    
//    CGRect frame = _webView.frame;
//    frame.size.height = _webView.scrollView.contentSize.height;
//    _webView.frame = frame;
//
 //   CGSize fittingSize = [_webView sizeThatFits:CGSizeZero];
  //  frame.size = fittingSize;
 //   _webView.frame = frame;
    
   // NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
     //  [self.webView sizeToFit];
//
//    float h;
//    CGFloat newHeight
//    h = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight;"] floatValue];
//    h = _webView.scrollView.contentSize.height;
   
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

    [self.scrollView setContentSize:CGSizeMake(320, _webView.scrollView.contentSize.height)];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.webView loadHTMLString:errorString baseURL:nil];
    
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
//    UIWebView *webView = [UIView autolayoutView];
//    NSDictionary *views = NSDictionaryOfVariableBindings(headerView,headline,byline,imageView,button);
//    NSDictionary *metrics = @{@"width":@300.0,@"height":@300.0};
//    _webView.translatesAutoresizingMaskIntoConstraints = NO;
//    [super updateViewConstraints];
//    [self.webView addConstraint:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webView]-|"options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:metrics views:views]];
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
