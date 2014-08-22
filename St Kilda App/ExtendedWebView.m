//
//  ExtendedWebView.m
//  St Kilda
//
//  Created by Okeito on 8/21/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import "ExtendedWebView.h"


@implementation ExtendedWebView

@synthesize newSize;

-(void)layoutSubviews
{
    [super layoutSubviews];
   // self.scrollView.contentInset = UIEdgeInsetsMake(0,0, 500, 0);
   // self.frame = newSize;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
