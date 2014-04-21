//
//  EventsFeedViewController.h
//  St Kilda App
//
//  Created by Okeito on 3/31/14.
//  Copyright (c) 2014 Okeito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"

@interface EventsFeedViewController : UICollectionViewController
{
    NSArray *keyDates;
    
    NSMutableArray * arrayOfEvents;
    NSMutableArray *arrayTableView;
    
    NSMutableArray *arrayOfEventDates;
    
    NSMutableDictionary *dictEventsByDate;
}
@end
