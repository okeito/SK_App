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

@interface ArticleViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleHeadline;
@property (weak, nonatomic) IBOutlet UITextView *articleText;

@property (nonatomic, strong) NewsStory *newsStory;


-(IBAction)readMore:(id)sender;

@end
