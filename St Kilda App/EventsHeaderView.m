//
//  EventsHeaderView.m
//  St Kilda App
//
//  Created by Okeito on 4/7/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "EventsHeaderView.h"

@implementation EventsHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




-(void)setDateLabelText:(NSString *)text
{
    self.dateLabel.text = text;
    self.dateLabel.font = [UIFont fontWithName:@"BebasNeueBold" size:18];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
