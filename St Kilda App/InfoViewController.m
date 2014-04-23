//
//  InfoViewController.m
//  St Kilda App
//
//  Created by Okeito on 3/31/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "InfoViewController.h"
#import "SocialWebViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StKilda_logo.png"]];
    self.stalkUsLabel.font = [UIFont fontWithName:@"BebasNeueBold" size:17];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (IBAction)sendToSocial:(UIButton *)sender
{
    switch ([sender tag])
    {
        case 10:
        {
            _url = [[NSURL alloc] initWithString:@"http://www.facebook.com/stkildanews"];
            [self performSegueWithIdentifier:@"goSocial" sender:self];
            NSLog(@"tag.10 Fb");
            break;
        }
            
        case 11:
        {
            
            _url = [[NSURL alloc] initWithString:@"http://www.twitter.com/stkilda_news"];
            [self performSegueWithIdentifier:@"goSocial" sender:self];
            NSLog(@"tag.11 Twitter");
            break;
        }
            
        case 12:
        {
            _url = [[NSURL alloc] initWithString:@"http://www.stkildanews.com"];
            [self performSegueWithIdentifier:@"goSocial" sender:self];
            NSLog(@"tag.12 SKN");
            break;
        }
            
        case 13:
        {
            NSLog(@"tag.13 feedback");
            [self sendTomail:@"contact@stkildaapp.com" withSubject:@"" withBody:@""];
            break;
        }
        
        default:
            break;
    }

}

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     SocialWebViewController * webSite = segue.destinationViewController;
     webSite.destinationUrl = _url;
     NSLog(@"_url = %@", _url);
 }


-(void)sendTomail:(NSString *)to withSubject:(NSString *)subj withBody:(NSString *)body
{
    NSLog(@"hello");
    NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@",
							[to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]
							];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mailString]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
    }
    else
    {
        NSLog(@"No application for url '%@'", mailString);
    }
}

#pragma mark-MFMailComposer delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    if (MFMailComposeResultSent){
        NSLog(@"Sent!");
    }
    if (MFMailComposeResultSaved) {
        NSLog(@"Mail Saved");
    }
    if (MFMailComposeResultCancelled) {
        NSLog(@"User Cancelled");
    }
    if (MFMailComposeResultFailed) {
        NSLog(@"Send Failed");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
