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
#import "UIImage+Resize.h"


@interface NewsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RSSFeed
@synthesize title;
@synthesize link;
@synthesize comments;
@synthesize pubDate;
@synthesize categories;
@synthesize descriptionText;
@synthesize rssFeedImage;
@end

@implementation NewsViewController

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(instancetype) init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(160.0, 160.0);
    layout.minimumInteritemSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StKilda_logo.png"]];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
  //  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"article"];
    
    RSSFeedArray=[[NSMutableArray alloc] init];
    tableDataArray=[[NSMutableArray alloc] init];
    [self loadNews];
}

#pragma mark - Getting Data
-(void) loadNews{
    [RSSFeedArray removeAllObjects];
    feedTable.userInteractionEnabled=FALSE;
    
    NSURL *myUrl = [NSURL URLWithString:@"http://stkildanews.com/?cat=17&feed=rss2"];
    
    NSData *myData = [NSData dataWithContentsOfURL:myUrl];
    
    TBXML *sourceXML = [[TBXML alloc] initWithXMLData:myData error:nil];
    
  //  TBXML *tbxml = [TBXML tbxmlWithURL:[NSURL URLWithString :@"http://stkildanews.com/?cat=17&feed=rss2"]];
    TBXMLElement *rootelement = sourceXML.rootXMLElement; //Geting the rot node
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
            while (categoryElement) {
                [categories addObject:[TBXML textForElement:categoryElement]];
                categoryElement =[TBXML nextSiblingNamed:@"category" searchFromElement:categoryElement];
            }
            TBXMLElement *enclosureElement = [TBXML childElementNamed:@"enclosure" parentElement:itemElement];
            if (enclosureElement) {
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
    [feedTable reloadData];
    feedTable.userInteractionEnabled=TRUE;
    NSLog(@"THE DATA: %@",tableDataArray);
}

#pragma mark - UICollectionView Datasource
//1
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [tableDataArray count];
}

//2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;//change this
}

//3
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"article" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
    
    RSSFeed *feed=[tableDataArray objectAtIndex:indexPath.row];
    
    NSString *str = feed.title ;
    
    //Set the titles
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    title.text = [str stringByDecodingHTMLEntities];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    title.numberOfLines = 0;
    [title sizeToFit];
        
    //Set the images
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:2];
    
    [imageView setImageWithURL:[NSURL URLWithString:feed.rssFeedImage] placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    
//    UIImage *newImage;
//	CGSize newSize = resultView.frame.size;
//    
//    newImage = [imageView imageScaledToFitSize:newSize];
//    
//    
    return cell;
}

// 4
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
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *searchTerm = self.searches[indexPath.section]; FlickrPhoto *photo =
//    self.searchResults[searchTerm][indexPath.row];
    // 2
//    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
//    retval.height += 35; retval.width += 35; return retval;
    CGSize imgSize = CGSizeMake(145, 190);
    return imgSize;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 20, 10);
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewArticleDetails"]) {
        NewsViewController *newsViewController = segue.sourceViewController;
        newsViewController = sender;
    }
}

#pragma mark -SearchBar  Delegate Methods

@end
