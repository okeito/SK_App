//
//  DealsViewController.h
//  St Kilda App
//
//  Created by Okeito on 4/5/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"

@interface DealsViewController : UICollectionViewController
{
    NSMutableArray *featuredDealsArray;
    NSMutableArray *allDealsArray;
    NSMutableArray *sortedDealsArray;
    NSInteger  numberOfCells;
    
}

-(void)getDealsData;

@end
