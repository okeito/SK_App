//
//  UICustomLabel.h
//  St Kilda App
//
//  Created by Okeito on 4/2/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICustomLabel : UILabel

{
    CGFloat topInset;
    CGFloat leftInset;
    CGFloat bottomInset;
    CGFloat rightInset;
}

@property (nonatomic) CGFloat topInset;
@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat bottomInset;
@property (nonatomic) CGFloat rightInset;


-(void)setHeadlineLabelText:(NSString *)text;


@end
