//
//  ArticleViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/30/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"

@interface ArticleViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *descreptionTextView;
    IBOutlet UIImageView *imageNews;
    IBOutlet UIScrollView *scroll;
}

@property(nonatomic,retain)RSSFeed *currentFeed;

-(IBAction)readMore:(id)sender;

@end
