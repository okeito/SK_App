//
//  InfoViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/31/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface InfoViewController : UIViewController <MFMailComposeViewControllerDelegate>


@property (nonatomic) NSURL* url;
@property (weak, nonatomic) IBOutlet UILabel *stalkUsLabel;
- (IBAction)sendToSocial:(UIButton *)sender;
-(void)sendTomail:(NSString *)to withSubject:(NSString *)subj withBody:(NSString *)body;

@end
