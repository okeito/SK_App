//
//  ArticleViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//


#import "ExtendedWebView.h"
#import "ArticleViewController.h"
#import "UIWebView+Dynamic.h"
#import "GAIDictionaryBuilder.h"
#import "ArticleHTMLParser.h"


@interface ArticleViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backBTN;

@property (weak) IBOutlet UIImageView *imageView;


@end


@implementation ArticleViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"ActicleView"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.webView.delegate = self;
    self.scrollView.delegate = self;
    
    //----set headline ----
    [_articleImage sd_setImageWithURL:[NSURL URLWithString:_newsStory.image] placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    _articleHeadline.font = [UIFont fontWithName:@"BebasNeueBold" size:27];
    _articleHeadline.text = [_newsStory.headline stringByDecodingHTMLEntities];

    //---- DO WEBVIEW IN CODE
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                   {
                       // Background work
                       ArticleHTMLParser *parser = [[ArticleHTMLParser alloc] init];
                       NSString *article = [parser parseArticleHTML:_newsStory.link];
                       NSLog(@"%@ %@", @"Article2: ", article);
                       
                       dispatch_async(dispatch_get_main_queue(), ^(void)
                                      {
                                          // Main thread work (UI usually)
                                          _newsStory.story = article;
                                          
                                          NSString* htmlContentString = [NSString stringWithFormat:@"<html><head></head><body><p> %@ </p></body></html>", self.newsStory.story];
                                          [_webView loadHTMLString:htmlContentString baseURL:nil];
                                      });
                   });
    
    

    [[[_webView subviews] lastObject] setScrollEnabled:NO];
    //  [self.view addSubview:_webView];
    
    //----- Future use of attributedStrings -------
    NSString *html = @"<bold>Wow!</bold> Now <em>iOS</em> can create <h3>NSAttributedString</h3> from HTMLs!";
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:nil error:nil];
    NSLog(@"this is how the attrString will print: %@", attrString);
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _backBTN.alpha = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _backBTN.alpha = 1;
}




#pragma mark -
#pragma mark UIWebViewDelegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    

    
}




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
 
    float newheight = [[webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"] floatValue];
    
    newheight = newheight + 460.00;
    [self.scrollView setContentSize:CGSizeMake(320, newheight)];
    [_webView.scrollView setContentInset:UIEdgeInsetsMake(40, 0, -40, 0)];
}




- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+3 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.webView loadHTMLString:errorString baseURL:nil];
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
