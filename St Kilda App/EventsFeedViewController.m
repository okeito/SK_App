//
//  EventsFeedViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/31/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "EventsFeedViewController.h"
#import "EventsHeaderView.h"
#import "Event.h"
#import "NSString+HTML.h"
#import "UIImageView+WebCache.h"
#import "MKAnnotationView+WebCache.h"
#import "UIImage+ProportionalFill.h"
#import "DetailsOfEventViewController.h"

@interface EventsFeedViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
     TBXML *tbxml;
}

@end

@implementation EventsFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StKilda_logo.png"]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self getEventsData];
  
}

-(void) viewWillAppear:(BOOL)animated
{
       [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Getting Data
-(void)getEventsData
{
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(loadDataWithOperation)
                                                                              object:nil];
    
    /* Add the operation to the queue */
    [queue addOperation:operation];
}


- (void) loadDataWithOperation
{
    
    
    NSURL *myUrl = [NSURL URLWithString:@"http://stkildanews.com/events_feed/"];
    NSData *myData = [NSData dataWithContentsOfURL:myUrl];
    TBXML *sourceXML = [[TBXML alloc] initWithXMLData:myData error:nil];
    TBXMLElement *rootElement = sourceXML.rootXMLElement;
    
    if(rootElement)
    {
        arrayOfEvents = [[NSMutableArray alloc] init];
        
        TBXMLElement *channelElement = [TBXML childElementNamed:@"channel" parentElement:rootElement];
        TBXMLElement *eventsElement = [TBXML childElementNamed:@"item" parentElement:channelElement];
        while (eventsElement)
        {
            Event *objectEvents = [[Event alloc]init];
            arrayOfEventDates   = [[NSMutableArray alloc] init];
            
            TBXMLElement *nameElement=[TBXML childElementNamed:@"title" parentElement:eventsElement];
            objectEvents.eventName=[TBXML textForElement:nameElement];
            
            TBXMLElement *enclosureElement = [TBXML childElementNamed:@"enclosure" parentElement:eventsElement];
            if (enclosureElement)
            {
                NSString *imageLink = [TBXML valueOfAttributeNamed:@"url" forElement:enclosureElement];
                objectEvents.eventImage = imageLink;
            }
            
            TBXMLElement *dateElement=[TBXML childElementNamed:@"startdate" parentElement:eventsElement];
            objectEvents.eventDate=[TBXML textForElement:dateElement];
            
            [arrayOfEventDates addObject:objectEvents.eventDate];
            
            TBXMLElement *timeElement=[TBXML childElementNamed:@"starttime" parentElement:eventsElement];
            objectEvents.eventTime=[TBXML textForElement:timeElement];
            
            TBXMLElement *longt=[TBXML childElementNamed:@"location_longitude" parentElement:eventsElement];
            objectEvents.longt=[TBXML textForElement:longt];
            
            TBXMLElement *lang=[TBXML childElementNamed:@"location_latitude" parentElement:eventsElement];
            objectEvents.lang=[TBXML textForElement:lang];
            
            TBXMLElement *venueElemenet=[TBXML childElementNamed:@"description1" parentElement:eventsElement];
            objectEvents.eventInformation=[TBXML textForElement:venueElemenet];
            
            //--- Store each parsed event in array ---//
            [arrayOfEvents addObject:objectEvents];
            
            eventsElement =[TBXML nextSiblingNamed:@"item" searchFromElement:eventsElement];
        }
        
        dictEventsByDate = [[NSMutableDictionary alloc] init];
        NSMutableArray *uniqueDatesArray = [[NSMutableArray alloc]init];
        
        for (Event *event in arrayOfEvents) // ---> sorting of the events by date
        {
            // for each event check if array of unique dates contains its date, if not ->
            if (![uniqueDatesArray containsObject:event.eventDate])
            {
                [uniqueDatesArray addObject:event.eventDate]; // add its date to the array
            }
            // check if dictEventsByDate already contains array of events for current event's date key
            NSMutableArray *eventsForCurrentEventDateArray = [dictEventsByDate objectForKey:event.eventDate];
            
            // if there's no array of events for the current event's date key
            if (eventsForCurrentEventDateArray == NULL)
            {
                // create an array and add a current event to it
                eventsForCurrentEventDateArray = [[NSMutableArray alloc]initWithObjects:event, nil];
                // add this array as a value for a current event date key in our dictEventsByDate
                [dictEventsByDate setObject:eventsForCurrentEventDateArray forKey:event.eventDate];
            }
            else
            {
                // if some events exist for date in dictEventsByDate, + current event in (as it has the same date)
                [eventsForCurrentEventDateArray addObject:event];
            }
            
        }
        NSLog(@"\n dictEventsByDate =  %@",dictEventsByDate);
        
        keyDates = [[NSArray alloc]initWithArray:uniqueDatesArray];
    }
    
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

}


#pragma mark - UICollectionView Datasource
//--1
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    NSMutableArray *eventdForDateArray = [dictEventsByDate objectForKey:[keyDates objectAtIndex:section]];
    return [eventdForDateArray count];
}

