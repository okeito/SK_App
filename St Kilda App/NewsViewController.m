//
//  NewsViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/26/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "NewsViewController.h"
#import "ArticleViewController.h"
#import "TBXML.h"
#import "ArticleCell.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ProportionalFill.h"
#import "UICustomLabel.h"
#import "RSSFeed.h"


@interface NewsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end


@implementation NewsViewController


//-(instancetype) init
//{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(160.0, 160.0);
//    layout.minimumInteritemSpacing = 1.0;
//    return (self = [super initWithCollectionViewLayout:layout]);
//}

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StKilda_logo.png"]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    RSSFeedArray=[[NSMutableArray alloc] init];
    tableDataArray=[[NSMutableArray alloc] init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self loadNews];
        });
    });
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    
}


#pragma mark - Getting Data

-(void) loadNews
{
    [RSSFeedArray removeAllObjects];
 //   feedTable.userInteractionEnabled=FALSE;
    
    NSURL *myUrl = [NSURL URLWithString:@"http://stkildanews.com/?cat=17&feed=rss2"];
    NSData *myData = [NSData dataWithContentsOfURL:myUrl];
    TBXML *sourceXML = [[TBXML alloc] initWithXMLData:myData error:nil];
    
    TBXMLElement *rootelement = sourceXML.rootXMLElement; //Geting the root node
    if(rootelement) {
        TBXMLElement *channelElement = [TBXML childElementNamed:@"channel" parentElement:rootelement];
        TBXMLElement *itemElement = [TBXML childElementNamed:@"item" parentElement:channelElement];
        while (itemElement) {
            RSSFeed *feed=[[RSSFeed alloc] init];
            TBXMLElement *titleElement = [TBXML childElementNamed:@"title" parentElement:itemElement];
            feed.title=[TBXML textForElement:titleElement];
            
            NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"&#1234567890;"];
            feed.title = [[feed.title componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
            
            TBXMLElement *linkElement = [TBXML childElementNamed:@"link" parentElement:itemElement];
            feed.link=[TBXML textForElement:linkElement];
            
            TBXMLElement *pubDateElement = [TBXML childElementNamed:@"pubDate" parentElement:itemElement];
            feed.pubDate=[TBXML textForElement:pubDateElement];
            
            TBXMLElement *commentsElement = [TBXML childElementNamed:@"comments" parentElement:itemElement];
            feed.comments=[TBXML textForElement:commentsElement];
            
            TBXMLElement *descriptionElement = [TBXML childElementNamed:@"description1" parentElement:itemElement];
            feed.descriptionText=[TBXML textForElement:descriptionElement];
            
            TBXMLElement *categoryElement = [TBXML childElementNamed:@"category" parentElement:itemElement];
            
            NSMutableArray *categories=[[NSMutableArray alloc] init];
            while (categoryElement)
            {
                [categories addObject:[TBXML textForElement:categoryElement]];
                categoryElement =[TBXML nextSiblingNamed:@"category" searchFromElement:categoryElement];
            }
            TBXMLElement *enclosureElement = [TBXML childElementNamed:@"enclosure" parentElement:itemElement];
            if (enclosureElement)
            {
                NSString *imageLink = [TBXML valueOfAttributeNamed:@"url" forElement:enclosureElement];
                feed.rssFeedImage = imageLink;
            }
            
            feed.categories=categories;
            [RSSFeedArray addObject:feed];
            itemElement =[TBXML nextSiblingNamed:@"item" searchFromElement:itemElement];
        }
    }
    else
        [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    tableDataArray=[NSMutableArray arrayWithArray:RSSFeedArray];
//    [feedTable reloadData];
//    feedTable.userInteractionEnabled=TRUE;
    // NSLog(@"THE DATA: %@",tableDataArray);
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView Datasource
//-1
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [tableDataArray count];
}

//-2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;//change this
}

//-3
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"article" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    RSSFeed *feed=[tableDataArray objectAtIndex:indexPath.row];

    //---- Set label title ------
    NSString *str = feed.title;
    UICustomLabel *headline = (UICustomLabel *)[cell viewWithTag:1];
    headline.font = [UIFont fontWithName:@"BebasNeueBold" size:17];

    headline.topInset = 2;
    headline.leftInset = 5;
    headline.bottomInset = 3;
    headline.rightInset = 5;
    headline.text = [str stringByDecodingHTMLEntities];
    [headline setLineBreakMode:NSLineBreakByWordWrapping];
    headline.numberOfLines = 0;
    [headline sizeToFit];
    headline.backgroundColor = [UIColor  colorWithWhite:1 alpha:0.92];
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:2];
    dispatch_async(queue, ^{
        
        [imageView setImageWithURL:[NSURL URLWithString:feed.rssFeedImage] placeholderImage:[UIImage imageNamed:@"Placeholder.png"]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // --- Setting image -----//
            
            imageView.clipsToBounds = YES;
            imageView.backgroundColor = [UIColor lightGrayColor];
            
            // --- Resizing Image -----//
            UIImage *oldImage = imageView.image;
            UIImage *newImage;
            CGSize newSize = imageView.frame.size;
            // newImage = [oldImage imageScaledToFitSize:newSize]; // uses MGImageResizeScale
            // newImage = [oldImage imageCroppedToFitSize:newSize]; // uses MGImageResizeCrop
            // newImage = [oldImage imageToFitSize:newSize method:MGImageResizeCropStart];
            newImage = [oldImage imageToFitSize:newSize method:MGImageResizeCropEnd];
            imageView.image = newImage;
            
        });
    });
    
    return cell;
}

//-- 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    [self performSegueWithIdentifier:@"viewArticleDetails" sender:self];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize imgSize = CGSizeMake(145, 190);
    return imgSize;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 20, 10);
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"viewArticleDetails"])
    {
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [selectedItems firstObject];
        
        RSSFeed *feed=[tableDataArray objectAtIndex:indexPath.row];
        NewsStory *newsStory = [[NewsStory alloc] init];
        newsStory.image = feed.rssFeedImage;
        newsStory.headline = feed.title;
        newsStory.story = feed.descriptionText;
    
        ArticleViewController *AVC = segue.destinationViewController;
        AVC.newsStory=newsStory;
        //NSLog(@"all of  it: %@", newsStory.story);
    }
}

#pragma mark -SearchBar  Delegate Methods



@end
