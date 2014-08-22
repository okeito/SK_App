//
//  UICustomLabel.m
//  St Kilda App
//
//  Created by Okeito on 4/2/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "UICustomLabel.h"
#import "NewsViewController.h"

@implementation UICustomLabel

@synthesize topInset, leftInset, bottomInset, rightInset;


- (void)drawTextInRect:(CGRect)rect
{
    UIEdgeInsets insets = {self.topInset, self.leftInset, self.bottomInset, self.rightInset};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setHeadlineLabelText:(NSString *)text
{
//    self.Headline.text = text;
//    self.Headline.font = [UIFont fontWithName:@"BebasNeueBold" size:17];
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
