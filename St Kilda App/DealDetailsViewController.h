//
//  DealDetailsViewController.h
//  St Kilda App
//
//  Created by Okeito on 4/19/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deals.h"
#import "DealsViewController.h"

@interface DealDetailsViewController : UIViewController

{

IBOutlet UIImageView *imageViewDealImage;

IBOutlet UILabel *labelHeading;
//IBOutlet UILabel *labelDollar;
//IBOutlet UILabel *labelSymbol;

IBOutlet UILabel *labelValue;
IBOutlet UILabel *labelDiscount;
IBOutlet UILabel *labelYouSave;


IBOutlet UILabel *labelTheBusiness;
IBOutlet UITextView *textViewTheBusiness;


IBOutlet UILabel *labelTheDeal;
IBOutlet UITextView *textViewTheDeal;


IBOutlet UILabel *labelFinePrint;
IBOutlet UITextView *textViewFinePrint;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) Deals * selectedDeal;

-(IBAction)backAction:(id)sender;

-(IBAction)bookDeal:(id)sender;
@end
