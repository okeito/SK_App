//
//  DetailsOfEventViewController.h
//  St Kilda App
//
//  Created by Okeito on 4/8/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "EventsFeedViewController.h"
#import <MapKit/MapKit.h>

@interface DetailsOfEventViewController : UIViewController <MKMapViewDelegate, UIScrollViewDelegate>

@property(nonatomic, assign) CLLocationCoordinate2D eventCoordinate;


@property (nonatomic, strong) Event * selectedEvent;

@property (weak, nonatomic) IBOutlet UILabel *dateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageForEvent;
@property (weak, nonatomic) IBOutlet UITextView *eventInfo;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



- (IBAction)exitView:(UIButton *)sender;

@end

