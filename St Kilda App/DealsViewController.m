//
//  DealsViewController.m
//  St Kilda App
//
//  Created by Okeito on 4/5/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "DealsViewController.h"
#import "Deals.h"
#import "DealDetailsViewController.h"

#import "UIImageView+WebCache.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ProportionalFill.h"

#import "GAIDictionaryBuilder.h"

NSString * const WEB_LINK_DEAL = @"http://stkildanews.com/deals/";
NSString * const IMG_BASE_URL = @"http://stkildanews.com/wp-content/plugins/Deals/Images/%@";


@interface DealsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    TBXML *tbxml;
    UIActivityIndicatorView * activityView;
}
@end

@implementation DealsViewController

-(void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"DealsFeed"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    allDealsArray = [[NSMutableArray alloc] init];
    featuredDealsArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StKilda_logo.png"]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center=self.view.center;
    [activityView startAnimating];
    [self.view addSubview:activityView];

    [self performSelector:@selector(getDealsData) withObject:nil afterDelay:0.4];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDealsData
{
    
    NSOperationQueue * qeueu = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadDataWithOperation) object:nil];
    
    [qeueu addOperation:operation];
}


-(void) loadDataWithOperation
{
    NSURL *myUrl = [NSURL URLWithString:WEB_LINK_DEAL];
    NSData *myData = [NSData dataWithContentsOfURL:myUrl];
    TBXML *sourceXML = [[TBXML alloc] initWithXMLData:myData error:nil];
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    
    if(rootElement){
        
        TBXMLElement *dealsElement = [TBXML childElementNamed:@"deal" parentElement:rootElement];
        // TBXMLElement *dealsElement = [TBXML childElementNamed:@"deal" parentElement:channelElement];
        
        while (dealsElement) {
            
            TBXMLElement *featuredElement = [TBXML childElementNamed:@"featured" parentElement:dealsElement];
            
            NSString *stringFeatured = [TBXML textForElement:featuredElement];
            
            if ([stringFeatured isEqualToString:@"1"]) {
                
                // NSLog(@"this is a featured deal == %@",stringFeatured);
                
                Deals *objectDealsFeatured=[[Deals alloc]init];
                
                TBXMLElement *nameElement=[TBXML childElementNamed:@"title" parentElement:dealsElement];
                objectDealsFeatured.dealTitle=[TBXML textForElement:nameElement];
                
                TBXMLElement *fromDateElement=[TBXML childElementNamed:@"from_dur" parentElement:dealsElement];
                objectDealsFeatured.dealFromDate=[TBXML textForElement:fromDateElement];
                
                TBXMLElement *fromTimeElement=[TBXML childElementNamed:@"from_time" parentElement:dealsElement];
                objectDealsFeatured.dealFromTime=[TBXML textForElement:fromTimeElement];
                
                TBXMLElement *toDateElement=[TBXML childElementNamed:@"to_dur" parentElement:dealsElement];
                objectDealsFeatured.dealToDate=[TBXML textForElement:toDateElement];
                
                TBXMLElement *toTimeElement=[TBXML childElementNamed:@"to_time" parentElement:dealsElement];
                objectDealsFeatured.dealToTime=[TBXML textForElement:toTimeElement];
                
                TBXMLElement *imageNameElement=[TBXML childElementNamed:@"image_path" parentElement:dealsElement];
                objectDealsFeatured.dealImageName=[TBXML textForElement:imageNameElement];
                
                TBXMLElement *informationElement=[TBXML childElementNamed:@"info" parentElement:dealsElement];
                objectDealsFeatured.dealTheDeal=[TBXML textForElement:informationElement];
                
                TBXMLElement *priceElement=[TBXML childElementNamed:@"price" parentElement:dealsElement];
                objectDealsFeatured.dealPrice=[TBXML textForElement:priceElement];
                
                TBXMLElement *sendtoElement=[TBXML childElementNamed:@"sendto" parentElement:dealsElement];
                objectDealsFeatured.dealSendToMail=[TBXML textForElement:sendtoElement];
                
                TBXMLElement *valueElement=[TBXML childElementNamed:@"value" parentElement:dealsElement];
                objectDealsFeatured.dealValue=[TBXML textForElement:valueElement];
                
                TBXMLElement *businessElement=[TBXML childElementNamed:@"business" parentElement:dealsElement];
                objectDealsFeatured.dealBusiness=[TBXML textForElement:businessElement];
                
                TBXMLElement *finePrintElement=[TBXML childElementNamed:@"fine_print" parentElement:dealsElement];
                objectDealsFeatured.dealFinePrint=[TBXML textForElement:finePrintElement];
                
                NSString *stringImageName = [TBXML textForElement:imageNameElement];
                
                //UIImage *imageFeaturedDeal = [self downloadDealImage:stringImageName];
                
                objectDealsFeatured.dealImage = stringImageName;
                
                [featuredDealsArray addObject:objectDealsFeatured];
                [allDealsArray addObject:objectDealsFeatured];
                
            }
            else{
                
                Deals *objectDealsAll=[[Deals alloc]init];
                
                TBXMLElement *nameElement=[TBXML childElementNamed:@"title" parentElement:dealsElement];
                objectDealsAll.dealTitle=[TBXML textForElement:nameElement];
                
                TBXMLElement *fromDateElement=[TBXML childElementNamed:@"from_dur" parentElement:dealsElement];
                objectDealsAll.dealFromDate=[TBXML textForElement:fromDateElement];
                
                TBXMLElement *fromTimeElement=[TBXML childElementNamed:@"from_time" parentElement:dealsElement];
                objectDealsAll.dealFromTime=[TBXML textForElement:fromTimeElement];
                
                TBXMLElement *toDateElement=[TBXML childElementNamed:@"to_dur" parentElement:dealsElement];
                objectDealsAll.dealToDate=[TBXML textForElement:toDateElement];
                
                TBXMLElement *toTimeElement=[TBXML childElementNamed:@"to_time" parentElement:dealsElement];
                objectDealsAll.dealToTime=[TBXML textForElement:toTimeElement];
                
                TBXMLElement *imageNameElement=[TBXML childElementNamed:@"image_path" parentElement:dealsElement];
                objectDealsAll.dealImageName=[TBXML textForElement:imageNameElement];
                
                TBXMLElement *informationElement=[TBXML childElementNamed:@"info" parentElement:dealsElement];
                objectDealsAll.dealTheDeal=[TBXML textForElement:informationElement];
                
                TBXMLElement *priceElement=[TBXML childElementNamed:@"price" parentElement:dealsElement];
                objectDealsAll.dealPrice=[TBXML textForElement:priceElement];
                
                TBXMLElement *sendtoElement=[TBXML childElementNamed:@"sendto" parentElement:dealsElement];
                objectDealsAll .dealSendToMail=[TBXML textForElement:sendtoElement];
                
                TBXMLElement *valueElement=[TBXML childElementNamed:@"value" parentElement:dealsElement];
                objectDealsAll.dealValue=[TBXML textForElement:valueElement];
                
                TBXMLElement *businessElement=[TBXML childElementNamed:@"business" parentElement:dealsElement];
                objectDealsAll.dealBusiness=[TBXML textForElement:businessElement];
                
                TBXMLElement *finePrintElement=[TBXML childElementNamed:@"fine_print" parentElement:dealsElement];
                objectDealsAll.dealFinePrint=[TBXML textForElement:finePrintElement];
                
                NSString *stringImageName = [TBXML textForElement:imageNameElement];
                
                // UIImage *imageAllDeal = [self downloadDealImage:stringImageName];
                
                objectDealsAll.dealImage = stringImageName;
                
                [allDealsArray addObject:objectDealsAll];
            }
            
            dealsElement =[TBXML nextSiblingNamed:@"deal" searchFromElement:dealsElement];
        }
    }
    
    NSArray *sortedArray;
    sortedArray = [featuredDealsArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = [(Deals*)a dealFromDate];
        NSString *second = [(Deals*)b dealFromDate];
        return [first compare:second];
    }];
    
    NSArray *reversedArray = [[sortedArray reverseObjectEnumerator] allObjects];
    sortedDealsArray = [[NSMutableArray alloc]initWithArray:reversedArray];
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}


