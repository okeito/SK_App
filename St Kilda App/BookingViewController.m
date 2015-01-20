//
//  BookingViewController.m
//  St Kilda
//
//  Created by Okeito on 4/25/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "BookingViewController.h"

#import "GAIDictionaryBuilder.h"

@interface BookingViewController ()
{
    UITextField * activeField;
}
@end


@implementation BookingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"BookingDealForm"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self registerForKeyboardNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.phoneTextField.delegate = self;
    self.messageTextField.delegate = self;
   // [self.navigationController setNavigationBarHidden:NO animated:YES];
    
   // _nameTextField.returnKeyType = UIReturnKeyDone;
    _emailTextField.returnKeyType = UIReturnKeyDone;
    _phoneTextField.returnKeyType = UIReturnKeyDone;
    _messageTextField.returnKeyType = UIReturnKeyDone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma -mark UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //Notifies the receiver that it has been asked to relinquish
    //its status as first responder in its window.
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)sendMail
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"BookingDealForm"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[_SubmitBookingBTN.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];

    
    if ([MFMailComposeViewController canSendMail])
    {
        NSString *emailBody = [NSString stringWithFormat:
                               @"\n Here is a booking for you, from... \n\n Name: %@ \n email:%@ \n phone: %@ \n message: %@ \n\n",
                               _nameTextField.text,
                               _emailTextField.text,
                               _phoneTextField.text,
                               _messageTextField.text
                               ];
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        mailComposer.navigationBar.barStyle = UIBarStyleBlackTranslucent;

        NSArray *toRecipients = [NSArray arrayWithObjects:@"truellusionist@gmail.com", nil];
        [mailComposer setToRecipients:toRecipients];
        [mailComposer setSubject:@"St Kilda App has a new booking from you!"];
        [mailComposer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailComposer animated:YES completion:nil];
        //[self presentViewController:mailComposer animated:YES completion:nil];
   }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }

}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
