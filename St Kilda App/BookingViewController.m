//
//  BookingViewController.m
//  St Kilda
//
//  Created by Okeito on 4/25/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()

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

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
#pragma -mark UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
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
