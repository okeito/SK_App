//
//  DetailsOfEventViewController.m
//  St Kilda App
//
//  Created by Okeito on 4/8/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "DetailsOfEventViewController.h"
#import "UIImageView+WebCache.h"

#import "GAIDictionaryBuilder.h"

@interface DetailsOfEventViewController ()

@property (nonatomic) IBOutlet UIButton *backBTN;

@end

@implementation DetailsOfEventViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _backBTN.alpha = 1;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"EventDetails"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    
    self.dateAndTime.text = [@[_selectedEvent.eventDate, _selectedEvent.eventTime] componentsJoinedByString:@" @ "];
    self.eventTitle.text = _selectedEvent.eventName;
    self.eventTitle.font= [UIFont fontWithName:@"BebasNeueBold" size:25];
    self.eventInfo.text = _selectedEvent.eventInformation;
    
    [_imageForEvent sd_setImageWithURL:[NSURL URLWithString:_selectedEvent.eventImage] placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    
    MKPointAnnotation*  annotation = [[MKPointAnnotation alloc] init];
    
    _eventCoordinate.latitude= [_selectedEvent.lang doubleValue];
    _eventCoordinate.longitude= [_selectedEvent.longt doubleValue];
    annotation.coordinate = _eventCoordinate;
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region;
    region.center.latitude = _eventCoordinate.latitude;
    region.center.longitude = _eventCoordinate.longitude;
//    region.span.latitudeDelta = spanX;
//    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
   
}


-(IBAction) exitView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
