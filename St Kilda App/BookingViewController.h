//
//  BookingViewController.h
//  St Kilda
//
//  Created by Okeito on 4/25/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface BookingViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property (weak, nonatomic) IBOutlet UIButton *SubmitBookingBTN;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backAction:(UIButton *)sender;

@end
