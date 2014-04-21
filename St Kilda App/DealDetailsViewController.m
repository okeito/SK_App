//
//  DealDetailsViewController.m
//  St Kilda App
//
//  Created by Okeito on 4/19/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "DealDetailsViewController.h"
#import "UIImageView+WebCache.h"


@interface DealDetailsViewController ()

@end

@implementation DealDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self setLabelOutlets];
    [self setImageOutlet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods

-(void) setLabelOutlets
{
    labelHeading.text =  _selectedDeal.dealTitle ;
    textViewTheDeal.text =  _selectedDeal.dealTheDeal;
    textViewFinePrint.text = _selectedDeal.dealFinePrint;
    textViewTheBusiness.text =  _selectedDeal.dealBusiness;
    
    NSLog(@"dealSendToMail = %@", _selectedDeal.dealSendToMail);
    NSLog(@"price = %@", _selectedDeal.dealPrice);
    NSLog(@"dealFromDate = %@", _selectedDeal.dealFromDate);
    
    if (![_selectedDeal.dealValue isEqualToString:@""])
    {
        int intDealPrice = [_selectedDeal.dealPrice intValue];
        int intDealValue = [_selectedDeal.dealValue intValue];
        int intYouSave = intDealValue - intDealPrice;
        int intDiscount = (intYouSave * 100) / intDealValue;
        
        labelValue.text = [NSString stringWithFormat:@"$%@",_selectedDeal.dealValue];
        labelDiscount.text = [NSString stringWithFormat:@"%d%%",intDiscount];
        labelYouSave.text = [NSString stringWithFormat:@"$%d",intYouSave];
    }
}

-(void) setImageOutlet
{
    NSString *stringImageURL=[NSString stringWithFormat:@"http://stkildanews.com/wp-content/plugins/Deals/Images/%@",_selectedDeal.dealImage];
    NSURL *url = [NSURL URLWithString:stringImageURL];
    [imageViewDealImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    
    NSLog(@"dealImage = %@", _selectedDeal.dealImage);
    NSLog(@"dealImageName = %@", _selectedDeal.dealImageName);
}

-(IBAction)backAction:sender
{
    NSLog(@"Going back");
}

-(IBAction)bookDeal:(id)sende
{
    NSLog(@"Book BTN Pressed");
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
