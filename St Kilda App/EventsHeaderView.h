//
//  EventsHeaderView.h
//  St Kilda App
//
//  Created by Okeito on 4/7/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsHeaderView : UICollectionReusableView

@property(weak) IBOutlet UILabel *dateLabel;

-(void)setDateLabelText:(NSString *)text;

@end

