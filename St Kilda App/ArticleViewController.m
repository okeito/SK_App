//
//  ArticleViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "ArticleViewController.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "MKAnnotationView+WebCache.h"

@interface ArticleViewController ()


@property (weak) IBOutlet UIImageView *imageView;


@end


@implementation ArticleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [_articleImage setImageWithURL:[NSURL URLWithString:_newsStory.image] placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
    _articleHeadline.text = [_newsStory.headline stringByDecodingHTMLEntities];
    _articleHeadline.font = [UIFont fontWithName:@"BebasNeueBold" size:25];
    
    _articleText.text = [_newsStory.story stringByDecodingHTMLEntities];
//   
//   NSLog(@"\n \n passed and received data = %@",self.newsStory.headline);
//    NSLog(@"passed and received data = %@",self.newsStory.story);
//    
}

-(IBAction)readMore:(id)sender
{
    
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
