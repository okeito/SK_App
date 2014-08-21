//
//  DetailsOfEventViewController.m
//  St Kilda App
//
//  Created by Okeito on 4/8/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "DetailsOfEventViewController.h"
#import "UIImageView+WebCache.h"

@interface DetailsOfEventViewController ()


@end

@implementation DetailsOfEventViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // Do any additional setup after loading the view.
    
//    NSLog(@"\n \n _selectedEvent.eventName = %@"
//          @"\n \n _selectedEvent.eventInformation = %@"
//          @"\n \n _selectedEvent.eventDate = %@"
//          @"\n \n _selectedEvent.eventTime = %@"
//          @"\n \n _selectedEvent.eventAddress = %@"
//          @"\n \n _selectedEvent.eventImageName = %@"
//          @"\n \n _selectedEvent.eventImage = %@"
//          @"\n \n _selectedEvent.longt = %@"
//          @"\n \n _selectedEvent.lang = %@"
//          ,_selectedEvent.eventName,
//          _selectedEvent.eventInformation,
//          _selectedEvent.eventDate,
//          _selectedEvent.eventTime,
//          _selectedEvent.eventAddress,
//          _selectedEvent.eventImageName,
//          _selectedEvent.eventImage,
//          _selectedEvent.longt,
//          _selectedEvent.lang);
    
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
