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

@interface DetailsOfEventViewController : UIViewController

@property (nonatomic, strong) Event * selectedEvent;

@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageForEvent;
@property (weak, nonatomic) IBOutlet UITextView *eventInfo;

- (IBAction)exitView:(UIButton *)sender;

@end

