//
//  DealDetailsViewController.m
//  St Kilda App
//
//  Created by Okeito on 4/19/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "DealDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "SocialWebViewController.h"

#import "GAIDictionaryBuilder.h"


@interface DealDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIButton *backBTN;

@end

@implementation DealDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"DetailsOfDeal"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.scrollView.delegate = self;
    [self setLabelOutlets];
    [self setImageOutlet];
    //[self.scrollView setContentSize: CGSizeMake(320, 568)];
    //self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
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
    
    NSLog(@"\n dealSendToMail = %@", _selectedDeal.dealSendToMail);
    NSLog(@"\n price = %@", _selectedDeal.dealPrice);
    NSLog(@"\n dealFromDate = %@", _selectedDeal.dealFromDate);
    
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
   // NSURL *url = [NSURL URLWithString:stringImageURL];
   // [imageViewDealImage setImageWithURL:url placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
    
    [imageViewDealImage sd_setImageWithURL:[NSURL URLWithString:stringImageURL] placeholderImage:[UIImage imageNamed:@"stKildaPlaceholder.png"]];
}

#pragma mark - Navigation

-(IBAction)backAction:sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)bookDeal:(id)sender
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"DetailsOfDeal"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[_bookDealBTN.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
    
    [self performSegueWithIdentifier:@"bookDeal" sender:self];
    
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   //s NSLog( @" \n \n https://github.com/jverdi/JVFloatLabeledTextField");
}


@end