//--2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    //-- return [keyDates count];//change this
    return [[dictEventsByDate allKeys]count];
}

//--3
- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"eventCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    NSString * date= [keyDates objectAtIndex:indexPath.section];
    NSArray * arrayOfEventsForDate = [dictEventsByDate objectForKey:date];
    Event * objectEvent = [arrayOfEventsForDate objectAtIndex:indexPath.row];
    
    
    //-- set Title label
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    titleLabel.font = [UIFont fontWithName:@"BebasNeueBold" size:17];
    titleLabel.text = objectEvent.eventName;
    //titleLabel.text = str;

     //-- set subText label
    UILabel *timeAndDateLabel = (UILabel *)[cell viewWithTag:2];
    NSString *appenedDateAndTime = [NSString stringWithFormat:@"%@ @ %@",objectEvent.eventTime,objectEvent.eventInformation];
    timeAndDateLabel.text = appenedDateAndTime;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        
        //--- Resizing Image -----//
        UIImageView *imageView= (UIImageView *)[cell viewWithTag:3];
        UIImage *oldImage = imageView.image;
        UIImage *newImage;
        CGSize newSize = imageView.frame.size;
        newImage = [oldImage imageToFitSize:newSize method:MGImageResizeCropStart];
        imageView.image = newImage;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
           
        [imageView sd_setImageWithURL:[NSURL URLWithString:objectEvent.eventImage]
                     placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];

            });
        });
    return cell;
}

//-- 4
- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
     EventsHeaderView *dateHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                          UICollectionElementKindSectionHeader withReuseIdentifier:@"dateHeader" forIndexPath:indexPath];

     NSString *strDate = [keyDates objectAtIndex:indexPath.section];
    //NSLog(@"\n strDate = %@ \n from \n (keyDates)= %@", strDate, keyDates);
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"dd/MM/yyyy"];
     NSDate *date = [formatter dateFromString:strDate];
   //  NSLog(@"Date::::: %@",date);
     [formatter setDateFormat:@"EEE"];
    // NSLog(@"DAY::: %@",[formatter stringFromDate:date]);
     
//     NSString *dateForLabel = [keyDates objectAtIndex:indexPath.section];

     NSString *dateForLabel = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:date],strDate];
     
     [dateHeaderView setDateLabelText:dateForLabel];
     
     return dateHeaderView;
 }


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    [self performSegueWithIdentifier:@"viewEventDetails" sender:self];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeMake(300, 175);
    return cellSize;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 15, 10);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segue Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"viewEventDetails"])
    {
        NSArray *selectedItems = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [selectedItems firstObject];
        
        
       NSString * date= [keyDates objectAtIndex:indexPath.section];
        NSArray * arrayOfEventsForDate = [dictEventsByDate objectForKey:date];
//        Event * objectEvent = [arrayOfEventsForDate objectAtIndex:indexPath.row];
//        
        Event *selectedEvent =[arrayOfEventsForDate objectAtIndex:indexPath.row];
        
        DetailsOfEventViewController *EvtDets = segue.destinationViewController;
        EvtDets.selectedEvent = selectedEvent;
        EvtDets.hidesBottomBarWhenPushed = YES;
    }

}


@end