#pragma mark - UICollectionView Datasource
//1
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [sortedDealsArray count];
}

//2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;//change this
}

//3
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aDealCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aDealCell" forIndexPath:indexPath];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    [activityView stopAnimating];
    [activityView removeFromSuperview];
    
    Deals *objectDeals=[sortedDealsArray objectAtIndex:indexPath.row];
   
    //---- Set label title ------
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    titleLabel.text = objectDeals.dealTitle;
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont fontWithName:@"BebasNeueBold" size:20];
    // -- Set Label Price ----//
    UILabel *priceLabel = (UILabel *)[cell viewWithTag:2];
    priceLabel.font = [UIFont fontWithName:@"BebasNeueBold" size:28];
    priceLabel.text = [NSString stringWithFormat:@"$%@", objectDeals.dealPrice];
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:3];
    imageView.image = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        UIImage *oldImage = imageView.image;
        UIImage *newImage;
        CGSize newSize = imageView.frame.size;
        newImage = [oldImage imageToFitSize:newSize method:MGImageResizeCropStart];
        imageView.image = newImage;
        NSString *stringImageURL=[NSString stringWithFormat:IMG_BASE_URL ,objectDeals.dealImage];
        
        NSURL *url = [NSURL URLWithString:stringImageURL];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // --- Setting image -----//
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
            
        });
    });
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
    [self performSegueWithIdentifier:@"showDealDetails" sender:self];
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
    CGSize cellSize = CGSizeMake(300, 290);
    return cellSize;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 30, 10);
}

#pragma mark - Helper Methods



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDealDetails"])
    {
        NSArray *selectedCell = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [selectedCell firstObject];
        Deals *selectedDeal =[sortedDealsArray objectAtIndex:indexPath.row];
        DealDetailsViewController *dealDetails = segue.destinationViewController;
        dealDetails.selectedDeal = selectedDeal;
    }
}

@end
