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


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view.
    
    NSLog(@"\n \n _selectedEvent.eventName = %@"
          @"\n \n _selectedEvent.eventInformation = %@"
          @"\n \n _selectedEvent.eventDate = %@"
          @"\n \n _selectedEvent.eventTime = %@"
          @"\n \n _selectedEvent.eventAddress = %@"
          @"\n \n _selectedEvent.eventImageName = %@"
          @"\n \n _selectedEvent.eventVenue = %@"
          @"\n \n _selectedEvent.eventImage = %@"
          @"\n \n _selectedEvent.longt = %@"
          @"\n \n _selectedEvent.lang = %@"
          ,_selectedEvent.eventName,
          _selectedEvent.eventInformation,
          _selectedEvent.eventDate,
          _selectedEvent.eventTime,
          _selectedEvent.eventAddress,
          _selectedEvent.eventImageName,
          _selectedEvent.eventVenue,
          _selectedEvent.eventImage,
          _selectedEvent.longt,
          _selectedEvent.lang);
    
    
    self.eventTitle.text = _selectedEvent.eventName;
    self.eventTitle.font= [UIFont fontWithName:@"BebasNeueBold" size:25];
    
    self.eventInfo.text = _selectedEvent.eventInformation;
  //  _selectedEvent.eventDate;
   // _selectedEvent.eventTime;
   // _selectedEvent.eventAddress;
    [_imageForEvent setImageWithURL:[NSURL URLWithString:_selectedEvent.eventImage]
                   placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
   // _selectedEvent.eventVenue;
    
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
